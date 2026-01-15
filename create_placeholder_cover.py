#!/usr/bin/env python3
"""Create a professional placeholder book cover for Soap Bubbles"""

from PIL import Image, ImageDraw, ImageFont
import os

# Create image (standard book cover size)
width, height = 1600, 2400
background_color = '#E8F4F8'  # Soft blue
text_color = '#2C3E50'  # Dark blue-gray
accent_color = '#C9926E'  # Copper/gold

# Create image
img = Image.new('RGB', (width, height), background_color)
draw = ImageDraw.Draw(img)

# Try to use nice fonts, fall back to default if not available
try:
    # Try different font paths for Ubuntu/Debian
    font_paths = [
        '/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf',
        '/usr/share/fonts/truetype/liberation/LiberationSerif-Bold.ttf',
        '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]
    title_font = None
    for path in font_paths:
        if os.path.exists(path):
            title_font = ImageFont.truetype(path, 140)
            author_font = ImageFont.truetype(path, 80)
            subtitle_font = ImageFont.truetype(path, 60)
            break

    if not title_font:
        # Use default font
        title_font = ImageFont.load_default()
        author_font = ImageFont.load_default()
        subtitle_font = ImageFont.load_default()
except:
    title_font = ImageFont.load_default()
    author_font = ImageFont.load_default()
    subtitle_font = ImageFont.load_default()

# Add decorative border
border_width = 40
draw.rectangle(
    [(border_width, border_width), (width - border_width, height - border_width)],
    outline=accent_color,
    width=3
)

# Title: "Soap Bubbles"
title_text = "Soap Bubbles"
title_bbox = draw.textbbox((0, 0), title_text, font=title_font)
title_width = title_bbox[2] - title_bbox[0]
title_x = (width - title_width) // 2
title_y = height // 3

draw.text((title_x, title_y), title_text, fill=text_color, font=title_font)

# Author: "Ricarda Huch"
author_text = "Ricarda Huch"
author_bbox = draw.textbbox((0, 0), author_text, font=author_font)
author_width = author_bbox[2] - author_bbox[0]
author_x = (width - author_width) // 2
author_y = title_y + 200

draw.text((author_x, author_y), author_text, fill=accent_color, font=author_font)

# Subtitle line
line_y = author_y + 150
line_length = 400
line_x = (width - line_length) // 2
draw.line([(line_x, line_y), (line_x + line_length, line_y)], fill=accent_color, width=2)

# Additional text: "Three Novellas"
subtitle_text = "Three Novellas"
subtitle_bbox = draw.textbbox((0, 0), subtitle_text, font=subtitle_font)
subtitle_width = subtitle_bbox[2] - subtitle_bbox[0]
subtitle_x = (width - subtitle_width) // 2
subtitle_y = line_y + 40

draw.text((subtitle_x, subtitle_y), subtitle_text, fill=text_color, font=subtitle_font)

# Footer: "Translated by Terra Laggner"
footer_text = "Translated by Terra Laggner"
footer_bbox = draw.textbbox((0, 0), footer_text, font=subtitle_font)
footer_width = footer_bbox[2] - footer_bbox[0]
footer_x = (width - footer_width) // 2
footer_y = height - 300

draw.text((footer_x, footer_y), footer_text, fill=text_color, font=subtitle_font)

# Publisher
publisher_text = "Forgotten Voices Press"
publisher_bbox = draw.textbbox((0, 0), publisher_text, font=subtitle_font)
publisher_width = publisher_bbox[2] - publisher_bbox[0]
publisher_x = (width - publisher_width) // 2
publisher_y = footer_y + 100

draw.text((publisher_x, publisher_y), publisher_text, fill=accent_color, font=subtitle_font)

# Save as JPG
output_path = 'soap-bubbles-cover.jpg'
img.save(output_path, 'JPEG', quality=90)
print(f"✓ Created placeholder cover: {output_path}")
print(f"  Size: {width}x{height}px")
