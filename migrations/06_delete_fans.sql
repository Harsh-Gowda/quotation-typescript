-- Remove all Fan and Fan Blade Set products from the database
-- This script will delete the variants, templates, and categories for fans.

-- 1. Delete variant BOM components that reference fan variants (if any)
DELETE FROM public.variant_bom_components
WHERE "parentVariantId" IN (
    SELECT v."variantId" 
    FROM public.product_variants v
    JOIN public.product_templates t ON v."templateId" = t."templateId"
    JOIN public.product_categories c ON t."categoryId" = c."categoryId"
    WHERE c.name ILIKE '%fan%'
) OR "componentVariantId" IN (
    SELECT v."variantId" 
    FROM public.product_variants v
    JOIN public.product_templates t ON v."templateId" = t."templateId"
    JOIN public.product_categories c ON t."categoryId" = c."categoryId"
    WHERE c.name ILIKE '%fan%'
);

-- 2. Delete product variants for fans
DELETE FROM public.product_variants
WHERE "templateId" IN (
    SELECT t."templateId" 
    FROM public.product_templates t
    JOIN public.product_categories c ON t."categoryId" = c."categoryId"
    WHERE c.name ILIKE '%fan%'
);

-- 3. Delete product templates for fans
DELETE FROM public.product_templates
WHERE "categoryId" IN (
    SELECT "categoryId" 
    FROM public.product_categories 
    WHERE name ILIKE '%fan%'
);

-- 4. Delete the categories themselves
DELETE FROM public.product_categories
WHERE name ILIKE '%fan%';

SELECT 'Successfully deleted all fan products' AS status;
