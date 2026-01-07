# Setup Guide for Prepico Blog

## Quick Start (3 Steps)

### Step 1: Set Up SupaBase

1. Go to https://supabase.com and create account
2. Click "New Project"
3. Fill in:
   - Project name: `prepico-blog`
   - Database password: (save this)
   - Region: Choose closest to you
4. Wait for project to be created (~2 minutes)

### Step 2: Create Database Table

1. In SupaBase dashboard, click "SQL Editor" (left sidebar)
2. Click "New Query"
3. Copy the contents of `database-schema.sql` file
4. Paste and click "Run"
5. You should see: "Success. No rows returned"

### Step 3: Get API Credentials

1. In SupaBase dashboard, click "Project Settings" (gear icon)
2. Click "API" in the left menu
3. Copy these two values:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon public** key (long string under "Project API keys")

### Step 4: Configure Project

1. In the project root, create a `.env` file
2. Add your credentials:

```env
VITE_SUPABASE_URL=https://your-project-id.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

3. Save the file

### Step 5: Run the Project

```bash
npm install
npm run dev
```

Visit http://localhost:5173

## Testing the Project

### Test 1: Empty Database
1. Open http://localhost:5173
2. You should see "No blogs yet" message

### Test 2: Create First Blog
1. Click "Admin" in navigation
2. Fill in:
   - Title: "Getting Started with Prepico"
   - Thumbnail URL: `https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800`
3. Click "+ Paragraph" and type some text
4. Click "+ Horizontal Layout"
5. In the horizontal layout:
   - Click "+ Paragraph" and add text
   - Click "+ Image" and add image URL
6. Click "Save Blog"

### Test 3: View Blog List
1. After saving, you'll be redirected to the blog
2. Click "← Back to all blogs"
3. You should see your blog in the grid

### Test 4: View Individual Blog
1. Click on any blog card
2. Blog should display with all content including nested layouts

## Video Recording Checklist

Record 4 phases as specified in requirements:

### Phase 1: Empty Database
- Show SupaBase dashboard
- Show "blogs" table with 0 rows
- Show table structure (id, title, thumbnail_url, content, created_at)

### Phase 2: Create Blog in Admin
- Navigate to /admin
- Create a blog with:
  - Title
  - Thumbnail
  - Multiple content blocks
  - At least one horizontal/nested layout
- Click Save

### Phase 3: Database with Data
- Go back to SupaBase
- Refresh the "blogs" table
- Show the new row
- Click to expand the JSONB content column
- Show the nested structure

### Phase 4: List and View Pages
- Go to home page (/)
- Show blog in list
- Click on blog
- Show full blog rendering
- Demonstrate that complex layouts render correctly

## Troubleshooting

### Error: "Invalid API key"
- Check your `.env` file
- Make sure you copied the **anon public** key, not the service role key
- Restart dev server after changing `.env`

### Error: "relation 'blogs' does not exist"
- Go to SupaBase SQL Editor
- Run the `database-schema.sql` script again

### Blank page / Nothing loads
- Open browser console (F12)
- Check for error messages
- Make sure dev server is running
- Check that `.env` file exists and has correct values

### Styles not loading
- Clear browser cache
- Check that `vite.config.js` has the Vue plugin
- Restart dev server

## Submission Checklist

- [ ] Code is pushed to public GitHub repository
- [ ] README.md includes setup instructions
- [ ] `.env.example` file included (without actual credentials)
- [ ] Project structure is clean and organized
- [ ] Video shows all 4 phases
- [ ] Video uploaded to Google Drive with public link
- [ ] Email sent to aditya.kumar@prepico.ai
- [ ] CC: rahulagarwal@prepico.ai
- [ ] Email includes: GitHub link + Video link

## Email Template

```
Subject: Prepico Blog - Frontend Developer Intern Submission

Dear Prepico Team,

Please find my submission for the Frontend Developer Intern assignment:

GitHub Repository: [your-repo-url]
Demo Video: [google-drive-link]

The project includes:
- Vue.js 3 with Composition API
- SupaBase for backend and database
- Admin page for blog creation
- Complex nested content structures
- Horizontal layouts support
- Media embedding (images, video, audio)
- List and view pages

All requirements have been completed as specified.

Best regards,
[Your Name]
```
