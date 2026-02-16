# Forgotten Voices Press Website - Current Status

Last Updated: February 12, 2026
Status: LIVE (Operational) - Cleanup Pass Completed

## Current State
- Website is live at `https://forgottenvoicespress.com`.
- Core static site is in place (`index.html`, `thank-you.html`, images).
- Mailchimp forms are connected in `index.html`.
- Cleanup completed for sensitive documentation exposure.

## Cleanup Run Completed
- Removed hardcoded credential material from repo docs.
- Replaced sensitive ops docs with redacted versions:
  - `DEPLOYMENT_COMPLETE.txt`
  - `SERVER_ACCESS.md`
- Simplified signup behavior to avoid false success redirects:
  - removed client-side `fetch(..., no-cors)` + forced redirect logic.
  - forms now submit directly to Mailchimp endpoint.
- Updated stale hero launch badge text in `index.html`.

## Open Items (Next Actions)
1. Replace the Zero and Aces "Cover Coming Soon" placeholder with final cover art.
2. Validate real subscription flow end-to-end in production:
   - submit test email
   - confirm contact appears in Mailchimp audience
   - verify user-facing messaging is accurate.
3. Review copy for date-sensitive claims monthly.
4. If prior repo exposure included real credentials, ensure all affected secrets are rotated.

## Quick Verification Checklist
- [ ] Homepage loads on desktop/mobile.
- [ ] Main nav anchors work (`#book`, `#about`, `#mission`, `#signup`).
- [ ] Images render with no broken links.
- [ ] Email forms post successfully to Mailchimp.
- [ ] `thank-you.html` loads directly.
- [ ] SSL certificate is valid.
