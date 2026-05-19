-- Fix: "new row violates row-level security policy" when uploading images
-- Run this in Supabase SQL Editor (https://supabase.com/dashboard → SQL Editor)

-- 1. Ensure bucket exists and is public
INSERT INTO storage.buckets (id, name, public)
VALUES ('product-images', 'product-images', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- 2. Drop existing restrictive policies
DROP POLICY IF EXISTS "product-images upload" ON storage.objects;
DROP POLICY IF EXISTS "product-images update" ON storage.objects;
DROP POLICY IF EXISTS "Allow product image uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow product image updates" ON storage.objects;
DROP POLICY IF EXISTS "Allow product image reads" ON storage.objects;
DROP POLICY IF EXISTS "Allow product image deletes" ON storage.objects;

-- 3. Create permissive policies for the product-images bucket
CREATE POLICY "Allow product image reads"
ON storage.objects FOR SELECT
USING (bucket_id = 'product-images');

CREATE POLICY "Allow product image uploads"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'product-images');

CREATE POLICY "Allow product image updates"
ON storage.objects FOR UPDATE
USING (bucket_id = 'product-images');

CREATE POLICY "Allow product image deletes"
ON storage.objects FOR DELETE
USING (bucket_id = 'product-images');
