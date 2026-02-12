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
- `ricarda-huch/women-in-her-era.html`
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

1. Create a new file in `articles/`, e.g. `articles/new-topic.html`.
2. Copy the structure of an existing article page and update:
   - `<title>` + meta description
   - breadcrumb
   - tags (`<span class="tag">`)
   - H1, body copy, related links
3. Add the article card to `articles/index.html`:
   - add `data-tags="..."` for filter behavior
   - add title/excerpt/link card
4. Optionally link it from `index.html` featured grid.
5. Add URL to `sitemap.html` and `sitemap.xml`.

## Local testing

Open `index.html` directly in a browser, or serve folder with any static server.

Check:
- mobile menu toggle
- article filter buttons
- form action URLs
- internal links between pages

## Deployment notes

This directory is static-output ready. Upload all files while preserving folder structure.

