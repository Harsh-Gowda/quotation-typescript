-- ============================================================
-- MAGNIFIC QUOTATION SYSTEM - STEP 7: QUOTATIONS TABLE
-- Run this in Supabase SQL Editor
-- ============================================================
-- Stores saved quotations so they persist across devices/browsers
-- and can later be surfaced in a CRM dashboard.

CREATE TABLE IF NOT EXISTS public.quotations (
    id                    text        NOT NULL,  -- e.g. ALI-260509-1
    customer              jsonb       NOT NULL,  -- { name, email, phone, address, company }
    items                 jsonb       NOT NULL,  -- QuoteItem[] (each item embeds the product snapshot)
    date                  text        NOT NULL,  -- human-readable date string
    tax_rate              numeric(5,2) DEFAULT 18 NOT NULL,
    notes                 text,
    ai_summary            text,
    advance_amount        numeric(14,2),
    advance_date          text,
    manual_round_off      numeric(14,2),
    global_discount_type  text,                  -- 'include' | 'exclude' | null
    global_discount_value numeric(5,2),
    created_by            text,                  -- user name who created the quote
    created_at            timestamp with time zone DEFAULT now() NOT NULL,
    updated_at            timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE public.quotations
  DROP CONSTRAINT IF EXISTS quotations_pkey;
ALTER TABLE public.quotations
  ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);

-- Index for listing quotes by user
CREATE INDEX IF NOT EXISTS quotations_created_by_idx
  ON public.quotations USING btree (created_by);

-- Index for ordering by creation date
CREATE INDEX IF NOT EXISTS quotations_created_at_idx
  ON public.quotations USING btree (created_at DESC);

-- RLS: allow all operations for anon (same pattern as product tables)
ALTER TABLE public.quotations ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public read quotations" ON public.quotations;
CREATE POLICY "Allow public read quotations"
  ON public.quotations FOR SELECT
  USING (true);

DROP POLICY IF EXISTS "Allow public insert quotations" ON public.quotations;
CREATE POLICY "Allow public insert quotations"
  ON public.quotations FOR INSERT
  WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public update quotations" ON public.quotations;
CREATE POLICY "Allow public update quotations"
  ON public.quotations FOR UPDATE
  USING (true);

DROP POLICY IF EXISTS "Allow public delete quotations" ON public.quotations;
CREATE POLICY "Allow public delete quotations"
  ON public.quotations FOR DELETE
  USING (true);

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_quotations_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS quotations_updated_at ON public.quotations;
CREATE TRIGGER quotations_updated_at
  BEFORE UPDATE ON public.quotations
  FOR EACH ROW
  EXECUTE FUNCTION update_quotations_updated_at();

SELECT 'Quotations table created successfully' AS status;
