# Mailchimp Setup Guide

## Step-by-Step Integration (60 minutes)

### Part 1: Create Mailchimp Account (10 minutes)

1. Go to https://mailchimp.com
2. Click "Sign Up Free"
3. Create account with your email
4. Verify email address
5. Complete basic setup (company name, address, etc.)

**Free tier limits:**
- 500 subscribers
- 1,000 sends per month
- This is MORE than enough for pre-launch

### Part 2: Create Your Audience (5 minutes)

1. Click "Audience" in left menu
2. Click "Audience dashboard"
3. Click "Manage Audience" → "Settings"
4. Fill in:
   - **Audience name:** Forgotten Voices Press Readers
   - **Default from email:** your-email@domain.com
   - **Default from name:** Forgotten Voices Press
   - **Reminder of how they signed up:** "You signed up to receive updates about new literary translations and our first book launch."

5. Add your mailing address (required by law)

### Part 3: Create Signup Form (15 minutes)

1. Go to "Audience" → "Signup forms"
2. Click "Embedded forms"
3. Select "Classic" style
4. Customize the form:
   - **Required fields:** Email only (remove first name, last name for now)
   - **Optional fields:** None for now (keep it simple)
   - **Button text:** "Send Me the Sample"
   - **Success message:** "Check your email! Your sample chapter is on its way."

5. **Copy the embedded code**

6. **Paste into your index.html:**

Find this section (appears twice):
```html
<!-- Mailchimp form will go here -->
<form class="email-form" action="#" method="post">
    <input type="email" name="EMAIL" placeholder="Enter your email address" required>
    <button type="submit" class="btn">Send Me the Sample</button>
</form>
```

Replace BOTH instances with your Mailchimp code, BUT keep the CSS classes.

**Example Mailchimp code** (yours will be different):
```html
<form action="https://forgottenvoicespress.us1.list-manage.com/subscribe/post?u=abc123&id=xyz789"
      method="post"
      class="email-form"
      target="_blank">
    <input type="email" name="EMAIL" placeholder="Enter your email address" required class="email-input">
    <button type="submit" class="btn">Send Me the Sample</button>

    <!-- Real people should not fill this in -->
    <div style="position: absolute; left: -5000px;" aria-hidden="true">
        <input type="text" name="b_abc123_xyz789" tabindex="-1" value="">
    </div>
</form>
```

**Important:** Keep your CSS classes (`email-form`, `btn`) so styling works!

### Part 4: Upload Sample Chapter PDF (10 minutes)

1. Export your sample chapter as PDF
   - Title: "Soap Bubbles - Sample Chapter - Ricarda Huch.pdf"
   - Keep file size under 5MB

2. Go to "Audience" → "Signup forms" → "Form builder"
3. Scroll down to "After signup confirmation"
4. Click "Let them download a file"
5. Upload your PDF
6. Save

**Alternative:** Host PDF on Google Drive/Dropbox, get shareable link

### Part 5: Create Automated Email Sequence (30 minutes)

1. Go to "Automations" in left menu
2. Click "Create" → "Custom"
3. Name it: "New Subscriber Welcome Series"
4. Trigger: "When someone subscribes to your audience"

**Now create 4 emails:**

#### Email 1: Welcome + Sample Chapter (Send immediately)

**Subject:** Your sample chapter from Soap Bubbles is here

**Preview text:** Plus: Who was Ricarda Huch and why does she matter?

**Body:** (See EMAIL_SEQUENCE.md for full templates)

```
Hello!

Thank you for joining the Forgotten Voices Press readers' circle.

Your sample chapter from Ricarda Huch's "Soap Bubbles" is attached to this email [OR: Click here to download it].

This is the opening of "The Governess," the first of three satirical novellas that showcase Huch's wit, psychological insight, and keen eye for the absurdities of early 20th century German society.

I think you're going to love it.

Best,
Alfred
Forgotten Voices Press

P.S. Ricarda Huch was once called "Germany's first lady of letters" by Thomas Mann. Yet today, outside Germany, she's nearly forgotten. We're changing that.
```

#### Email 2: About Ricarda Huch (3 days later)

**Subject:** The writer Thomas Mann compared to Goethe

See EMAIL_SEQUENCE.md for full template.

#### Email 3: Translation Philosophy (7 days later)

**Subject:** What makes a great literary translation?

See EMAIL_SEQUENCE.md for full template.

#### Email 4: Launch Announcement (On launch day - schedule manually)

**Subject:** Soap Bubbles is finally here

See EMAIL_SEQUENCE.md for full template.

### Part 6: Test Your Setup (10 minutes)

1. Open your website in incognito/private window
2. Sign up with a test email (use Gmail+ trick: youremail+test@gmail.com)
3. Check that:
   - You receive welcome email immediately
   - Sample chapter link works
   - Unsubscribe link works
   - Email looks good on mobile

4. Check Mailchimp dashboard:
   - Subscriber appears
   - Automation triggered

### Part 7: Configure Email Settings

**Important settings to check:**

1. **Audience** → **Settings** → **Audience name and defaults**
   - Set "From" name to: Forgotten Voices Press
   - Set reply-to to your real email

2. **Audience** → **Settings** → **Audience fields and *|MERGE|* tags**
   - Keep EMAIL only (simplest for now)

3. **Account** → **Settings** → **Tracking**
   - Enable "Track opens"
   - Enable "Track clicks"

## Troubleshooting

**Form not working?**
- Check that you copied the FULL form code including the hidden honeypot field
- Verify the action URL is correct
- Test in incognito window

**Emails going to spam?**
- Verify your domain with Mailchimp (optional but helps)
- Use your real business address in footer
- Avoid spam trigger words (free, urgent, click here, etc.)

**Sample chapter not delivering?**
- Check file size (must be under 25MB)
- Alternative: Host on Google Drive and include link in email

## Analytics

Track these metrics in Mailchimp dashboard:

- **Signup rate:** How many people visit vs. subscribe
- **Open rate:** Aim for 40-60% for first email
- **Click rate:** Aim for 10-20% on sample chapter link
- **Unsubscribe rate:** Should be under 2%

## Next Steps

Once you have 25+ subscribers, you can:
- Segment your list (launch day, post-launch, etc.)
- A/B test subject lines
- Send updates about translation progress
- Build anticipation for launch

## Cost Reminder

**Mailchimp free tier:**
- 500 subscribers (plenty for pre-launch)
- 1,000 emails/month

**When you hit 501 subscribers:**
- Essentials plan: $13/month for 500-1,000 subscribers
- Still very affordable

**You'll likely stay free until after launch.**
