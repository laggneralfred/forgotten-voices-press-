# Deployment Guide - GitHub Pages

## Option 1: GitHub Pages (Recommended - Free)

**Why GitHub Pages:**
- ✓ Free forever
- ✓ Reliable (GitHub's infrastructure)
- ✓ HTTPS included
- ✓ Fast global CDN
- ✓ Version control built-in
- ✓ Easy updates (just git push)

**Time:** 30 minutes

### Step-by-Step Deployment

#### Step 1: Create GitHub Repository (5 minutes)

1. Go to https://github.com (create account if needed)

2. Click "New repository" (green button)

3. Fill in:
   - **Repository name:** `forgottenvoicespress.com` (or your domain name)
   - **Description:** "Forgotten Voices Press landing page"
   - **Public** (required for free GitHub Pages)
   - **DO NOT** initialize with README (we already have files)

4. Click "Create repository"

#### Step 2: Push Your Code (10 minutes)

In your terminal:

```bash
cd ~/translation-business/forgotten-voices-website

# Initialize git if not already done
git init

# Add all files
git add .

# Create first commit
git commit -m "Initial commit: Forgotten Voices Press landing page"

# Add GitHub as remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/forgottenvoicespress.com.git

# Push to GitHub
git branch -M main
git push -u origin main
```

#### Step 3: Enable GitHub Pages (5 minutes)

1. Go to your repository on GitHub
2. Click "Settings" tab
3. Scroll down to "Pages" in left sidebar
4. Under "Source":
   - Branch: **main**
   - Folder: **/ (root)**
5. Click "Save"

6. Wait 1-2 minutes, then refresh

7. You'll see: "Your site is published at https://YOUR_USERNAME.github.io/forgottenvoicespress.com/"

8. Visit that URL - your site is live!

#### Step 4: Connect Custom Domain (10 minutes)

1. **In Namecheap (or your registrar):**

   Go to Domain List → Manage → Advanced DNS

   Add these records:

   **For apex domain (forgottenvoicespress.com):**
   ```
   Type: A Record
   Host: @
   Value: 185.199.108.153
   TTL: Automatic

   Type: A Record
   Host: @
   Value: 185.199.109.153
   TTL: Automatic

   Type: A Record
   Host: @
   Value: 185.199.110.153
   TTL: Automatic

   Type: A Record
   Host: @
   Value: 185.199.111.153
   TTL: Automatic
   ```

   **For www subdomain:**
   ```
   Type: CNAME Record
   Host: www
   Value: YOUR_USERNAME.github.io
   TTL: Automatic
   ```

2. **In GitHub Pages settings:**

   - Go back to repository Settings → Pages
   - Under "Custom domain", enter: `forgottenvoicespress.com`
   - Click "Save"
   - Check "Enforce HTTPS" (wait 10-15 minutes for certificate)

3. **Wait 15-60 minutes for DNS propagation**

4. **Test:** Visit your domain - it should work!

### Making Updates

Whenever you want to update your site:

```bash
cd ~/translation-business/forgotten-voices-website

# Edit your files
nano index.html

# Commit changes
git add .
git commit -m "Update book launch date"

# Push to GitHub (site updates automatically)
git push
```

Changes go live in 1-2 minutes.

---

## Option 2: Simple Web Hosting (Alternative)

If you prefer traditional hosting:

**Recommended hosts:**
- **Netlify** (easiest): Free tier, drag-and-drop deployment
- **Vercel** (fast): Free tier, git integration
- **DigitalOcean App Platform:** $5/month, more control

### Netlify Deployment (Easiest Alternative)

1. Go to https://netlify.com
2. Sign up (free)
3. Click "Add new site" → "Deploy manually"
4. Drag your `forgotten-voices-website` folder
5. Site goes live immediately at random URL
6. Go to "Domain settings" → "Add custom domain"
7. Follow instructions to connect your domain

**Cost:** Free
**Time:** 10 minutes

---

## Troubleshooting

### GitHub Pages Not Working

**Issue:** 404 error after enabling Pages
**Fix:** Make sure `index.html` is in the root folder (not in a subfolder)

**Issue:** Custom domain shows "Domain not found"
**Fix:** Wait 1-2 hours for DNS propagation, then clear browser cache

**Issue:** HTTPS not working
**Fix:** Wait 15-30 minutes after adding custom domain for certificate

**Issue:** Site not updating after push
**Fix:** Clear browser cache (Ctrl+Shift+R), check GitHub Actions tab

### DNS Issues

**Check DNS propagation:**
- Visit https://dnschecker.org
- Enter your domain
- Check if A records point to GitHub IPs

**Common mistakes:**
- Using GitHub Pages IP instead of GitHub's IPs (use the 4 IPs listed above)
- Forgetting to add www CNAME
- Not removing old DNS records from previous host

---

## Performance Optimization

Your site is already fast, but you can make it even faster:

### 1. Optimize Images

```bash
# Install imagemagick if needed
sudo apt install imagemagick

# Optimize book cover (reduce to 800px width, 85% quality)
convert soap-bubbles-cover.jpg -resize 800x -quality 85 soap-bubbles-cover.jpg

# Optimize Ricarda Huch photo
convert ricarda-huch.jpg -resize 600x -quality 85 ricarda-huch.jpg
```

### 2. Enable Browser Caching

GitHub Pages does this automatically.

### 3. Test Performance

- Google PageSpeed Insights: https://pagespeed.web.dev
- GTmetrix: https://gtmetrix.com

**Target scores:**
- Performance: 95+
- Accessibility: 100
- Best Practices: 100
- SEO: 100

Your simple HTML page should ace all of these.

---

## Security

GitHub Pages automatically provides:
- ✓ HTTPS/SSL certificate (free via Let's Encrypt)
- ✓ DDoS protection
- ✓ CDN (global distribution)
- ✓ No server to hack (static files only)

**Additional security:**
- Don't commit sensitive data (API keys, passwords)
- Use `.gitignore` for local test files
- Review commits before pushing

---

## Monitoring

### Track Your Launch

**Google Analytics** (optional):

1. Create account at https://analytics.google.com
2. Create property for your domain
3. Get tracking code
4. Add to `<head>` section of index.html:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

**Simpler alternative: Plausible Analytics**
- Privacy-friendly (GDPR compliant)
- Lightweight (< 1KB script)
- Beautiful dashboard
- Cost: $9/month (or self-host for free)
- Get tracking code at https://plausible.io

### What to Track

**Pre-launch metrics:**
- Visitors per day
- Email signups (conversion rate)
- Sample chapter downloads
- Time on site
- Traffic sources (where people come from)

**Goal:** 2-5% conversion rate (visitors → email signups)

Example:
- 100 visitors → 2-5 signups is good
- 1000 visitors → 20-50 signups is great

---

## Backup

GitHub IS your backup (version control), but you can also:

```bash
# Clone to another location
git clone https://github.com/YOUR_USERNAME/forgottenvoicespress.com.git ~/backup-website
```

Or simply keep your original files in `~/translation-business/forgotten-voices-website/`

---

## Cost Summary

**GitHub Pages hosting:** $0/year
**Custom domain:** $15/year
**SSL certificate:** $0 (included)
**Email service:** $0 (Mailchimp free tier)

**Total: $15/year**

Compare to:
- Squarespace: $16-49/month ($192-588/year)
- Wix: $16-45/month ($192-540/year)
- WordPress.com: $25-45/month ($300-540/year)

**You save: $177-573/year**

---

## Next Steps

1. Deploy your site following steps above
2. Test thoroughly on mobile and desktop
3. Share with a few friends for feedback
4. Set up Google Analytics (optional)
5. Start driving traffic!

**How to drive traffic:**
- Share in book groups on Facebook
- Post on Goodreads
- Guest post on literary blogs
- Mention in relevant subreddits (r/books, r/literature)
- Email book reviewers
- Connect with German heritage groups

**Goal:** Get 50-100 email signups before launch

---

## Need Help?

**GitHub Pages documentation:**
https://docs.github.com/en/pages

**DNS troubleshooting:**
https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site

**Questions?**
Create an issue in your repository or email me.

**You've got this!**
