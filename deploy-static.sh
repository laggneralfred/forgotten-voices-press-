#!/usr/bin/env bash
set -euo pipefail

# Static deploy script for forgottenvoicespress.com
# - Installs/updates static site from git
# - Ensures nginx site config
# - Reloads nginx safely
#
# Usage examples:
#   sudo bash deploy-static.sh --init
#   sudo bash deploy-static.sh --deploy
#   sudo bash deploy-static.sh --deploy --disable-apache
#   sudo bash deploy-static.sh --deploy --with-ssl

REPO_URL="https://github.com/laggneralfred/forgotten-voices-press-.git"
BRANCH="main"
APP_DIR="/var/www/forgottenvoices"
DOMAIN="forgottenvoicespress.com"
WWW_DOMAIN="www.forgottenvoicespress.com"
NGINX_SITE_AVAILABLE=""
NGINX_SITE_ENABLED=""

DO_INIT=0
DO_DEPLOY=0
DISABLE_APACHE=0
WITH_SSL=0

log() {
  printf '\n[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}

usage() {
  cat <<USAGE
Usage: sudo bash deploy-static.sh [options]

Options:
  --init              Install dependencies and bootstrap nginx config (first run)
  --deploy            Pull latest code and reload nginx
  --disable-apache    Stop/disable apache2 to avoid :80/:443 conflicts
  --with-ssl          Request/renew certbot nginx cert for domain + www
  --repo-url URL      Override repo URL (default: ${REPO_URL})
  --branch NAME       Override git branch (default: ${BRANCH})
  --app-dir PATH      Override deploy path (default: ${APP_DIR})
  --domain NAME       Override apex domain (default: ${DOMAIN})
  --www-domain NAME   Override www domain (default: ${WWW_DOMAIN})
  -h, --help          Show this help

Examples:
  sudo bash deploy-static.sh --init --disable-apache
  sudo bash deploy-static.sh --deploy
  sudo bash deploy-static.sh --deploy --with-ssl
USAGE
}

require_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    echo "Run as root (use sudo)." >&2
    exit 1
  fi
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --init)
        DO_INIT=1; shift ;;
      --deploy)
        DO_DEPLOY=1; shift ;;
      --disable-apache)
        DISABLE_APACHE=1; shift ;;
      --with-ssl)
        WITH_SSL=1; shift ;;
      --repo-url)
        REPO_URL="${2:-}"; shift 2 ;;
      --branch)
        BRANCH="${2:-}"; shift 2 ;;
      --app-dir)
        APP_DIR="${2:-}"; shift 2 ;;
      --domain)
        DOMAIN="${2:-}"; shift 2 ;;
      --www-domain)
        WWW_DOMAIN="${2:-}"; shift 2 ;;
      -h|--help)
        usage; exit 0 ;;
      *)
        echo "Unknown arg: $1" >&2
        usage
        exit 1
        ;;
    esac
  done

  if [[ $DO_INIT -eq 0 && $DO_DEPLOY -eq 0 ]]; then
    DO_DEPLOY=1
  fi

  NGINX_SITE_AVAILABLE="/etc/nginx/sites-available/${DOMAIN}"
  NGINX_SITE_ENABLED="/etc/nginx/sites-enabled/${DOMAIN}"
}

install_dependencies() {
  log "Installing dependencies (nginx, git)"
  apt update
  apt install -y nginx git

  if [[ $WITH_SSL -eq 1 ]]; then
    log "Installing certbot packages"
    apt install -y certbot python3-certbot-nginx
  fi
}

backup_wordpress_if_present() {
  if [[ -d /var/www/html && ! -L /var/www/html ]]; then
    local backup_dir="/var/www/backups"
    local stamp
    stamp="$(date +%F-%H%M%S)"
    mkdir -p "$backup_dir"
    log "Backing up existing /var/www/html to ${backup_dir}/html-wp-${stamp}"
    mv /var/www/html "${backup_dir}/html-wp-${stamp}"
  fi
}

sync_code() {
  log "Syncing code into ${APP_DIR}"
  if [[ -d "${APP_DIR}/.git" ]]; then
    git -C "$APP_DIR" fetch origin
    git -C "$APP_DIR" checkout "$BRANCH"
    git -C "$APP_DIR" reset --hard "origin/${BRANCH}"
  else
    rm -rf "$APP_DIR"
    git clone --branch "$BRANCH" "$REPO_URL" "$APP_DIR"
  fi
}

set_permissions() {
  log "Setting web permissions"
  chown -R www-data:www-data "$APP_DIR"
  find "$APP_DIR" -type d -exec chmod 755 {} +
  find "$APP_DIR" -type f -exec chmod 644 {} +
}

write_nginx_config() {
  log "Writing nginx vhost config: ${NGINX_SITE_AVAILABLE}"
  cat > "$NGINX_SITE_AVAILABLE" <<NGINX
server {
    listen 80;
    listen [::]:80;
    server_name ${DOMAIN} ${WWW_DOMAIN};

    root ${APP_DIR};
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location ~ /\\. {
        deny all;
    }
}
NGINX

  ln -sf "$NGINX_SITE_AVAILABLE" "$NGINX_SITE_ENABLED"
  rm -f /etc/nginx/sites-enabled/default
}

enable_nginx() {
  log "Testing nginx config"
  nginx -t

  log "Enabling and restarting nginx"
  systemctl enable nginx
  systemctl restart nginx
}

maybe_disable_apache() {
  if [[ $DISABLE_APACHE -eq 1 ]]; then
    if systemctl is-active --quiet apache2; then
      log "Stopping/disabling apache2"
      systemctl disable --now apache2
    fi
  fi
}

maybe_enable_ssl() {
  if [[ $WITH_SSL -eq 1 ]]; then
    log "Requesting/renewing SSL cert via certbot"
    certbot --nginx -d "$DOMAIN" -d "$WWW_DOMAIN" --non-interactive --agree-tos -m "admin@${DOMAIN}" || {
      echo "Certbot failed. Check DNS and retry manually." >&2
      return 1
    }
  fi
}

open_firewall_if_available() {
  if command -v ufw >/dev/null 2>&1; then
    log "Ensuring firewall allows nginx"
    ufw allow 'Nginx Full' || true
  fi
}

main() {
  require_root
  parse_args "$@"

  if [[ $DO_INIT -eq 1 ]]; then
    install_dependencies
    backup_wordpress_if_present
  fi

  sync_code
  set_permissions
  write_nginx_config
  enable_nginx
  maybe_disable_apache
  open_firewall_if_available
  maybe_enable_ssl

  log "Deploy complete"
  log "Try: curl -I http://${DOMAIN}"
  log "Try: curl -I https://${DOMAIN}"
}

main "$@"
