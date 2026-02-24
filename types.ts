
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
  // Fan specific fields
  suitableFor?: string;
  motorSpec?: string;
  noOfBlades?: number;
  bodyColor?: string;
  bladeFinish?: string;
  lightOption?: string;
  sweep?: string;
  airflow?: string;
  heightOfFan?: string;
  remoteControl?: boolean;
  summerWinterOption?: boolean;
  bladeMechanism?: string;
  reversibleBlade?: boolean;
  oscillationRotation?: string;
  bladeType?: string;
  // Light specific fields
  suitablePlace?: string;
  size?: string;
  lamp?: string;
  finishing?: string;
}

export interface QuoteItem {
  product: Product;
  quantity: number;
  placeName?: string;
  size?: string;
  color?: string;
  lamp?: string;
  discount?: number;
  customDescription?: string;
  extraNote?: string;
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
  manualRoundOff?: number;
  globalDiscountType?: 'flat' | 'percentage';
  globalDiscountValue?: number;
}

export type ViewState = 'CUSTOMER_ENTRY' | 'PRODUCT_SELECTION' | 'PREVIEW' | 'SAVED_QUOTES';
