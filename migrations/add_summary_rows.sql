-- Run this in your Supabase SQL Editor
-- Project: xlpxcijivqxedgjeklzy

ALTER TABLE quotations ADD COLUMN IF NOT EXISTS summary_rows JSONB;
ALTER TABLE quotations ADD COLUMN IF NOT EXISTS custom_labels JSONB;
