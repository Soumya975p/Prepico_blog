-- Prepico Blog Database Schema
-- Run this SQL in your SupaBase SQL Editor

-- Create blogs table
CREATE TABLE IF NOT EXISTS blogs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  thumbnail_url TEXT,
  content JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE blogs ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations (no authentication required as per requirements)
CREATE POLICY "Allow all operations on blogs" ON blogs
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Create index for faster queries on created_at
CREATE INDEX IF NOT EXISTS idx_blogs_created_at ON blogs(created_at DESC);

-- Create index for title search (optional, for future enhancements)
CREATE INDEX IF NOT EXISTS idx_blogs_title ON blogs USING gin(to_tsvector('english', title));

-- Sample query to verify table creation
SELECT table_name, column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'blogs';
