-- ============================================================
-- STEP 1: Enable RLS delete and update policies for Admin operations
-- This allows deleting and updating product templates and variants
-- ============================================================

-- Allow public delete and update for variants
DROP POLICY IF EXISTS "public_delete_variants" ON public.product_variants;
CREATE POLICY "public_delete_variants"
  ON public.product_variants FOR DELETE USING (true);

DROP POLICY IF EXISTS "public_update_variants" ON public.product_variants;
CREATE POLICY "public_update_variants"
  ON public.product_variants FOR UPDATE USING (true);

-- Allow public delete and update for templates
DROP POLICY IF EXISTS "public_delete_templates" ON public.product_templates;
CREATE POLICY "public_delete_templates"
  ON public.product_templates FOR DELETE USING (true);

DROP POLICY IF EXISTS "public_update_templates" ON public.product_templates;
CREATE POLICY "public_update_templates"
  ON public.product_templates FOR UPDATE USING (true);

SELECT 'RLS delete and update policies applied successfully' AS status;
