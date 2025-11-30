-- BingeBay Database Setup
-- Run this in Supabase SQL Editor
-- Create waitlist table
CREATE TABLE
    IF NOT EXISTS waitlist (
        id BIGSERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT NOT NULL,
        age INTEGER NOT NULL,
        created_at TIMESTAMP
        WITH
            TIME ZONE DEFAULT NOW ()
    );

-- Create provider_applications table
CREATE TABLE
    IF NOT EXISTS provider_applications (
        id BIGSERIAL PRIMARY KEY,
        full_name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        channel_name TEXT,
        phone TEXT,
        status TEXT DEFAULT 'pending',
        created_at TIMESTAMP
        WITH
            TIME ZONE DEFAULT NOW ()
    );

-- Enable Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

ALTER TABLE provider_applications ENABLE ROW LEVEL SECURITY;

-- DROP existing policies if any (to avoid conflicts)
DROP POLICY IF EXISTS "Allow public insert on waitlist" ON waitlist;

DROP POLICY IF EXISTS "Allow public insert on provider_applications" ON provider_applications;

-- Create policies to allow INSERT from website (anonymous users)
CREATE POLICY "Allow public insert on waitlist" ON waitlist FOR INSERT TO anon
WITH
    CHECK (true);

CREATE POLICY "Allow public insert on provider_applications" ON provider_applications FOR INSERT TO anon
WITH
    CHECK (true);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_waitlist_email ON waitlist (email);

CREATE INDEX IF NOT EXISTS idx_waitlist_created_at ON waitlist (created_at DESC);

CREATE INDEX IF NOT EXISTS idx_provider_email ON provider_applications (email);

CREATE INDEX IF NOT EXISTS idx_provider_created_at ON provider_applications (created_at DESC);

CREATE INDEX IF NOT EXISTS idx_provider_status ON provider_applications (status);

-- Verify tables were created
SELECT
    'Tables created successfully!' as status;