-- ============================================================
-- MAGNIFIC - STEP 10: FIX product_variants WRITE RLS POLICIES
-- Run this in Supabase SQL Editor:
--   https://supabase.com/dashboard → SQL Editor → New Query
-- ============================================================
-- Without this, anon key cannot update product_variants (e.g. saving
-- a new image URL to attributes.media.primaryImage after upload).
-- Only SELECT was allowed previously — INSERT/UPDATE were silently blocked.

-- 1. Allow anon key to UPDATE product_variants (e.g. save image URL)
DROP POLICY IF EXISTS "public_update_variants" ON public.product_variants;
CREATE POLICY "public_update_variants"
  ON public.product_variants FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- 2. Allow anon key to INSERT new product_variants (for custom products)
DROP POLICY IF EXISTS "public_insert_variants" ON public.product_variants;
CREATE POLICY "public_insert_variants"
  ON public.product_variants FOR INSERT
  WITH CHECK (true);

-- 3. Allow anon key to DELETE product_variants (admin delete product)
DROP POLICY IF EXISTS "public_delete_variants" ON public.product_variants;
CREATE POLICY "public_delete_variants"
  ON public.product_variants FOR DELETE
  USING (true);

-- 4. Allow anon key to INSERT new product_templates (for custom products)
DROP POLICY IF EXISTS "public_insert_templates" ON public.product_templates;
CREATE POLICY "public_insert_templates"
  ON public.product_templates FOR INSERT
  WITH CHECK (true);

-- 5. Allow anon key to UPDATE product_templates (for admin edit)
DROP POLICY IF EXISTS "public_update_templates" ON public.product_templates;
CREATE POLICY "public_update_templates"
  ON public.product_templates FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- 6. Allow anon key to DELETE product_templates (admin delete product)
DROP POLICY IF EXISTS "public_delete_templates" ON public.product_templates;
CREATE POLICY "public_delete_templates"
  ON public.product_templates FOR DELETE
  USING (true);

SELECT 'product_variants + product_templates write RLS policies applied successfully' AS status;
