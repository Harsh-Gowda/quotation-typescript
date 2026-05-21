import { QuoteItem } from './types';

// Total price of all items, respecting the includeGst flag
// If includeGst is false, we assume the original price was inclusive and we extract the tax part.
export const totalPrice = (items: QuoteItem[]) => {
  return items.reduce((sum, item) => {
    const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
    const effectivePrice = item.includeGst !== false ? basePrice : basePrice / 1.18;
    return sum + effectivePrice * item.quantity;
  }, 0);
};

// Subtotal for items that CAN be discounted (non-service products)
export const discountableSubtotal = (items: QuoteItem[]) => {
  return items.reduce((sum, item) => {
    if (item.product.category === 'Services' || item.includeDiscount === false) return sum;
    const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
    const effectivePrice = item.includeGst !== false ? basePrice : basePrice / 1.18;
    return sum + effectivePrice * item.quantity;
  }, 0);
};

// Subtotal for service items only (never discounted)
export const servicesSubtotal = (items: QuoteItem[]) => {
  return items.reduce((sum, item) => {
    if (item.product.category !== 'Services') return sum;
    const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
    const effectivePrice = item.includeGst !== false ? basePrice : basePrice / 1.18;
    return sum + effectivePrice * item.quantity;
  }, 0);
};

export const computeGstBase = (items: QuoteItem[], globalDiscountType?: 'include' | 'exclude', globalDiscountValue: number = 0) => {
  // If 'include' discount is selected, user wants to remove GST calculation (as prices already include it)
  if (globalDiscountType === 'include') return 0;

  return items.reduce((sum, item) => {
    const isService = item.product.category === 'Services';
    const gstApplies =  item.includeGst !== false;
    if (!gstApplies) return sum;

    const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
    const val = globalDiscountValue || 0;
    const isExclude = globalDiscountType === 'exclude';

    let effectivePrice = item.includeGst !== false ? basePrice : basePrice / 1.18;
    if (isExclude && !isService && item.includeDiscount !== false) {
      effectivePrice = effectivePrice * (1 - val / 100);
    }

    return sum + effectivePrice * item.quantity;
  }, 0);
};

export const calculateTotalDiscount = (items: QuoteItem[], globalDiscountType?: 'include' | 'exclude', globalDiscountValue: number = 0) => {
  const val = globalDiscountValue || 0;
  if (val <= 0) return 0;

  if (globalDiscountType === 'exclude') {
    return items.reduce((sum, item) => {
      if (item.product.category === 'Services' || item.includeDiscount === false) return sum;
      const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
      const effectivePrice = item.includeGst !== false ? basePrice : basePrice / 1.18;
      const itemDiscount = Math.round(effectivePrice * val / 100);
      return sum + itemDiscount * item.quantity;
    }, 0);
  }

  if (globalDiscountType === 'include') {
    // GST Include applies directly to the Gross Total (which already includes GST where applicable)
    // Only includes items where discount is toggled ON
    const discSubtotal = discountableSubtotal(items);
    return Math.round(discSubtotal * val / 100);
  }

  return 0;
};
