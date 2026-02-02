
import { QuoteItem } from './types';

export const totalPrice = (items: QuoteItem[]) => items.reduce((sum, item) => sum + ((item.product.price - (item.discount || 0)) * item.quantity), 0);
