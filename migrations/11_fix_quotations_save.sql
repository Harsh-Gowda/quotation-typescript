-- ============================================================
-- MAGNIFIC QUOTATION SYSTEM - FIX 11: SAVE QUOTE REPAIR
-- Run this in Supabase SQL Editor to fix "Save Quote" issues.
-- ============================================================

-- 1. Ensure the primary key exists on the 'id' column
--    (upsert with onConflict: 'id' requires this)
ALTER TABLE public.quotations
  DROP CONSTRAINT IF EXISTS quotations_pkey;
ALTER TABLE public.quotations
  ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);

-- 2. Add any columns that may be missing (safe, idempotent)
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS summary_rows   jsonb;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS custom_labels  jsonb;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS advance_amount numeric(14,2);
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS advance_date   text;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS manual_round_off numeric(14,2);
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS global_discount_type  text;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS global_discount_value numeric(5,2);
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS created_by     text;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS ai_summary     text;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS notes          text;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS updated_at     timestamp with time zone DEFAULT now();

-- 3. Ensure RLS policies allow upsert (INSERT + UPDATE) without auth
ALTER TABLE public.quotations ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public read quotations"   ON public.quotations;
DROP POLICY IF EXISTS "Allow public insert quotations" ON public.quotations;
DROP POLICY IF EXISTS "Allow public update quotations" ON public.quotations;
DROP POLICY IF EXISTS "Allow public delete quotations" ON public.quotations;

CREATE POLICY "Allow public read quotations"
  ON public.quotations FOR SELECT USING (true);

CREATE POLICY "Allow public insert quotations"
  ON public.quotations FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow public update quotations"
  ON public.quotations FOR UPDATE USING (true);

CREATE POLICY "Allow public delete quotations"
  ON public.quotations FOR DELETE USING (true);

-- 4. Auto-update the updated_at trigger (re-create safely)
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

SELECT 'Fix 11: Quotations save repair complete' AS status;
