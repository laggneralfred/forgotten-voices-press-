# Forgotten Voices Press Static Site

Modern static website for the **Soap Bubbles** collection and the **Ricarda Huch** context hub.

## Stack

- Static HTML/CSS/JS only
- No build step required
- Deployable from this folder as-is

## Site structure

- `index.html` - Home / landing page
- `soap-bubbles/index.html` - Collection guide
- `ricarda-huch/index.html` - Author hub
- `ricarda-huch/germany-legacy.html`
- `articles/woman-in-her-era.html`
- `ricarda-huch/reported-nominations.html`
- `ricarda-huch/why-it-matters-us.html`
- `ricarda-huch/author-and-historian.html`
- `articles/index.html` - Article index with JS filters
- `articles/*.html` - Individual articles with related links
- `thank-you.html` - Signup follow-up page
- `sitemap.html`, `sitemap.xml`
- `sources.md` - citation TODO list
- `assets/css/site.css` - shared design system
- `assets/js/site.js` - mobile nav + article filtering

## Existing media reused

- `soap-bubbles-cover.jpg`
- `ricarda-huch.jpg`
- `terra-laggner.jpg`

## Mailchimp signup notes

The forms post directly to Mailchimp endpoints (no forced JS redirects, no `no-cors` fetch workaround).

- Home form is in `index.html`.
- Users can continue to `thank-you.html` after subscribing.

## Edit content quickly

- Home hero and CTAs: `index.html`
- Collection copy: `soap-bubbles/index.html`
- Author context pages: `ricarda-huch/*.html`
- Article listings + filter tags: `articles/index.html`
- Shared style tokens: `assets/css/site.css`

## How to add a new article

Use the generator script (recommended):

```bash
bash scripts/new-article.sh \
  --title "Your Article Title" \
  --excerpt "One-sentence summary shown on article cards." \
  --tags "method,legacy"
```

What it does automatically:
- creates `articles/<slug>.html` from `templates/article-template.html`
- inserts the new article card in `articles/index.html`
- adds entries to `sitemap.html` and `sitemap.xml`

After running:
1. Edit the new article file and replace placeholder body content.
2. Commit and push `main`.

## Local testing

Open `index.html` directly in a browser, or serve folder with any static server.

Check:
- mobile menu toggle
- article filter buttons
- form action URLs
- internal links between pages

## Deployment notes

This directory is static-output ready. Upload all files while preserving folder structure.

## Automated production deploy (GitHub Actions)

Workflow file:
- `.github/workflows/deploy-production.yml`

Trigger:
- automatic on push to `main`
- manual via Actions "Run workflow"

Required GitHub repository secrets:
- `PROD_HOST` (example: `164.90.168.15`)
- `PROD_PORT` (example: `22`)
- `PROD_USER` (example: `root`)
- `PROD_SSH_KEY` (private key with access to server)

Deploy target:
- syncs repo contents to `/var/www/html` via `rsync --delete`
- applies web permissions
- runs `apache2ctl configtest`
- reloads Apache
