
export interface Customer {
  name: string;
  email: string;
  phone: string;
  address: string;
  company?: string;
}

export interface Product {
  id: string;
  name: string;
  modelNumber: string;
  description: string;
  price: number;
  category: string;
  image: string;
  gallery?: string[];
}

export interface QuoteItem {
  product: Product;
  quantity: number;
  placeName?: string;
  size?: string;
  color?: string;
  lamp?: string;
  discount?: number;
}

export interface Quotation {
  id: string;
  customer: Customer;
  items: QuoteItem[];
  date: string;
  taxRate: number;
  notes?: string;
  aiSummary?: string;
  advanceAmount?: number;
  advanceDate?: string;
}

export type ViewState = 'CUSTOMER_ENTRY' | 'PRODUCT_SELECTION' | 'PREVIEW' | 'SAVED_QUOTES';
