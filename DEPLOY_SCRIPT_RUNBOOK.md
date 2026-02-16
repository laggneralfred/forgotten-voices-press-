# Deploy Script Runbook (Nginx + Static)

Script: `deploy-static.sh`

## First run on server

```bash
cd /var/www/forgottenvoices || cd /root
# if script is not on server yet, copy it there first, then:
sudo bash deploy-static.sh --init --disable-apache
```

What this does:
- installs `nginx` and `git`
- backs up `/var/www/html` if present
- clones/pulls site into `/var/www/forgottenvoices`
- writes nginx vhost for `forgottenvoicespress.com`
- enables/restarts nginx
- optionally stops apache (`--disable-apache`)

## Routine deploy (future updates)

```bash
sudo bash deploy-static.sh --deploy
```

## Optional SSL setup via certbot

Only run after DNS points correctly to this server:

```bash
sudo bash deploy-static.sh --deploy --with-ssl
```

## Verify

```bash
curl -I http://forgottenvoicespress.com
curl -I https://forgottenvoicespress.com
nginx -t
systemctl status nginx --no-pager
```

## Rollback note

If WordPress backup was moved during init, it is under `/var/www/backups/`.
