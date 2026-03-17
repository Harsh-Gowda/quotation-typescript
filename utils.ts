
import { QuoteItem } from './types';

export const totalPrice = (items: QuoteItem[]) => items.reduce((sum, item) => {
    const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
    return sum + ((basePrice - (item.discount || 0)) * item.quantity);
}, 0);
