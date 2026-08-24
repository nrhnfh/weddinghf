-- supabase/migrations/20240905000000_initial.sql

-- Buat tabel comments
CREATE TABLE IF NOT EXISTS comments (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  status TEXT DEFAULT 'Hadir',
  text TEXT NOT NULL,
  is_rsvp BOOLEAN DEFAULT FALSE,
  time TIMESTAMP DEFAULT NOW(),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Enable Realtime
ALTER TABLE comments REPLICA IDENTITY FULL;

-- Berikan akses ke anon user
GRANT ALL ON comments TO anon, authenticated, service_role;

-- Enable RLS (opsional, untuk keamanan)
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Policy untuk membaca
CREATE POLICY "Allow public read" ON comments
  FOR SELECT USING (true);

-- Policy untuk menambah
CREATE POLICY "Allow public insert" ON comments
  FOR INSERT WITH CHECK (true);
