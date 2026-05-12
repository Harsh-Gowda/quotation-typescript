import { supabase } from './supabase';
import { Quotation } from '../types';

/**
 * Converts a Quotation object to the Supabase row format (snake_case columns).
 */
function toRow(q: Quotation) {
  return {
    id: q.id,
    customer: q.customer,
    items: q.items,
    date: q.date,
    tax_rate: q.taxRate,
    notes: q.notes || null,
    ai_summary: q.aiSummary || null,
    advance_amount: q.advanceAmount || null,
    advance_date: q.advanceDate || null,
    manual_round_off: q.manualRoundOff || null,
    global_discount_type: q.globalDiscountType || null,
    global_discount_value: q.globalDiscountValue || null,
    created_by: q.createdBy || null,
  };
}

/**
 * Converts a Supabase row back to a Quotation object (camelCase fields).
 */
function fromRow(row: any): Quotation {
  return {
    id: row.id,
    customer: row.customer,
    items: row.items,
    date: row.date,
    taxRate: row.tax_rate,
    notes: row.notes || undefined,
    aiSummary: row.ai_summary || undefined,
    advanceAmount: row.advance_amount || undefined,
    advanceDate: row.advance_date || undefined,
    manualRoundOff: row.manual_round_off || undefined,
    globalDiscountType: row.global_discount_type || undefined,
    globalDiscountValue: row.global_discount_value || undefined,
    createdBy: row.created_by || undefined,
  };
}

/**
 * Fetch all saved quotations, ordered by most recent first.
 */
export async function fetchQuotations(): Promise<Quotation[]> {
  const { data, error } = await supabase
    .from('quotations')
    .select('*')
    .order('created_at', { ascending: false });

  if (error) {
    console.error('❌ Failed to fetch quotations:', error.message);
    throw error;
  }

  return (data || []).map(fromRow);
}

/**
 * Save (upsert) a quotation. Works for both new and edited quotations.
 */
export async function saveQuotation(q: Quotation): Promise<void> {
  const row = toRow(q);

  const { error } = await supabase
    .from('quotations')
    .upsert(row, { onConflict: 'id' });

  if (error) {
    console.error('❌ Failed to save quotation:', error.message);
    throw error;
  }
}

/**
 * Delete a quotation by ID.
 */
export async function deleteQuotation(id: string): Promise<void> {
  const { error } = await supabase
    .from('quotations')
    .delete()
    .eq('id', id);

  if (error) {
    console.error('❌ Failed to delete quotation:', error.message);
    throw error;
  }
}
