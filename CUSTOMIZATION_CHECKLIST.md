# Website Customization Checklist

## Required Changes in index.html

### 1. Update Launch Date
**Location:** Line 408
**Current:** `First Book: Launching February 2026`
**Change to:** Your actual launch date (e.g., "March 2026", "Spring 2026", or specific date)

### 2. Update Email Address
**Location:** Line 561
**Current:** `hello@forgottenvoicespress.com`
**Change to:** Your actual email address

---

## How to Make These Changes

### Option 1: Using nano (Simple)
```bash
cd ~/translation-business/forgotten-voices-website
nano index.html

# Use Ctrl+W to search for "February 2026"
# Replace with your launch date
# Use Ctrl+W again to search for "hello@forgottenvoicespress.com"
# Replace with your email
# Press Ctrl+X, then Y, then Enter to save
```

### Option 2: Using sed (Quick Command)
```bash
cd ~/translation-business/forgotten-voices-website

# Update launch date (replace "March 2026" with your date)
sed -i 's/February 2026/March 2026/g' index.html

# Update email (replace with your actual email)
sed -i 's/hello@forgottenvoicespress\.com/your-email@example.com/g' index.html

# Verify changes
grep -n "2026\|@" index.html | head -10
```

### Option 3: Using VS Code or your favorite editor
```bash
cd ~/translation-business/forgotten-voices-website
code index.html  # or vim, emacs, etc.
```
Then search (Ctrl+F) for the text you need to change.

---

## Optional Changes

### 3. Add Your Name as Translator (Optional)
If you want credit on the site, you can add your name to the book description.

**Look for:** The section about Soap Bubbles book (around line 200-300)
**Add:** "Translated by [Your Name]" to the book description

### 4. Customize Colors (Optional)
**Location:** Lines 27-33 (CSS variables)
```css
:root {
    --primary-color: #2c3e50;      /* Dark blue-gray (header, text) */
    --accent-color: #c9926e;        /* Warm copper (highlights) */
    --text-color: #333;             /* Main text color */
    --light-bg: #f8f6f3;           /* Cream background */
    --white: #ffffff;               /* White */
}
```

Change these hex codes to customize the color scheme.

### 5. Update Social Media Meta Tags (Optional)
**Location:** Lines 10-13
If you have specific social media images or want to customize how the site looks when shared:
```html
<meta property="og:image" content="your-social-image.jpg">
<meta property="og:description" content="Your custom description">
```

---

## After Making Changes

### Test Locally
```bash
cd ~/translation-business/forgotten-voices-website

# Open in browser to preview
xdg-open index.html              # Linux
explorer.exe index.html          # WSL
open index.html                  # Mac
```

### Check These Things:
- ✓ Launch date is correct and makes sense
- ✓ Email address is correct (test clicking it - does it open your email?)
- ✓ All text reads naturally
- ✓ Images display (if you've added them)
- ✓ Mobile view looks good (resize browser window)

### Commit Changes
```bash
cd ~/translation-business/forgotten-voices-website

git add index.html
git commit -m "Customize launch date and email"

# If you've set up GitHub remote:
git push
```

---

## Validation

Run these commands to verify your changes:

```bash
cd ~/translation-business/forgotten-voices-website

# Check launch date was updated
echo "Launch date:"
grep -i "launching" index.html

# Check email was updated
echo "Email address:"
grep -i "mailto:" index.html

# Make sure images exist
echo "Images:"
ls -lh *.jpg 2>/dev/null || echo "No images yet - add soap-bubbles-cover.jpg and ricarda-huch.jpg"
```

---

## Quick Reference

**Two must-change items:**
1. Launch date (line 408): `February 2026` → Your date
2. Email (line 561): `hello@forgottenvoicespress.com` → Your email

**Everything else is optional.**

Once these are done, you're ready to deploy!

---

## Next Step

After customizing, proceed to:
1. **MAILCHIMP_SETUP.md** - Set up email capture (30 min)
2. **DEPLOYMENT.md** - Deploy to GitHub Pages (30 min)

Or skip Mailchimp for now and deploy right away - you can add email capture later.
