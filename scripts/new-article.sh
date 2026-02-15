#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_FILE="${ROOT_DIR}/templates/article-template.html"
ARTICLES_DIR="${ROOT_DIR}/articles"
ARTICLES_INDEX="${ROOT_DIR}/articles/index.html"
SITEMAP_HTML="${ROOT_DIR}/sitemap.html"
SITEMAP_XML="${ROOT_DIR}/sitemap.xml"
DOMAIN="https://forgottenvoicespress.com"

TITLE=""
SLUG=""
EXCERPT=""
TAGS="method"
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage:
  scripts/new-article.sh --title "Your Title" --excerpt "Short card summary" [--tags "method,legacy"] [--slug "custom-slug"] [--dry-run]

Examples:
  scripts/new-article.sh --title "How to Start with Huch" --excerpt "A practical first-reading path." --tags "method,us"
  scripts/new-article.sh --title "Archive Note" --excerpt "Quick note for readers." --slug "archive-note" --tags "legacy"
USAGE
}

to_slug() {
  local s
  s="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  s="$(printf '%s' "$s" | sed -E "s/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g")"
  printf '%s' "$s"
}

trim() {
  printf '%s' "$1" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//'
}

tag_to_label() {
  case "$1" in
    legacy) printf 'Legacy' ;;
    gender) printf 'Gender' ;;
    us) printf 'U.S. relevance' ;;
    collection) printf 'Collection' ;;
    method) printf 'Method' ;;
    *) printf '%s' "$(printf '%s' "$1" | sed -E 's/-/ /g; s/\b([a-z])/\U\1/g')" ;;
  esac
}

escape_sed_replacement() {
  printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

require_file() {
  if [[ ! -f "$1" ]]; then
    echo "Missing required file: $1" >&2
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title)
      TITLE="${2:-}"
      shift 2
      ;;
    --slug)
      SLUG="${2:-}"
      shift 2
      ;;
    --excerpt)
      EXCERPT="${2:-}"
      shift 2
      ;;
    --tags)
      TAGS="${2:-}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

TITLE="$(trim "$TITLE")"
EXCERPT="$(trim "$EXCERPT")"
TAGS="$(trim "$TAGS")"

if [[ -z "$TITLE" || -z "$EXCERPT" ]]; then
  echo "--title and --excerpt are required." >&2
  usage
  exit 1
fi

if [[ -z "$SLUG" ]]; then
  SLUG="$(to_slug "$TITLE")"
fi

if [[ -z "$SLUG" ]]; then
  echo "Could not derive a valid slug from title." >&2
  exit 1
fi

require_file "$TEMPLATE_FILE"
require_file "$ARTICLES_INDEX"
require_file "$SITEMAP_HTML"
require_file "$SITEMAP_XML"

ARTICLE_FILE="${ARTICLES_DIR}/${SLUG}.html"
if [[ -e "$ARTICLE_FILE" ]]; then
  echo "Article already exists: ${ARTICLE_FILE}" >&2
  exit 1
fi

if rg -n "href=\"${SLUG}\.html\"" "$ARTICLES_INDEX" >/dev/null 2>&1; then
  echo "Articles index already references ${SLUG}.html" >&2
  exit 1
fi

IFS=',' read -r -a TAG_ARRAY <<< "$TAGS"
DATA_TAGS=""
TAG_BADGES=""
for raw_tag in "${TAG_ARRAY[@]}"; do
  tag="$(to_slug "$(trim "$raw_tag")")"
  [[ -z "$tag" ]] && continue
  label="$(tag_to_label "$tag")"
  if [[ -z "$DATA_TAGS" ]]; then
    DATA_TAGS="$tag"
    TAG_BADGES="<span class=\"tag\">${label}</span>"
  else
    DATA_TAGS="${DATA_TAGS} ${tag}"
    TAG_BADGES="${TAG_BADGES} <span class=\"tag\">${label}</span>"
  fi
done

if [[ -z "$DATA_TAGS" ]]; then
  DATA_TAGS="method"
  TAG_BADGES="<span class=\"tag\">Method</span>"
fi

PAGE_TITLE="${TITLE} | Forgotten Voices Press"
BREADCRUMB_TITLE="${TITLE}"
H1_TITLE="${TITLE}"
INTRO_PARAGRAPH="${EXCERPT}"
META_DESCRIPTION="Article: ${EXCERPT}"

TMP_ARTICLE="$(mktemp)"
cp "$TEMPLATE_FILE" "$TMP_ARTICLE"
sed -i \
  -e "s/__PAGE_TITLE__/$(escape_sed_replacement "$PAGE_TITLE")/g" \
  -e "s/__META_DESCRIPTION__/$(escape_sed_replacement "$META_DESCRIPTION")/g" \
  -e "s/__BREADCRUMB_TITLE__/$(escape_sed_replacement "$BREADCRUMB_TITLE")/g" \
  -e "s/__H1_TITLE__/$(escape_sed_replacement "$H1_TITLE")/g" \
  -e "s/__TAG_BADGES__/$(escape_sed_replacement "$TAG_BADGES")/g" \
  -e "s/__INTRO_PARAGRAPH__/$(escape_sed_replacement "$INTRO_PARAGRAPH")/g" \
  "$TMP_ARTICLE"

CARD_BLOCK=$(cat <<EOF
        <article class="card" data-tags="${DATA_TAGS}">
          <p>${TAG_BADGES}</p>
          <h3><a href="${SLUG}.html">${TITLE}</a></h3>
          <p class="meta">${EXCERPT}</p>
        </article>

EOF
)

SITEMAP_HTML_LINE="  <li><a href=\"articles/${SLUG}.html\">Article: ${TITLE}</a></li>"
SITEMAP_XML_LINE="  <url><loc>${DOMAIN}/articles/${SLUG}.html</loc></url>"

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "[DRY RUN] Would create: ${ARTICLE_FILE}"
  echo "[DRY RUN] Would add card to: ${ARTICLES_INDEX}"
  echo "[DRY RUN] Would add line to: ${SITEMAP_HTML}"
  echo "[DRY RUN] Would add URL to: ${SITEMAP_XML}"
  rm -f "$TMP_ARTICLE"
  exit 0
fi

mv "$TMP_ARTICLE" "$ARTICLE_FILE"

awk -v block="$CARD_BLOCK" '
  { print }
  /<!-- ARTICLE_CARDS_START -->/ { printf "%s", block }
' "$ARTICLES_INDEX" > "${ARTICLES_INDEX}.tmp" && mv "${ARTICLES_INDEX}.tmp" "$ARTICLES_INDEX"

awk -v line="$SITEMAP_HTML_LINE" '
  { print }
  /<!-- ARTICLE_LINKS_START -->/ { print line }
' "$SITEMAP_HTML" > "${SITEMAP_HTML}.tmp" && mv "${SITEMAP_HTML}.tmp" "$SITEMAP_HTML"

awk -v line="$SITEMAP_XML_LINE" '
  { print }
  /<!-- ARTICLE_URLS_START -->/ { print line }
' "$SITEMAP_XML" > "${SITEMAP_XML}.tmp" && mv "${SITEMAP_XML}.tmp" "$SITEMAP_XML"

echo "Created: ${ARTICLE_FILE}"
echo "Updated: ${ARTICLES_INDEX}"
echo "Updated: ${SITEMAP_HTML}"
echo "Updated: ${SITEMAP_XML}"
echo "Next: edit ${ARTICLE_FILE} content, then commit + push main."
