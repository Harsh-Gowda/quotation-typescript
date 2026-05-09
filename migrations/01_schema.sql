-- ============================================================
-- MAGNIFIC PRODUCT CATALOG - STEP 1: SCHEMA
-- Run this first in Supabase SQL Editor
-- ============================================================

-- Step 1: Create enum type
DO $$ BEGIN
  CREATE TYPE public."ProductItemType" AS ENUM (
    'FinishedGood', 'Component', 'Service', 'RawMaterial'
  );
EXCEPTION
  WHEN duplicate_object THEN null;
END $$;

-- Step 2: product_categories table
CREATE TABLE IF NOT EXISTS public.product_categories (
    "categoryId"       uuid    NOT NULL,
    code               text    NOT NULL,
    name               text    NOT NULL,
    "parentCategoryId" uuid,
    "createdAt"        timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE public.product_categories
  DROP CONSTRAINT IF EXISTS product_categories_pkey;
ALTER TABLE public.product_categories
  ADD CONSTRAINT product_categories_pkey PRIMARY KEY ("categoryId");

CREATE UNIQUE INDEX IF NOT EXISTS product_categories_code_key
  ON public.product_categories USING btree (code);
CREATE INDEX IF NOT EXISTS "product_categories_parentCategoryId_idx"
  ON public.product_categories USING btree ("parentCategoryId");

-- Step 3: product_templates table
CREATE TABLE IF NOT EXISTS public.product_templates (
    "templateId"     uuid    NOT NULL,
    "skuFamily"      text    NOT NULL,
    name             text    NOT NULL,
    brand            text    DEFAULT 'Magnific'::text NOT NULL,
    "categoryId"     uuid    NOT NULL,
    "itemType"       public."ProductItemType" DEFAULT 'FinishedGood'::public."ProductItemType" NOT NULL,
    "isConfigurable" boolean DEFAULT false NOT NULL,
    description      text,
    "createdAt"      timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt"      timestamp(3) without time zone NOT NULL
);

ALTER TABLE public.product_templates
  DROP CONSTRAINT IF EXISTS product_templates_pkey;
ALTER TABLE public.product_templates
  ADD CONSTRAINT product_templates_pkey PRIMARY KEY ("templateId");

CREATE UNIQUE INDEX IF NOT EXISTS "product_templates_skuFamily_key"
  ON public.product_templates USING btree ("skuFamily");
CREATE INDEX IF NOT EXISTS "product_templates_categoryId_idx"
  ON public.product_templates USING btree ("categoryId");

-- Step 4: product_variants table
CREATE TABLE IF NOT EXISTS public.product_variants (
    "variantId"      uuid          NOT NULL,
    "templateId"     uuid          NOT NULL,
    sku              text          NOT NULL,
    "variantName"    text          NOT NULL,
    finish           text,
    color            text,
    size             text,
    uom              text          DEFAULT 'Nos'::text NOT NULL,
    "catalogPrice"   numeric(14,2) NOT NULL,
    "showroomPrice"  numeric(14,2) NOT NULL,
    "taxPercent"     numeric(5,2)  DEFAULT 18 NOT NULL,
    "isSellable"     boolean       DEFAULT true NOT NULL,
    "isStockTracked" boolean       DEFAULT true NOT NULL,
    attributes       jsonb,
    "createdAt"      timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt"      timestamp(3) without time zone NOT NULL,
    "clearancePrice" numeric(14,2)
);

ALTER TABLE public.product_variants
  DROP CONSTRAINT IF EXISTS product_variants_pkey;
ALTER TABLE public.product_variants
  ADD CONSTRAINT product_variants_pkey PRIMARY KEY ("variantId");

CREATE UNIQUE INDEX IF NOT EXISTS product_variants_sku_key
  ON public.product_variants USING btree (sku);
CREATE INDEX IF NOT EXISTS "product_variants_templateId_idx"
  ON public.product_variants USING btree ("templateId");

-- Step 5: variant_bom_components table
CREATE TABLE IF NOT EXISTS public.variant_bom_components (
    "bomComponentId"    uuid          NOT NULL,
    "parentVariantId"   uuid          NOT NULL,
    "componentVariantId" uuid         NOT NULL,
    quantity            numeric(14,3) NOT NULL,
    "isOptional"        boolean       DEFAULT false NOT NULL,
    "createdAt"         timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE public.variant_bom_components
  DROP CONSTRAINT IF EXISTS variant_bom_components_pkey;
ALTER TABLE public.variant_bom_components
  ADD CONSTRAINT variant_bom_components_pkey PRIMARY KEY ("bomComponentId");

CREATE UNIQUE INDEX IF NOT EXISTS "variant_bom_components_parentVariantId_componentVariantId_key"
  ON public.variant_bom_components USING btree ("parentVariantId", "componentVariantId");

-- Step 6: Foreign key constraints
ALTER TABLE public.product_categories
  DROP CONSTRAINT IF EXISTS "product_categories_parentCategoryId_fkey";
ALTER TABLE public.product_categories
  ADD CONSTRAINT "product_categories_parentCategoryId_fkey"
  FOREIGN KEY ("parentCategoryId") REFERENCES public.product_categories("categoryId")
  ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE public.product_templates
  DROP CONSTRAINT IF EXISTS "product_templates_categoryId_fkey";
ALTER TABLE public.product_templates
  ADD CONSTRAINT "product_templates_categoryId_fkey"
  FOREIGN KEY ("categoryId") REFERENCES public.product_categories("categoryId")
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE public.product_variants
  DROP CONSTRAINT IF EXISTS "product_variants_templateId_fkey";
ALTER TABLE public.product_variants
  ADD CONSTRAINT "product_variants_templateId_fkey"
  FOREIGN KEY ("templateId") REFERENCES public.product_templates("templateId")
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE public.variant_bom_components
  DROP CONSTRAINT IF EXISTS "variant_bom_components_parentVariantId_fkey";
ALTER TABLE public.variant_bom_components
  ADD CONSTRAINT "variant_bom_components_parentVariantId_fkey"
  FOREIGN KEY ("parentVariantId") REFERENCES public.product_variants("variantId")
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.variant_bom_components
  DROP CONSTRAINT IF EXISTS "variant_bom_components_componentVariantId_fkey";
ALTER TABLE public.variant_bom_components
  ADD CONSTRAINT "variant_bom_components_componentVariantId_fkey"
  FOREIGN KEY ("componentVariantId") REFERENCES public.product_variants("variantId")
  ON UPDATE CASCADE ON DELETE CASCADE;

-- Done! Schema created successfully.
SELECT 'Schema created successfully' AS status;
