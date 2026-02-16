# Forgotten Voices Press - Server Access (Redacted)

Last Updated: February 12, 2026

This document intentionally excludes secrets and direct privileged credentials.

## Live Service
- Main URL: https://forgottenvoicespress.com
- WWW URL: https://www.forgottenvoicespress.com
- Thank-you page: https://forgottenvoicespress.com/thank-you.html
- Status: LIVE

## Access Policy
- Do not commit:
  - passwords
  - private keys
  - token values
  - direct root connection strings containing sensitive paths
- Store all credentials in a secure password manager or vault.
- Rotate credentials immediately if they ever appear in git history.

## Safe Deployment Procedure
1. Edit local files in `forgotten-voices-website/`.
2. Validate pages locally.
3. Deploy using your approved secure ops workflow.
4. Verify homepage, forms, and assets on production.

## Post-Deploy Checks
- Homepage loads and key sections render.
- Mailchimp forms submit to correct audience/form endpoint.
- `thank-you.html` is reachable.
- Images load:
  - `soap-bubbles-cover.jpg`
  - `ricarda-huch.jpg`
  - `terra-laggner.jpg`
- SSL certificate is valid.

## Incident Response
If secrets were previously committed:
1. Rotate all affected credentials.
2. Move secrets to vault/password manager.
3. Rewrite git history if required by your security policy.
4. Re-run deployment verification.

## TODO
- Add final Zero and Aces cover asset and remove placeholder panel.
- Keep copy/date references current (avoid stale month-year launch text).
