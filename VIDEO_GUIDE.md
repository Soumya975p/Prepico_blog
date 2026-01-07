# 📹 VIDEO RECORDING GUIDE

## Requirements
- **Duration:** 4 phases (3-5 minutes total)
- **Format:** Screen recording (faceless is fine)
- **Quality:** Clear resolution, visible text
- **Upload:** Google Drive with public share link

---

## 🎬 RECORDING CHECKLIST

### ✅ Before Recording
- [ ] Application running at http://localhost:5173
- [ ] SupaBase dashboard open in another tab
- [ ] Database is empty (0 rows in blogs table)
- [ ] Screen recording software ready (OBS, Windows Game Bar, or any recorder)

---

## 📝 PHASE 1: Empty Database Schema (30 seconds)

**What to Show:**
1. Open SupaBase dashboard
2. Navigate to: Table Editor → blogs table
3. Show table structure with columns:
   - `id` (uuid)
   - `title` (text)
   - `thumbnail_url` (text)
   - `content` (jsonb)
   - `created_at` (timestamptz)
4. Show: **0 rows** (empty table)

**What to Say (optional):**
> "This is the blogs table in SupaBase with the schema supporting complex nested structures using JSONB."

---

## 📝 PHASE 2: Admin Page - Creating Blog (2 minutes)

**What to Show:**
1. Navigate to: http://localhost:5173/admin
2. Fill in blog details:
   - **Title:** "Getting Started with Prepico - Your Career Companion"
   - **Thumbnail URL:** https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800

3. Add content blocks:
   - Click "+ Paragraph" and type some text
   - Click "+ Heading" and type a heading
   - Click "+ Bullet List" and add 3-4 items
   - **IMPORTANT:** Click "+ Horizontal Layout"
     - Inside horizontal layout, add:
       - A paragraph
       - An image (URL: https://images.unsplash.com/photo-1552664730-d307ca884978?w=400)
   - Optionally add video/audio
   
4. Demonstrate:
   - Use ↑↓ buttons to reorder blocks
   - Show that blocks can be deleted with ×
   - Show nested structure in horizontal layout

5. Click "Save Blog"
6. Show success message and redirect to blog view

**What to Say (optional):**
> "The admin page supports complex nested structures. Here I'm creating a horizontal layout with multiple content blocks inside it."

---

## 📝 PHASE 3: Database with Data (45 seconds)

**What to Show:**
1. Go back to SupaBase dashboard
2. Click "Refresh" or reload the page
3. Show: **1 row** in the blogs table
4. Click on the row to expand it
5. **IMPORTANT:** Click on the `content` column (JSONB)
6. Show the JSON structure:
   - Array of content blocks
   - Show the horizontal layout object with `children` array
   - Highlight the nested structure

**What to Say (optional):**
> "The blog is saved in SupaBase. Notice the JSONB content column stores the complex nested structure with horizontal layouts."

---

## 📝 PHASE 4: List & View Pages (1 minute)

**What to Show:**
1. Navigate to: http://localhost:5173/ (home page)
2. Show:
   - Blog card with thumbnail
   - Blog title
   - Created date
   
3. Click on the blog card
4. Show the blog view page with:
   - Full title
   - Thumbnail image
   - All content rendered:
     - Paragraphs
     - Headings
     - Bullet lists
     - Images
     - **IMPORTANT:** Horizontal layout rendering side-by-side
     - Any videos/audio
   
5. Scroll through the entire blog
6. Click "← Back to all blogs"
7. Show list page again

**What to Say (optional):**
> "The blog renders all content types including the horizontal layout which displays content side-by-side. All data is fetched from SupaBase."

---

## 🎥 RECORDING TIPS

### Screen Recording Options:
- **Windows:** Windows Game Bar (Win + G)
- **OBS Studio:** Free, professional quality
- **Loom:** Easy browser-based recording
- **ShareX:** Free with upload features

### Quality Settings:
- Resolution: 1920x1080 (Full HD) or 1280x720 (HD)
- Frame Rate: 30 FPS minimum
- Audio: Optional (narration not required)

### Editing:
- Trim unnecessary parts
- Can speed up slow sections (1.5x)
- Add text annotations if helpful (optional)

---

## 📤 UPLOAD TO GOOGLE DRIVE

1. Upload video to Google Drive
2. Right-click → Share
3. Change to: "Anyone with the link can view"
4. Copy the share link
5. Test the link in an incognito window

---

## ✅ VIDEO CHECKLIST

Before submission, verify your video shows:
- [ ] Empty database table with correct schema
- [ ] Admin page creating a blog
- [ ] At least ONE complex structure (horizontal layout with nested content)
- [ ] Database with saved data (JSONB structure visible)
- [ ] List page showing the blog
- [ ] View page rendering all content correctly
- [ ] Horizontal layout renders side-by-side (not vertically)

---

## 📧 READY FOR SUBMISSION?

Once video is recorded and uploaded, proceed to submission:
- GitHub: https://github.com/Soumya975p/Prepico_blog
- Video: [Your Google Drive Link]

See `SUBMISSION.md` for email template.
