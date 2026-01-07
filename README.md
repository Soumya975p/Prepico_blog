# Prepico Blog

A full-stack blog management system built with Vue.js and SupaBase for Prepico.AI.

## Features

- ✨ **Rich Blog Editor** - Create blogs with complex nested structures
- 📝 **Multiple Content Types** - Paragraphs, headings, bullet lists
- 🎨 **Media Support** - Images, videos, audio files
- 🔄 **Horizontal Layouts** - Side-by-side content arrangement
- 📱 **Responsive Design** - Works on all devices
- 🚀 **Real-time Database** - Powered by SupaBase

## Tech Stack

- **Frontend:** Vue.js 3 (Composition API)
- **Routing:** Vue Router 4
- **Backend:** SupaBase (PostgreSQL)
- **Build Tool:** Vite
- **Styling:** CSS3 with custom properties

## Prerequisites

- Node.js 16+ 
- npm or yarn
- SupaBase account

## Quick Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure SupaBase

1. Create a SupaBase account at https://supabase.com
2. Create a new project
3. Run the SQL in `database-schema.sql` file in SupaBase SQL Editor
4. Copy your project URL and anon key from Project Settings > API

### 3. Set Environment Variables

Create a `.env` file in the project root:

```env
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Run Development Server

```bash
npm run dev
```

Open http://localhost:5173

## Database Schema

Run this SQL in your SupaBase SQL Editor:

```sql
CREATE TABLE blogs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  thumbnail_url TEXT,
  content JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

See `database-schema.sql` for complete schema with indexes and policies.

## Project Structure

```
prepico-blog/
├── src/
│   ├── components/         # Reusable components
│   ├── views/              # Page components
│   ├── router/             # Vue Router setup
│   ├── lib/                # SupaBase client
│   └── App.vue             # Root component
├── database-schema.sql     # Database setup script
├── SETUP.md                # Detailed setup guide
└── README.md               # This file
```

## Usage

### Creating Blogs
1. Navigate to `/admin`
2. Enter title and thumbnail URL
3. Add content blocks (paragraph, heading, list, media, horizontal layouts)
4. Use ↑↓ to reorder, × to delete blocks
5. Click "Save Blog"

### Viewing Blogs
- `/` - List all blogs
- `/blog/:id` - View individual blog

## Build for Production

```bash
npm run build
```

Deploy the `dist/` folder to any static hosting service.

## Author

Created for Prepico.AI Frontend Developer Internship

For support: aditya.kumar@prepico.ai
