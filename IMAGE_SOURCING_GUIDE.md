# Image Sourcing Guide

## What You Need

1. **Book cover image**: `soap-bubbles-cover.jpg` (600-800px width)
2. **Author photo**: `ricarda-huch.jpg` (400-600px width)

Both files should be placed in the `forgotten-voices-website/` directory.

---

## Option 1: Book Cover - Design Your Own

### Quick Options (30-60 minutes):

**A. Use Canva (Free)**
1. Go to https://canva.com
2. Search for "Book Cover" templates
3. Choose a literary/minimalist design
4. Customize with:
   - Title: "Soap Bubbles"
   - Author: "Ricarda Huch"
   - Translator: "Translated by [Your Name]"
   - Add soap bubble imagery (search Canva's free photos)
5. Download as JPG (800px width)
6. Save as `soap-bubbles-cover.jpg`

**B. Use Free Design Tools**
- **Reedsy Book Cover Creator**: https://reedsy.com/design/book-cover-maker (very simple)
- **DIY Book Covers**: https://diybookcovers.com (premade templates)

**C. Commission on Fiverr**
- Cost: $10-50
- Time: 2-5 days
- Search: "literary book cover design"
- Provide: title, author, translator, style preference (art nouveau/minimalist)

### Design Tips:
- Keep it simple and elegant (this is literary fiction)
- Art Nouveau/Jugendstil style fits the era (1905)
- Soap bubble imagery works well (ethereal, delicate)
- Muted, sophisticated colors
- Clear, readable typography

---

## Option 2: Book Cover - Use AI Generation

**Midjourney/Stable Diffusion Prompt:**
```
Book cover design for "Soap Bubbles" by Ricarda Huch,
art nouveau style, elegant soap bubbles floating,
soft pastels, literary fiction aesthetic, minimalist,
vintage 1905 German literature feel, sophisticated typography
```

**Then add text overlay** using:
- Canva
- GIMP (free Photoshop alternative)
- Affinity Publisher ($70, one-time)

---

## Ricarda Huch Author Photo

### Public Domain Sources:

**1. Wikimedia Commons (Best)**
- Go to: https://commons.wikimedia.org/wiki/Ricarda_Huch
- Select a portrait photo
- Download highest resolution
- Crop to square or portrait orientation
- Save as `ricarda-huch.jpg`

**2. German Digital Library**
- https://www.deutsche-digitale-bibliothek.de
- Search: "Ricarda Huch Porträt"
- Filter by "Freie Nutzung" (free use)

**3. German National Library**
- https://www.dnb.de
- Search: "Ricarda Huch"
- Look for biographical images

### Photo Requirements:
- Should be dignified, professional portrait
- Black and white or sepia tone works well
- Clear face, appropriate for author bio
- Public domain (Ricarda Huch died 1947, so most photos are PD)
- 400-600px width is sufficient

### Recommended Photo:
Look for her formal portrait from the 1920s-1930s - shows her as an established author, which fits the gravitas of her work.

---

## Quick Command to Add Images

Once you have both images ready:

```bash
cd ~/translation-business/forgotten-voices-website

# Copy your images here
# They should be named:
# - soap-bubbles-cover.jpg
# - ricarda-huch.jpg

# Verify they're here
ls -lh *.jpg

# Optimize images (optional, makes site faster)
convert soap-bubbles-cover.jpg -resize 800x -quality 85 soap-bubbles-cover.jpg
convert ricarda-huch.jpg -resize 600x -quality 85 ricarda-huch.jpg
```

---

## Image Optimization (Optional)

If images are too large:

```bash
# Install imagemagick if needed
sudo apt install imagemagick

# Optimize book cover (800px width, 85% quality)
convert soap-bubbles-cover.jpg -resize 800x -quality 85 soap-bubbles-cover-optimized.jpg

# Optimize author photo (600px width, 85% quality)
convert ricarda-huch.jpg -resize 600x -quality 85 ricarda-huch-optimized.jpg

# Replace originals if satisfied
mv soap-bubbles-cover-optimized.jpg soap-bubbles-cover.jpg
mv ricarda-huch-optimized.jpg ricarda-huch.jpg
```

---

## Can't Find Images Right Now?

### Use Placeholder Images Temporarily

You can launch the site with placeholders and swap them later:

**For book cover:**
```bash
cd ~/translation-business/forgotten-voices-website

# Create a simple placeholder (requires imagemagick)
convert -size 800x1200 xc:lightblue \
  -gravity center -pointsize 60 -annotate +0+0 "Soap Bubbles\n\nRicarda Huch" \
  soap-bubbles-cover.jpg
```

**For author photo:**
- Use a silhouette or generic portrait
- Or just launch without images initially (site will show fallback)

---

## Next Steps After Adding Images

Once you have both JPG files in `forgotten-voices-website/`:

1. ✅ Verify images are there: `ls -lh forgotten-voices-website/*.jpg`
2. ✅ Test locally: Open `index.html` in browser
3. ✅ Customize content (dates, email) - see README.md
4. ✅ Set up Mailchimp - see MAILCHIMP_SETUP.md
5. ✅ Deploy to GitHub Pages - see DEPLOYMENT.md

---

## Timeline

**If you design cover yourself (Canva):** 1-2 hours
**If you commission on Fiverr:** 2-5 days
**Finding Ricarda Huch photo:** 15-30 minutes

**Total time to launch site:**
- Fast track (with placeholders): 2-3 hours
- With custom cover: 1-2 days
- Professional cover: 5-7 days

---

## Questions?

- Stuck finding images? Let me know and I can help generate placeholders
- Need design advice? Happy to give feedback on cover options
- Technical issues? Check the main README.md

**You're making great progress! The hard part (website code) is done. Now just add the visual polish.**
