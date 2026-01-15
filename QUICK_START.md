# Quick Start - Get Your Site Live Today

You're almost done! The website is built. Now you just need:
1. Images (book cover + author photo)
2. Customize a few details
3. Deploy

**Estimated time: 2-4 hours**

---

## Step 1: Get Ricarda Huch Photo (15 minutes)

### Option A: Download Manually (Recommended)

1. **Visit Wikimedia Commons:**
   - Go to: https://commons.wikimedia.org/wiki/Category:Ricarda_Huch
   - Browse the portrait photos available
   - Recommended: Look for formal portraits from 1920s-1930s

2. **Download your favorite:**
   - Click on a photo you like
   - Click "More details" to see full resolution
   - Right-click → "Save image as..."
   - Save to your Downloads folder

3. **Move to website folder:**
   ```bash
   cd ~/translation-business/forgotten-voices-website

   # Copy your downloaded image (adjust path as needed)
   cp ~/Downloads/[your-downloaded-image].jpg ./ricarda-huch-original.jpg

   # Resize and optimize
   convert ricarda-huch-original.jpg -resize 600x -quality 85 ricarda-huch.jpg

   # Verify
   ls -lh ricarda-huch.jpg
   ```

### Option B: Use a Specific Photo

I recommend the formal portrait from around 1928 (she was an established author by then). It shows her with dignity and gravitas appropriate for a serious literary figure.

If you need help finding a specific image, let me know which style you prefer:
- Younger Ricarda (1890s-1900s) - closer to when she wrote Soap Bubbles
- Mature Ricarda (1920s-1930s) - established author, more recognizable

---

## Step 2: Get Book Cover (1-3 hours)

You have several options:

### Option A: Create in Canva (Easiest - 1 hour)

1. Go to https://canva.com (free account)
2. Search "Book Cover" templates
3. Choose a minimalist/literary style
4. Customize:
   - Title: **Soap Bubbles**
   - Author: **Ricarda Huch**
   - Translator: **Translated by [Your Name]**
   - Add soap bubble imagery (search Canva's library)
5. Download as JPG (800px width minimum)
6. Save as `soap-bubbles-cover.jpg` in the website folder

**Design tips:**
- Art Nouveau/Jugendstil style (matches the 1905 publication)
- Soft, elegant colors (pastels, blues, purples)
- Soap bubble imagery (ethereal, delicate)
- Clear, readable typography

### Option B: Commission on Fiverr (Professional - 2-5 days)

1. Go to Fiverr.com
2. Search "literary book cover design"
3. Find designer ($10-50 range)
4. Provide brief:
   - Title: Soap Bubbles
   - Author: Ricarda Huch (German, 1864-1947)
   - Genre: Literary fiction, German literature, 1905
   - Style: Art Nouveau/elegant/minimalist
   - Add: "Translated by [Your Name]"
   - Deliver as JPG, 800x1200px minimum

### Option C: Use Placeholder (For Now)

Launch with a simple placeholder, swap in real cover later:

```bash
cd ~/translation-business/forgotten-voices-website

# Create simple placeholder
convert -size 800x1200 \
  -background '#E8F4F8' \
  -fill '#2C3E50' \
  -gravity center \
  -pointsize 72 -font Arial-Bold \
  -draw "text 0,-200 'Soap Bubbles'" \
  -pointsize 48 \
  -draw "text 0,-100 'Ricarda Huch'" \
  -pointsize 36 \
  -draw "text 0,100 'Coming Soon'" \
  soap-bubbles-cover.jpg
```

This gives you a clean placeholder so you can launch now and update later.

---

## Step 3: Customize Website Content (15 minutes)

Open `index.html` and update:

### Search and replace these:

1. **Launch date** - Find: `February 2026`
   - Replace with your actual launch date (e.g., "March 2026", "Spring 2026")

2. **Email** - Find: `hello@forgottenvoicespress.com`
   - Replace with your actual email

3. **Translator name** (optional) - Find: `Translated by [Your Name]`
   - Add your name if you want credit visible

### Quick command:

```bash
cd ~/translation-business/forgotten-voices-website

# Open in editor
nano index.html

# Or use your preferred editor:
code index.html   # VS Code
vim index.html    # Vim
```

Just search (Ctrl+F) for the items above and update them.

---

## Step 4: Test Locally (5 minutes)

```bash
cd ~/translation-business/forgotten-voices-website

# Open in browser (Ubuntu)
xdg-open index.html

# Or on WSL with Windows browser
explorer.exe index.html

# Or manually open forgotten-voices-website/index.html in any browser
```

**Check:**
- ✓ Book cover displays correctly
- ✓ Ricarda Huch photo displays
- ✓ Launch date is correct
- ✓ Email is correct
- ✓ Looks good on mobile (resize browser window)

---

## Step 5: Set Up Mailchimp (30 minutes)

Follow the detailed guide in `MAILCHIMP_SETUP.md`.

**Quick summary:**
1. Create free Mailchimp account
2. Create audience/list
3. Create embedded form
4. Copy form code
5. Replace placeholder in `index.html`
6. Test email signup

**Skip this for now?** You can launch without email capture and add it later. The form will just show a placeholder.

---

## Step 6: Deploy to GitHub Pages (30 minutes)

Follow the detailed guide in `DEPLOYMENT.md`.

**Quick summary:**

```bash
cd ~/translation-business/forgotten-voices-website

# Make sure everything is ready
git status

# Stage all files
git add .

# Commit
git commit -m "Add website with images and customizations"

# Push to GitHub
git push origin main

# Then enable GitHub Pages in repo settings
```

**Your site will be live at:**
`https://YOUR_USERNAME.github.io/forgotten-voices-website/`

---

## Step 7: Optional - Custom Domain

If you buy a domain (e.g., `forgottenvoicespress.com` from Namecheap for $15/year):

1. Follow DNS setup in `DEPLOYMENT.md`
2. Point domain to GitHub Pages
3. Enable HTTPS in GitHub settings

**Total annual cost with domain: $15**
**Without custom domain: $0**

---

## Timeline Options

### Option 1: Launch Today (Placeholder Cover)
- Hour 1: Get Ricarda Huch photo, customize content
- Hour 2: Create placeholder cover, test locally
- Hour 3: Deploy to GitHub Pages
- Hour 4: Set up Mailchimp, polish

**Result:** Live site today with placeholder, swap cover later

### Option 2: Launch This Week (Canva Cover)
- Day 1: Get images, customize content
- Day 2: Design cover in Canva (take your time)
- Day 3: Set up Mailchimp, deploy, test

**Result:** Professional site in 3 days

### Option 3: Launch Next Week (Professional Cover)
- Day 1-2: Commission cover on Fiverr
- Day 3-5: Designer works on cover
- Day 6: Get images, customize, deploy
- Day 7: Set up Mailchimp, polish, launch

**Result:** Highest quality site in 7 days

---

## Need Help?

**Stuck on images?**
→ See `IMAGE_SOURCING_GUIDE.md`

**Stuck on deployment?**
→ See `DEPLOYMENT.md`

**Stuck on email?**
→ See `MAILCHIMP_SETUP.md`

**Want to see email templates?**
→ See `EMAIL_SEQUENCE.md`

**Want Amazon tips?**
→ See `AMAZON_OPTIMIZATION.md`

---

## What You'll Have When Done

✅ Beautiful, responsive landing page
✅ Email capture for building audience
✅ Professional presentation of your translation
✅ Free hosting forever (GitHub Pages)
✅ Easy to update (just edit HTML and push)

**Total cost: $0-15/year** (depending on whether you buy a custom domain)

---

## Current Status

✅ Website built (HTML, CSS, design)
✅ Documentation complete
✅ Deployment guides ready
⏳ **YOU ARE HERE** → Add images
⏳ Customize content
⏳ Deploy to GitHub Pages
⏳ Set up email capture

**You're 70% done! Just add the finishing touches and launch.**

---

## Questions?

Just ask! I can help with:
- Finding specific Ricarda Huch photos
- Creating placeholder images
- Customizing the design
- Deployment troubleshooting
- Email setup
- Anything else

**Let's get your site live!**
