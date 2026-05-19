-- Allow users to insert custom products into the catalog permanently
-- Run this in Supabase SQL Editor

-- Enable INSERT for product_templates
DROP POLICY IF EXISTS "public_insert_templates" ON public.product_templates;
CREATE POLICY "public_insert_templates"
  ON public.product_templates FOR INSERT WITH CHECK (true);

-- Enable UPDATE for product_templates
DROP POLICY IF EXISTS "public_update_templates" ON public.product_templates;
CREATE POLICY "public_update_templates"
  ON public.product_templates FOR UPDATE USING (true);

-- Enable INSERT for product_variants
DROP POLICY IF EXISTS "public_insert_variants" ON public.product_variants;
CREATE POLICY "public_insert_variants"
  ON public.product_variants FOR INSERT WITH CHECK (true);

-- Enable UPDATE for product_variants (we need this to update the image later)
DROP POLICY IF EXISTS "public_update_variants" ON public.product_variants;
CREATE POLICY "public_update_variants"
  ON public.product_variants FOR UPDATE USING (true);
