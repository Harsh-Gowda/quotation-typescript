-- ============================================================
-- STEP 1: Check data counts in all tables
-- ============================================================
SELECT 'product_categories' AS tbl, COUNT(*) FROM product_categories
UNION ALL
SELECT 'product_templates',          COUNT(*) FROM product_templates
UNION ALL
SELECT 'product_variants',           COUNT(*) FROM product_variants;

-- ============================================================
-- STEP 2: Enable RLS read policies (run this even if you already have data)
-- This fixes "no data returned" when anon key is used
-- ============================================================
ALTER TABLE public.product_categories    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_templates     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_variants      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.variant_bom_components ENABLE ROW LEVEL SECURITY;

-- Allow anonymous (public) reads on all product tables
DROP POLICY IF EXISTS "public_read_categories" ON public.product_categories;
CREATE POLICY "public_read_categories"
  ON public.product_categories FOR SELECT USING (true);

DROP POLICY IF EXISTS "public_read_templates" ON public.product_templates;
CREATE POLICY "public_read_templates"
  ON public.product_templates FOR SELECT USING (true);

DROP POLICY IF EXISTS "public_read_variants" ON public.product_variants;
CREATE POLICY "public_read_variants"
  ON public.product_variants FOR SELECT USING (true);

DROP POLICY IF EXISTS "public_read_bom" ON public.variant_bom_components;
CREATE POLICY "public_read_bom"
  ON public.variant_bom_components FOR SELECT USING (true);

SELECT 'RLS policies applied successfully' AS status;
