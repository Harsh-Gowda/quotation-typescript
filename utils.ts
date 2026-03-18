
import { QuoteItem } from './types';

// Total price of all items (base price * qty), used for gross total display
export const totalPrice = (items: QuoteItem[]) => items.reduce((sum, item) => {
    const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
    return sum + (basePrice * item.quantity);
}, 0);

// Subtotal for items that CAN be discounted (non-service products)
export const discountableSubtotal = (items: QuoteItem[]) => items
    .filter(item => item.product.category !== 'Services')
    .reduce((sum, item) => {
        const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
        return sum + (basePrice * item.quantity);
    }, 0);

// Subtotal for service items only (never discounted)
export const servicesSubtotal = (items: QuoteItem[]) => items
    .filter(item => item.product.category === 'Services')
    .reduce((sum, item) => {
        const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
        return sum + (basePrice * item.quantity);
    }, 0);
