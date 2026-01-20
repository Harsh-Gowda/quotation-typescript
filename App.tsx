
import React, { useState, useCallback, useMemo, useEffect } from 'react';
import { Customer, Product, QuoteItem, Quotation, ViewState } from './types';
import { MOCK_PRODUCTS } from './constants';
import { generateQuoteSummary } from './services/geminiService';
import QRCode from 'qrcode';
import * as XLSX from 'xlsx';

// Standard Professional Icons
const CartIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" /></svg>;
const CheckIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" /></svg>;
const BackIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" /></svg>;
const UserIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>;
const SearchIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>;
const SaveIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-4 h-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" /></svg>;
const ExcelIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-4 h-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>;
const HistoryIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>;

const STORAGE_KEY = 'magnific_quotes_local';
const OFFICE_ADDRESS = "I Towers, 42/1 1st floor, 100 Feet Rd, Koramangala, Bengaluru, Karnataka 560047";


export default function App() {
  const [view, setView] = useState<ViewState>('CUSTOMER_ENTRY');
  const [customer, setCustomer] = useState<Customer & { advanceAmount?: number, advanceDate?: string }>({ name: '', email: '', phone: '', address: '', company: '', advanceAmount: 0, advanceDate: '' });
  const [cart, setCart] = useState<QuoteItem[]>([]);
  const [isGenerating, setIsGenerating] = useState(false);
  const [finalQuote, setFinalQuote] = useState<Quotation | null>(null);
  const [qrCodeUrl, setQrCodeUrl] = useState<string | null>(null);
  const [shareUrl, setShareUrl] = useState<string | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [savedQuotes, setSavedQuotes] = useState<Quotation[]>([]);
  const [isSaved, setIsSaved] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);
  const [isCustomerView, setIsCustomerView] = useState(false);
  const [isPublicMode, setIsPublicMode] = useState(false);
  // const [manualRoundOff, setManualRoundOff] = useState<number | null>(null);
  const [discountType, setDiscountType] = useState<'flat' | 'percentage' | null>(null);
  const [discountValue, setDiscountValue] = useState<number>(0);

  // Multiple filter states
  const [categoryFilter, setCategoryFilter] = useState('All');
  const [colorFilter, setColorFilter] = useState('All');
  const [sizeFilter, setSizeFilter] = useState('All');
  const [finishingFilter, setFinishingFilter] = useState('All');

  // Dropdown open states
  const [isCategoryOpen, setIsCategoryOpen] = useState(false);
  const [isColorOpen, setIsColorOpen] = useState(false);
  const [isSizeOpen, setIsSizeOpen] = useState(false);
  const [isFinishingOpen, setIsFinishingOpen] = useState(false);

  // Search states for each dropdown
  const [categorySearch, setCategorySearch] = useState('');
  const [colorSearch, setColorSearch] = useState('');
  const [sizeSearch, setSizeSearch] = useState('');
  const [finishingSearch, setFinishingSearch] = useState('');

  useEffect(() => {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      try { setSavedQuotes(JSON.parse(raw)); } catch (e) { console.error(e); }
    }

    // Handle QR Data / Share Link
    const params = new URLSearchParams(window.location.search);
    const data = params.get('data');
    const viewMode = params.get('view');

    if (viewMode === 'customer') {
      setIsPublicMode(true);
    }

    if (data) {
      try {
        const decoded = JSON.parse(decodeURIComponent(escape(atob(data))));
        const restoredItems = decoded.items.map((item: any) => ({
          ...item,
          product: MOCK_PRODUCTS.find(p => p.id === item.productId)
        })).filter((item: any) => item.product);

        setFinalQuote({ ...decoded, items: restoredItems });
        setView('PREVIEW');
      } catch (e) { console.error("Failed to decode QR data", e); }
    }
  }, []);

  const addToCart = (product: Product, options: { placeName?: string, size?: string, color?: string, lamp?: string, discount?: number }) => {
    const trimmedPlace = options.placeName?.trim() || '';
    const trimmedSize = options.size?.trim() || '';
    const trimmedColor = options.color?.trim() || '';
    const trimmedLamp = options.lamp?.trim() || '';
    const discountVal = options.discount || 0;

    setCart(prev => {
      const existing = prev.find(item =>
        item.product.id === product.id &&
        (item.placeName || '') === trimmedPlace &&
        (item.size || '') === trimmedSize &&
        (item.color || '') === trimmedColor &&
        (item.lamp || '') === trimmedLamp &&
        (item.discount || 0) === discountVal
      );
      if (existing) {
        return prev.map(item =>
          (item.product.id === product.id &&
            (item.placeName || '') === trimmedPlace &&
            (item.size || '') === trimmedSize &&
            (item.color || '') === trimmedColor &&
            (item.lamp || '') === trimmedLamp &&
            (item.discount || 0) === discountVal)
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      }
      return [...prev, { product, quantity: 1, placeName: trimmedPlace, size: trimmedSize, color: trimmedColor, lamp: trimmedLamp, discount: discountVal }];
    });
  };

  const removeFromCart = (productId: string, options: { placeName?: string, size?: string, color?: string, lamp?: string, discount?: number }) => {
    const trimmedPlace = options.placeName || '';
    const trimmedSize = options.size || '';
    const trimmedColor = options.color || '';
    const trimmedLamp = options.lamp || '';
    const discountVal = options.discount || 0;
    setCart(prev => prev.filter(item => !(
      item.product.id === productId &&
      (item.placeName || '') === trimmedPlace &&
      (item.size || '') === trimmedSize &&
      (item.color || '') === trimmedColor &&
      (item.lamp || '') === trimmedLamp &&
      (item.discount || 0) === discountVal
    )));
  };

  const updateQuantity = (productId: string, options: { placeName?: string, size?: string, color?: string, lamp?: string, discount?: number }, qty: number) => {
    const trimmedPlace = options.placeName || '';
    const trimmedSize = options.size || '';
    const trimmedColor = options.color || '';
    const trimmedLamp = options.lamp || '';
    const discountVal = options.discount || 0;
    if (qty <= 0) { removeFromCart(productId, { placeName: trimmedPlace, size: trimmedSize, color: trimmedColor, lamp: trimmedLamp, discount: discountVal }); return; }
    setCart(prev => prev.map(item => (
      item.product.id === productId &&
      (item.placeName || '') === trimmedPlace &&
      (item.size || '') === trimmedSize &&
      (item.color || '') === trimmedColor &&
      (item.lamp || '') === trimmedLamp &&
      (item.discount || 0) === discountVal
    ) ? { ...item, quantity: qty } : item));
  };

  const subtotal = useMemo(() => cart.reduce((sum, item) => sum + ((item.product.price - (item.discount || 0)) * item.quantity), 0), [cart]);

  const filteredProducts = useMemo(() => {
    const term = searchTerm.toLowerCase().trim();
    let filtered = MOCK_PRODUCTS;

    // Apply search filter
    if (term) {
      filtered = filtered.filter(p =>
        p.name.toLowerCase().includes(term) ||
        p.description.toLowerCase().includes(term) ||
        p.category.toLowerCase().includes(term)
      );
    }

    // Apply category filter
    if (categoryFilter !== 'All') {
      filtered = filtered.filter(p => p.category === categoryFilter);
    }

    // Note: Color, Size, and Finishing filters would work here if products had these properties
    // For now, only category filter is functional

    return filtered;
  }, [searchTerm, categoryFilter, colorFilter, sizeFilter, finishingFilter]);

  const saveToLocal = (quote: Quotation) => {
    setSavedQuotes(prev => {
      const existingIdx = prev.findIndex(q => q.id === quote.id);
      const newList = existingIdx > -1 ? [...prev] : [quote, ...prev];
      if (existingIdx > -1) newList[existingIdx] = quote;
      localStorage.setItem(STORAGE_KEY, JSON.stringify(newList));
      return newList;
    });
    setIsSaved(true);
    setTimeout(() => setIsSaved(false), 2000);
  };

  const handleCreateQuotation = async () => {
    setIsGenerating(true);
    const quoteId = `MAG-${Math.random().toString(36).substr(2, 6).toUpperCase()}`;
    const quote: Quotation = {
      id: quoteId,
      customer,
      items: cart,
      date: new Date().toLocaleDateString('en-IN'),
      taxRate: 0.18,
      advanceAmount: customer.advanceAmount,
      advanceDate: customer.advanceDate,
      // manualRoundOff: manualRoundOff || undefined
      globalDiscountType: discountType || undefined,
      globalDiscountValue: discountValue > 0 ? discountValue : undefined
    };

    const minimalQuote = {
      ...quote,
      items: quote.items.map(item => ({
        quantity: item.quantity,
        placeName: item.placeName,
        size: item.size,
        color: item.color,
        lamp: item.lamp,
        discount: item.discount,
        productId: item.product.id
      }))
    };

    try {
      const summary = await generateQuoteSummary(quote);
      const encodedData = btoa(unescape(encodeURIComponent(JSON.stringify(minimalQuote))));

      // Warning for localhost
      if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
        alert("⚠️ WARNING: You are generating a QR code on 'localhost'.\n\nThis QR code will NOT work on other devices (like your phone).\n\nPlease open this app using your Network IP (e.g., 192.168.x.x) if you want the QR code to be scannable.");
      }

      const shareUrl = `${window.location.origin}${window.location.pathname}?data=${encodedData}&view=customer`;
      const qr = await QRCode.toDataURL(shareUrl, { width: 140, margin: 1 });

      setQrCodeUrl(qr);
      setShareUrl(shareUrl);
      setFinalQuote({ ...quote, aiSummary: summary });
      setView('PREVIEW');
    } catch (err) { console.error(err); } finally { setIsGenerating(false); }
  };

  const handleNewQuote = () => {
    if (finalQuote) saveToLocal(finalQuote);
    setCustomer({ name: '', email: '', phone: '', address: '', company: '' });
    setCart([]);
    setFinalQuote(null);
    setQrCodeUrl(null);
    setShareUrl(null);
    setSearchTerm('');
    setDiscountType(null);
    setDiscountValue(0);
    setView('CUSTOMER_ENTRY');
  };

  const handleExportExcel = () => {
    if (!finalQuote) return;
    const data = [
      ["Magnific Quotation"], ["ID", finalQuote.id], ["Date", finalQuote.date], ["Office", OFFICE_ADDRESS], [""],
      ["Customer"], ["Name", finalQuote.customer.name], ["Company", finalQuote.customer.company || ""], ["Email", finalQuote.customer.email], ["Phone", finalQuote.customer.phone], ["Address", finalQuote.customer.address], [""],
      ["Items"], ["S.No", "Model No", "Product", "Size", "Color", "Lamp", "Area", "Qty", "Unit Price", "Total"],
      ...finalQuote.items.map((i, idx) => [
        idx + 1,
        i.product.modelNumber,
        i.product.name,
        i.size || "N/A",
        i.color || "N/A",
        i.lamp || "N/A",
        i.placeName || "N/A",
        i.quantity,
        i.product.price,
        (i.product.price - (i.discount || 0)) * i.quantity
      ]),
      [""],
      [""],
      ["", "", "", "", "", "", "", "", "", "", "Gross Total", totalPrice(finalQuote.items)],
      ...(finalQuote.globalDiscountType ? [[
        "", "", "", "", "", "", "", "", "", "",
        `Discount (${finalQuote.globalDiscountType === 'flat' ? 'Flat' : finalQuote.globalDiscountValue + '%'})`,
        finalQuote.globalDiscountType === 'flat'
          ? -(finalQuote.globalDiscountValue || 0)
          : -Math.round(totalPrice(finalQuote.items) * (finalQuote.globalDiscountValue || 0) / 100)
      ]] : []),
      ["", "", "", "", "", "", "", "", "", "", "Net Total", totalPrice(finalQuote.items) - (finalQuote.globalDiscountType === 'flat' ? (finalQuote.globalDiscountValue || 0) : Math.round(totalPrice(finalQuote.items) * (finalQuote.globalDiscountValue || 0) / 100))],
      ["", "", "", "", "", "", "", "", "", "", "GST @18%", Math.round((totalPrice(finalQuote.items) - (finalQuote.globalDiscountType === 'flat' ? (finalQuote.globalDiscountValue || 0) : Math.round(totalPrice(finalQuote.items) * (finalQuote.globalDiscountValue || 0) / 100))) * 0.18)],
      ["", "", "", "", "", "", "", "", "", "", "Grand Total", Math.round((totalPrice(finalQuote.items) - (finalQuote.globalDiscountType === 'flat' ? (finalQuote.globalDiscountValue || 0) : Math.round(totalPrice(finalQuote.items) * (finalQuote.globalDiscountValue || 0) / 100))) * 1.18)]
    ];
    const ws = XLSX.utils.aoa_to_sheet(data);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Quotation");
    XLSX.writeFile(wb, `${finalQuote.id}.xlsx`);
  };

  const loadSaved = (q: Quotation) => {
    setFinalQuote(q);
    setCart(q.items);
    setCustomer(q.customer);
    setView('PREVIEW');
  };

  const deleteSaved = (e: React.MouseEvent, id: string) => {
    e.stopPropagation();
    const newList = savedQuotes.filter(q => q.id !== id);
    setSavedQuotes(newList);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(newList));
  };

  return (
    <div className="min-h-screen bg-slate-50 font-sans text-slate-900">
      {/* Navbar */}
      {!isPublicMode && (
        <nav className="bg-indigo-700 text-white shadow-md no-print sticky top-0 z-50">
          <div className="max-w-7xl mx-auto px-4 h-16 flex justify-between items-center">
            <div className="flex items-center space-x-2 cursor-pointer" onClick={() => setView('CUSTOMER_ENTRY')}>
              <span className="text-xl font-bold tracking-tight uppercase">Magnific</span>
            </div>
            <button
              onClick={() => setView('SAVED_QUOTES')}
              className="flex items-center space-x-1 px-3 py-1.5 rounded-lg hover:bg-indigo-600 transition-colors text-sm font-medium"
            >
              <HistoryIcon /> <span>Saved Quotes</span>
            </button>
          </div>
        </nav>
      )}

      <main className="max-w-7xl mx-auto px-4 py-8">

        {/* Registration View */}
        {view === 'CUSTOMER_ENTRY' && (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div className="lg:col-span-2 space-y-6">
              <div className="flex justify-between items-center">
                <h2 className="text-2xl font-bold text-slate-800 flex items-center">
                  <UserIcon /> <span className="ml-2">Visitor Information</span>
                </h2>
              </div>
              <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-8">
                <form onSubmit={(e) => { e.preventDefault(); setView('PRODUCT_SELECTION'); }} className="space-y-6">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Full Name</label>
                      <input required type="text" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Ex: Rahul Kumar" value={customer.name} onChange={e => setCustomer({ ...customer, name: e.target.value })} />
                    </div>
                    <div className="space-y-2">
                      <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Company / Firm</label>
                      <input type="text" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Optional" value={customer.company || ''} onChange={e => setCustomer({ ...customer, company: e.target.value })} />
                    </div>
                  </div>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Email Address</label>
                      <input type="email" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="rahul@example.com" value={customer.email} onChange={e => setCustomer({ ...customer, email: e.target.value })} />
                    </div>
                    <div className="space-y-2">
                      <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Phone Number</label>
                      <input type="tel" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="+91 00000 00000" value={customer.phone} onChange={e => setCustomer({ ...customer, phone: e.target.value })} />
                    </div>
                  </div>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Advance Paid (₹)</label>
                      <input type="number" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Ex: 50000" value={customer.advanceAmount || ''} onChange={e => setCustomer({ ...customer, advanceAmount: Number(e.target.value) })} />
                    </div>
                    <div className="space-y-2">
                      <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Advance Date</label>
                      <input type="text" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="DD.MM.YYYY" value={customer.advanceDate || ''} onChange={e => setCustomer({ ...customer, advanceDate: e.target.value })} />
                    </div>
                  </div>
                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Project Site Address</label>
                    <textarea rows={4} className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Enter complete site address for quotation..." value={customer.address} onChange={e => setCustomer({ ...customer, address: e.target.value })} />
                  </div>
                  <button type="submit" className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-xl transition-all shadow-lg shadow-indigo-200 active:scale-95 flex items-center justify-center space-x-2">
                    <span>Continue to Product Selection</span>
                    <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" /></svg>
                  </button>
                </form>
              </div>
            </div>
            <div className="lg:col-span-1">
              <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-8 sticky top-24 space-y-6">
                <div className="flex items-center space-x-3 text-indigo-600">
                  <div className="p-2 bg-indigo-50 rounded-lg">
                    <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                  </div>
                  <h3 className="text-lg font-bold text-slate-800">New Quotation</h3>
                </div>
                <p className="text-sm text-slate-500 leading-relaxed font-medium">
                  Welcome to the Magnific Designer Fans&Lights. Please provide the visitor information to begin generating a professional quotation.
                </p>
                <div className="space-y-4 pt-4 border-t">
                  <div className="flex items-start space-x-3">
                    <div className="mt-1 w-5 h-5 rounded-full bg-indigo-100 flex items-center justify-center flex-shrink-0">
                      <span className="text-[10px] font-bold text-indigo-600">1</span>
                    </div>
                    <div>
                      <h4 className="text-xs font-bold text-slate-700 uppercase tracking-wider">Registration</h4>
                      <p className="text-[11px] text-slate-400 font-medium">Capture customer and site details</p>
                    </div>
                  </div>
                  <div className="flex items-start space-x-3 opacity-50">
                    <div className="mt-1 w-5 h-5 rounded-full bg-slate-100 flex items-center justify-center flex-shrink-0">
                      <span className="text-[10px] font-bold text-slate-400">2</span>
                    </div>
                    <div>
                      <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Selection</h4>
                      <p className="text-[11px] text-slate-400 font-medium">Add fans and lights to the cart</p>
                    </div>
                  </div>
                  <div className="flex items-start space-x-3 opacity-50">
                    <div className="mt-1 w-5 h-5 rounded-full bg-slate-100 flex items-center justify-center flex-shrink-0">
                      <span className="text-[10px] font-bold text-slate-400">3</span>
                    </div>
                    <div>
                      <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Preview</h4>
                      <p className="text-[11px] text-slate-400 font-medium">Review and generate official form</p>
                    </div>
                  </div>
                </div>
                <div className="pt-6 border-t font-mono">
                  <div className="flex justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest mb-1">
                    <span>Office Location</span>
                  </div>
                  <p className="text-[11px] text-slate-600 font-bold">Magnific Fans & Lights • Koramangala</p>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Catalog View */}
        {view === 'PRODUCT_SELECTION' && (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div className="lg:col-span-2 space-y-6">
              <div className="flex justify-between items-center">
                <h2 className="text-2xl font-bold text-slate-800">Magnific Catalog</h2>
                <button onClick={() => setView('CUSTOMER_ENTRY')} className="text-indigo-600 hover:text-indigo-800 flex items-center text-sm font-bold">
                  <BackIcon /> <span className="ml-1">Registration</span>
                </button>
              </div>

              {/* Combined Filter Section */}
              <div className="bg-white rounded-xl p-4 shadow-sm border border-slate-200">
                <div className="space-y-4">
                  {/* Search Bar */}
                  <div>
                    <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Search Products</label>
                    <div className="relative">
                      <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                        <SearchIcon />
                      </div>
                      <input
                        type="text"
                        className="block w-full pl-10 pr-3 py-2.5 border border-slate-200 rounded-lg leading-5 bg-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-sm transition-all font-medium"
                        placeholder="Search by name, description..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                      />
                    </div>
                  </div>

                  {/* Multiple Searchable Filter Dropdowns */}
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">

                    {/* Category Filter Dropdown */}
                    <div className="relative">
                      <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Category</label>
                      <button
                        type="button"
                        onClick={() => setIsCategoryOpen(!isCategoryOpen)}
                        className="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm font-medium bg-white hover:bg-slate-50 focus:ring-2 focus:ring-indigo-500 transition-all flex items-center justify-between"
                      >
                        <span className="text-slate-700 truncate">{categoryFilter === 'All' ? 'All Products' : categoryFilter}</span>
                        <svg className={`w-4 h-4 text-slate-400 transition-transform flex-shrink-0 ${isCategoryOpen ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </button>
                      {isCategoryOpen && (
                        <>
                          <div className="absolute z-50 w-full mt-1 bg-white border border-slate-200 rounded-lg shadow-lg overflow-hidden">
                            <div className="p-2 border-b bg-slate-50">
                              <input
                                type="text"
                                placeholder="Search..."
                                value={categorySearch}
                                onChange={(e) => setCategorySearch(e.target.value)}
                                className="w-full px-2 py-1.5 border border-slate-200 rounded text-sm bg-white focus:ring-2 focus:ring-indigo-500 outline-none"
                                autoFocus
                              />
                            </div>
                            <div className="max-h-48 overflow-y-auto">
                              {['All', 'Fans', 'Lights'].filter(opt => opt.toLowerCase().includes(categorySearch.toLowerCase())).map(option => (
                                <button
                                  key={option}
                                  type="button"
                                  onClick={() => {
                                    setCategoryFilter(option);
                                    setIsCategoryOpen(false);
                                    setCategorySearch('');
                                  }}
                                  className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${categoryFilter === option ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                >
                                  {option === 'All' ? 'All Products' : option}
                                  {categoryFilter === option && <span className="float-right">✓</span>}
                                </button>
                              ))}
                            </div>
                          </div>
                          <div className="fixed inset-0 z-40" onClick={() => { setIsCategoryOpen(false); setCategorySearch(''); }} />
                        </>
                      )}
                    </div>

                    {/* Color Filter Dropdown */}
                    <div className="relative">
                      <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Color</label>
                      <button
                        type="button"
                        onClick={() => setIsColorOpen(!isColorOpen)}
                        className="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm font-medium bg-white hover:bg-slate-50 focus:ring-2 focus:ring-indigo-500 transition-all flex items-center justify-between"
                      >
                        <span className="text-slate-700 truncate">{colorFilter === 'All' ? 'All Colors' : colorFilter}</span>
                        <svg className={`w-4 h-4 text-slate-400 transition-transform flex-shrink-0 ${isColorOpen ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </button>
                      {isColorOpen && (
                        <>
                          <div className="absolute z-50 w-full mt-1 bg-white border border-slate-200 rounded-lg shadow-lg overflow-hidden">
                            <div className="p-2 border-b bg-slate-50">
                              <input
                                type="text"
                                placeholder="Search..."
                                value={colorSearch}
                                onChange={(e) => setColorSearch(e.target.value)}
                                className="w-full px-2 py-1.5 border border-slate-200 rounded text-sm bg-white focus:ring-2 focus:ring-indigo-500 outline-none"
                                autoFocus
                              />
                            </div>
                            <div className="max-h-48 overflow-y-auto">
                              {['All', 'White', 'Black', 'Gold', 'Silver', 'Bronze'].filter(opt => opt.toLowerCase().includes(colorSearch.toLowerCase())).map(option => (
                                <button
                                  key={option}
                                  type="button"
                                  onClick={() => {
                                    setColorFilter(option);
                                    setIsColorOpen(false);
                                    setColorSearch('');
                                  }}
                                  className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${colorFilter === option ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                >
                                  {option === 'All' ? 'All Colors' : option}
                                  {colorFilter === option && <span className="float-right">✓</span>}
                                </button>
                              ))}
                            </div>
                          </div>
                          <div className="fixed inset-0 z-40" onClick={() => { setIsColorOpen(false); setColorSearch(''); }} />
                        </>
                      )}
                    </div>

                    {/* Size Filter Dropdown */}
                    <div className="relative">
                      <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Size</label>
                      <button
                        type="button"
                        onClick={() => setIsSizeOpen(!isSizeOpen)}
                        className="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm font-medium bg-white hover:bg-slate-50 focus:ring-2 focus:ring-indigo-500 transition-all flex items-center justify-between"
                      >
                        <span className="text-slate-700 truncate">{sizeFilter === 'All' ? 'All Sizes' : `${sizeFilter}"`}</span>
                        <svg className={`w-4 h-4 text-slate-400 transition-transform flex-shrink-0 ${isSizeOpen ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </button>
                      {isSizeOpen && (
                        <>
                          <div className="absolute z-50 w-full mt-1 bg-white border border-slate-200 rounded-lg shadow-lg overflow-hidden">
                            <div className="p-2 border-b bg-slate-50">
                              <input
                                type="text"
                                placeholder="Search..."
                                value={sizeSearch}
                                onChange={(e) => setSizeSearch(e.target.value)}
                                className="w-full px-2 py-1.5 border border-slate-200 rounded text-sm bg-white focus:ring-2 focus:ring-indigo-500 outline-none"
                                autoFocus
                              />
                            </div>
                            <div className="max-h-48 overflow-y-auto">
                              {['All', '24', '36', '48', '52', '60'].filter(opt => opt.toLowerCase().includes(sizeSearch.toLowerCase())).map(option => (
                                <button
                                  key={option}
                                  type="button"
                                  onClick={() => {
                                    setSizeFilter(option);
                                    setIsSizeOpen(false);
                                    setSizeSearch('');
                                  }}
                                  className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${sizeFilter === option ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                >
                                  {option === 'All' ? 'All Sizes' : `${option} Inch`}
                                  {sizeFilter === option && <span className="float-right">✓</span>}
                                </button>
                              ))}
                            </div>
                          </div>
                          <div className="fixed inset-0 z-40" onClick={() => { setIsSizeOpen(false); setSizeSearch(''); }} />
                        </>
                      )}
                    </div>

                    {/* Finishing Filter Dropdown */}
                    <div className="relative">
                      <label className="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Finishing</label>
                      <button
                        type="button"
                        onClick={() => setIsFinishingOpen(!isFinishingOpen)}
                        className="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm font-medium bg-white hover:bg-slate-50 focus:ring-2 focus:ring-indigo-500 transition-all flex items-center justify-between"
                      >
                        <span className="text-slate-700 truncate">{finishingFilter === 'All' ? 'All Finishes' : finishingFilter}</span>
                        <svg className={`w-4 h-4 text-slate-400 transition-transform flex-shrink-0 ${isFinishingOpen ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </button>
                      {isFinishingOpen && (
                        <>
                          <div className="absolute z-50 w-full mt-1 bg-white border border-slate-200 rounded-lg shadow-lg overflow-hidden">
                            <div className="p-2 border-b bg-slate-50">
                              <input
                                type="text"
                                placeholder="Search..."
                                value={finishingSearch}
                                onChange={(e) => setFinishingSearch(e.target.value)}
                                className="w-full px-2 py-1.5 border border-slate-200 rounded text-sm bg-white focus:ring-2 focus:ring-indigo-500 outline-none"
                                autoFocus
                              />
                            </div>
                            <div className="max-h-48 overflow-y-auto">
                              {['All', 'Matte', 'Glossy', 'Brushed', 'Polished'].filter(opt => opt.toLowerCase().includes(finishingSearch.toLowerCase())).map(option => (
                                <button
                                  key={option}
                                  type="button"
                                  onClick={() => {
                                    setFinishingFilter(option);
                                    setIsFinishingOpen(false);
                                    setFinishingSearch('');
                                  }}
                                  className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${finishingFilter === option ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                >
                                  {option === 'All' ? 'All Finishes' : option}
                                  {finishingFilter === option && <span className="float-right">✓</span>}
                                </button>
                              ))}
                            </div>
                          </div>
                          <div className="fixed inset-0 z-40" onClick={() => { setIsFinishingOpen(false); setFinishingSearch(''); }} />
                        </>
                      )}
                    </div>

                  </div>
                </div>

                {/* Active Filters Display */}
                {(searchTerm || categoryFilter !== 'All' || colorFilter !== 'All' || sizeFilter !== 'All' || finishingFilter !== 'All') && (
                  <div className="mt-3 pt-3 border-t border-slate-100 flex items-center justify-between flex-wrap gap-2">
                    <div className="flex items-center space-x-2 flex-wrap gap-2">
                      <span className="text-xs font-bold text-slate-500 uppercase tracking-wider">Active:</span>
                      {searchTerm && (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-indigo-100 text-indigo-800">
                          🔍 "{searchTerm}"
                          <button onClick={() => setSearchTerm('')} className="ml-1.5 text-indigo-500 hover:text-indigo-800 focus:outline-none">
                            <svg className="h-3 w-3" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" /></svg>
                          </button>
                        </span>
                      )}
                      {categoryFilter !== 'All' && (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-indigo-100 text-indigo-800">
                          📂 {categoryFilter}
                          <button onClick={() => setCategoryFilter('All')} className="ml-1.5 text-indigo-500 hover:text-indigo-800 focus:outline-none">
                            <svg className="h-3 w-3" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" /></svg>
                          </button>
                        </span>
                      )}
                      {colorFilter !== 'All' && (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-indigo-100 text-indigo-800">
                          🎨 {colorFilter}
                          <button onClick={() => setColorFilter('All')} className="ml-1.5 text-indigo-500 hover:text-indigo-800 focus:outline-none">
                            <svg className="h-3 w-3" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" /></svg>
                          </button>
                        </span>
                      )}
                      {sizeFilter !== 'All' && (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-indigo-100 text-indigo-800">
                          📏 {sizeFilter}"
                          <button onClick={() => setSizeFilter('All')} className="ml-1.5 text-indigo-500 hover:text-indigo-800 focus:outline-none">
                            <svg className="h-3 w-3" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" /></svg>
                          </button>
                        </span>
                      )}
                      {finishingFilter !== 'All' && (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-indigo-100 text-indigo-800">
                          ✨ {finishingFilter}
                          <button onClick={() => setFinishingFilter('All')} className="ml-1.5 text-indigo-500 hover:text-indigo-800 focus:outline-none">
                            <svg className="h-3 w-3" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" /></svg>
                          </button>
                        </span>
                      )}
                    </div>
                    <button
                      onClick={() => {
                        setCategoryFilter('All');
                        setColorFilter('All');
                        setSizeFilter('All');
                        setFinishingFilter('All');
                        setSearchTerm('');
                      }}
                      className="px-3 py-1.5 text-xs font-bold text-red-600 hover:bg-red-50 rounded-lg transition-all flex items-center space-x-1"
                    >
                      <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                      </svg>
                      <span>Clear All</span>
                    </button>
                  </div>
                )}
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                {filteredProducts.map(p => (
                  <ProductCard key={p.id} product={p} onAddClick={() => setSelectedProduct(p)} />
                ))}
              </div>
            </div>
            {selectedProduct && (
              <ProductModal
                product={selectedProduct}
                onClose={() => setSelectedProduct(null)}
                onAdd={(options) => {
                  addToCart(selectedProduct, options);
                  setSelectedProduct(null);
                }}
              />
            )}
            <div className="lg:col-span-1">
              <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-6 sticky top-24">
                <h3 className="text-lg font-bold mb-4 flex items-center border-b pb-2">
                  <CartIcon /> <span className="ml-2">Selection Cart</span>
                </h3>
                <div className="space-y-4 max-h-[400px] overflow-y-auto mb-6 pr-2 no-scrollbar">
                  {cart.length === 0 ? <p className="text-slate-400 text-center py-8 italic text-sm">Cart is empty</p> :
                    cart.map((item, idx) => (
                      <CartItem
                        key={`${item.product.id}-${item.placeName}-${item.size}-${item.color}-${idx}`}
                        item={item}
                        onRemove={() => removeFromCart(item.product.id, {
                          placeName: item.placeName,
                          size: item.size,
                          color: item.color,
                          lamp: item.lamp,
                          discount: item.discount
                        })}
                        onQtyChange={q => updateQuantity(item.product.id, {
                          placeName: item.placeName,
                          size: item.size,
                          color: item.color,
                          lamp: item.lamp,
                          discount: item.discount
                        }, q)}
                      />
                    ))
                  }
                </div>
                {cart.length > 0 && (
                  <div className="border-t pt-4 space-y-3">
                    <div className="flex justify-between font-bold text-lg text-slate-900">
                      <span>Subtotal</span>
                      <span>₹{subtotal.toLocaleString('en-IN')}</span>
                    </div>

                    <div className="bg-slate-50 p-3 rounded-lg border border-slate-200 space-y-3">
                      <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block">Global Discount</label>

                      {/* Toggles */}
                      <div className="flex space-x-2">
                        <button
                          onClick={() => setDiscountType(discountType === 'flat' ? null : 'flat')}
                          className={`flex-1 py-1.5 text-xs font-bold rounded-md border transition-all ${discountType === 'flat' ? 'bg-indigo-600 text-white border-indigo-600' : 'bg-white text-slate-600 border-slate-300 hover:border-indigo-400'}`}
                        >
                          Flat (₹)
                        </button>
                        <button
                          onClick={() => setDiscountType(discountType === 'percentage' ? null : 'percentage')}
                          className={`flex-1 py-1.5 text-xs font-bold rounded-md border transition-all ${discountType === 'percentage' ? 'bg-indigo-600 text-white border-indigo-600' : 'bg-white text-slate-600 border-slate-300 hover:border-indigo-400'}`}
                        >
                          Percentage (%)
                        </button>
                      </div>

                      {/* Input */}
                      {discountType && (
                        <div className="flex items-center space-x-2 bg-white px-3 py-2 border rounded-md focus-within:ring-2 ring-indigo-500/20 ring-offset-1">
                          <span className="text-slate-400 font-bold">{discountType === 'flat' ? '₹' : '%'}</span>
                          <input
                            type="number"
                            className="w-full bg-transparent outline-none font-bold text-slate-900 placeholder-slate-300"
                            placeholder={discountType === 'flat' ? "Enter amount" : "Enter percentage"}
                            value={discountValue || ''}
                            onChange={(e) => setDiscountValue(Number(e.target.value))}
                          />
                        </div>
                      )}

                      {/* Summary Preview */}
                      {discountType && discountValue > 0 && (
                        <div className="pt-2 border-t border-slate-200 space-y-1 text-xs">
                          <div className="flex justify-between text-slate-500">
                            <span>Subtotal:</span>
                            <span>₹{subtotal.toLocaleString('en-IN')}</span>
                          </div>
                          <div className="flex justify-between text-red-500 font-medium">
                            <span>Discount:</span>
                            <span>-₹{(discountType === 'flat' ? discountValue : Math.round(subtotal * discountValue / 100)).toLocaleString('en-IN')}</span>
                          </div>
                          <div className="flex justify-between font-bold text-slate-900 pt-1">
                            <span>New Net Total:</span>
                            <span>₹{(subtotal - (discountType === 'flat' ? discountValue : Math.round(subtotal * discountValue / 100))).toLocaleString('en-IN')}</span>
                          </div>
                        </div>
                      )}
                    </div>

                    <p className="text-[10px] text-slate-400 italic text-center">* GST to be calculated manually</p>
                    <button
                      onClick={handleCreateQuotation}
                      disabled={isGenerating}
                      className="w-full bg-green-600 hover:bg-green-700 text-white font-bold py-3 rounded-xl transition-all shadow-md flex items-center justify-center disabled:opacity-50"
                    >
                      {isGenerating ? "Processing..." : "Generate Quote"}
                    </button>
                  </div>
                )}
              </div>
            </div>
          </div>
        )}

        {/* History View */}
        {view === 'SAVED_QUOTES' && (
          <div className="max-w-4xl mx-auto">
            <div className="flex justify-between items-center mb-8">
              <h2 className="text-3xl font-bold text-slate-800">Quote Archive</h2>
              <button onClick={() => setView('CUSTOMER_ENTRY')} className="bg-white border text-slate-700 px-4 py-2 rounded-lg font-bold text-sm shadow-sm hover:bg-slate-50 flex items-center">
                <BackIcon /> <span className="ml-1">Home</span>
              </button>
            </div>
            {savedQuotes.length === 0 ? (
              <div className="bg-white rounded-xl p-16 text-center shadow-sm border border-slate-200">
                <p className="text-slate-400 font-medium italic">No quotations found in local history.</p>
              </div>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {savedQuotes.map(q => (
                  <div key={q.id} onClick={() => loadSaved(q)} className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm hover:border-indigo-400 cursor-pointer transition-all group">
                    <div className="flex justify-between items-start mb-2">
                      <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-widest">{q.id}</span>
                      <button onClick={(e) => deleteSaved(e, q.id)} className="text-slate-300 hover:text-red-500 opacity-0 group-hover:opacity-100 transition-opacity p-1"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg></button>
                    </div>
                    <h4 className="font-bold text-slate-800 text-lg">{q.customer.name}</h4>
                    <p className="text-xs text-slate-400 font-medium mb-3">{q.date}</p>
                    <div className="flex justify-between items-center pt-3 border-t">
                      <span className="text-slate-500 text-xs">Items: {q.items.length}</span>
                      <span className="font-bold text-indigo-700">₹{q.items.reduce((s, i) => s + (i.product.price * i.quantity), 0).toLocaleString('en-IN')}</span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* Preview View */}
        {view === 'PREVIEW' && finalQuote && (
          <div className="max-w-4xl mx-auto">
            {/* Action Buttons */}
            {!isPublicMode && (
              <div className="flex flex-wrap justify-between items-center gap-3 mb-6 no-print">
                <button onClick={() => setView('PRODUCT_SELECTION')} className="text-slate-600 hover:text-indigo-700 flex items-center font-bold bg-white px-4 py-2 rounded-lg border shadow-sm">
                  <BackIcon /> <span className="ml-1">Edit Selection</span>
                </button>
                <div className="flex space-x-2">
                  <button onClick={() => saveToLocal(finalQuote)} className={`${isSaved ? 'bg-green-600 text-white' : 'bg-white border text-slate-700 hover:bg-slate-50'} px-4 py-2 rounded-lg shadow-sm font-bold flex items-center transition-all`}>
                    <SaveIcon /> {isSaved ? 'Saved' : 'Save'}
                  </button>
                  <button onClick={handleExportExcel} className="bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-lg shadow-sm font-bold flex items-center">
                    <ExcelIcon /> Excel
                  </button>
                  <button onClick={() => window.print()} className="bg-indigo-700 hover:bg-indigo-800 text-white px-4 py-2 rounded-lg shadow-sm font-bold flex items-center">
                    Print
                  </button>
                  <button onClick={handleNewQuote} className="bg-slate-800 hover:bg-black text-white px-4 py-2 rounded-lg font-bold">
                    New Quote
                  </button>
                </div>
              </div>
            )}

            {/* Quote Sheet */}
            <div className="bg-white rounded-xl shadow-xl overflow-hidden print:shadow-none border border-slate-100 print:border-none">
              <QuotationSheet quote={finalQuote} subtotal={subtotal} qrCodeUrl={qrCodeUrl} shareUrl={shareUrl} isCustomerView={isCustomerView} />
            </div>
          </div>
        )}

      </main>
    </div>
  );
}

function ProductModal({ product, onClose, onAdd }: { product: Product, onClose: () => void, onAdd: (options: { placeName: string, size: string, color: string, lamp: string }) => void }) {
  const [place, setPlace] = useState('');
  const [size, setSize] = useState('');
  const [color, setColor] = useState('');
  const [lamp, setLamp] = useState('');
  const [activeImg, setActiveImg] = useState(product.image);
  const gallery = [product.image, ...(product.gallery || [])];

  return (
    <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-4xl overflow-hidden flex flex-col md:flex-row animate-in zoom-in-95 duration-200">
        {/* Left Side: Images */}
        <div className="md:w-1/2 bg-slate-100 flex flex-col">
          <div className="relative flex-1 min-h-[300px]">
            <img src={activeImg} alt={product.name} className="absolute inset-0 w-full h-full object-cover" />
            <button onClick={onClose} className="absolute top-4 left-4 md:hidden bg-white/80 p-2 rounded-full shadow-md text-slate-800">
              <BackIcon />
            </button>
          </div>
          <div className="p-4 bg-white/50 backdrop-blur flex justify-center space-x-2 overflow-x-auto no-scrollbar border-t">
            {gallery.map((img, idx) => (
              <button
                key={idx}
                onClick={() => setActiveImg(img)}
                className={`w-14 h-14 rounded-lg border-2 flex-shrink-0 transition-all ${activeImg === img ? 'border-indigo-600 ring-2 ring-indigo-100 shadow-sm' : 'border-transparent opacity-60'}`}
              >
                <img src={img} className="w-full h-full object-cover rounded-md" />
              </button>
            ))}
          </div>
        </div>

        {/* Right Side: Configuration */}
        <div className="md:w-1/2 p-8 flex flex-col">
          <div className="flex justify-between items-start mb-4">
            <div>
              <div className="flex items-center space-x-2">
                <span className="text-xs font-bold text-indigo-600 uppercase tracking-widest">{product.category}</span>
                <span className="text-[10px] bg-slate-100 text-slate-500 px-2 py-0.5 rounded font-mono font-bold">{product.modelNumber}</span>
              </div>
              <h2 className="text-2xl font-bold text-slate-900 mt-1">{product.name}</h2>
            </div>
            <button onClick={onClose} className="hidden md:block text-slate-400 hover:text-slate-600 transition-colors">
              <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
            </button>
          </div>

          <p className="text-slate-500 text-sm mb-8 leading-relaxed">{product.description}</p>

          <div className="space-y-6 flex-1">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Product Size</label>
                <input
                  type="text"
                  placeholder="e.g. 48 Inch / XXL"
                  className="w-full p-3 border rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 font-medium text-sm transition-all"
                  value={size}
                  onChange={e => setSize(e.target.value)}
                />
              </div>
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Body Color</label>
                <input
                  type="text"
                  placeholder="e.g. Matte Black"
                  className="w-full p-3 border rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 font-medium text-sm transition-all"
                  value={color}
                  onChange={e => setColor(e.target.value)}
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Lamp / Bulb Type</label>
                <input
                  type="text"
                  placeholder="e.g. Warm White 12W"
                  className="w-full p-3 border rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 font-medium text-sm transition-all"
                  value={lamp}
                  onChange={e => setLamp(e.target.value)}
                />
              </div>
            </div>

            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Installation Room / Place</label>
              <input
                type="text"
                placeholder="Ex: Master Bedroom, Living Area..."
                className="w-full p-3 border rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 font-medium text-sm transition-all"
                value={place}
                onChange={e => setPlace(e.target.value)}
              />
            </div>
          </div>

          <div className="pt-8 border-t mt-8 flex items-center justify-between">
            <div className="flex flex-col">
              <span className="text-[10px] font-bold text-slate-400 uppercase">Price per unit</span>
              <span className="text-2xl font-bold text-indigo-700">₹{product.price.toLocaleString('en-IN')}</span>
            </div>
            <button
              onClick={() => onAdd({ placeName: place, size, color, lamp, discount: 0 })}
              className="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3.5 rounded-xl font-bold transition-all shadow-lg active:scale-95 flex items-center"
            >
              <CartIcon /> <span className="ml-2">Add to Quotation</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

// Components
function ProductCard({ product, onAddClick }: { product: Product, onAddClick: () => void, key?: React.Key }) {
  const [activeImg, setActiveImg] = useState(product.image);
  const gallery = [product.image, ...(product.gallery || [])];

  return (
    <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden flex flex-col h-full group transition-all hover:shadow-md cursor-pointer" onClick={onAddClick}>
      <div className="relative h-52 overflow-hidden bg-slate-100">
        <img src={activeImg} alt={product.name} className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" />
        <div className="absolute top-3 right-3 bg-indigo-600 text-white text-[10px] font-bold px-2 py-1 rounded shadow-sm">{product.category}</div>
      </div>
      <div className="p-2 bg-slate-50 border-b flex space-x-2 overflow-x-auto no-scrollbar" onClick={e => e.stopPropagation()}>
        {gallery.map((img, idx) => (
          <button key={idx} onMouseEnter={() => setActiveImg(img)} onClick={() => setActiveImg(img)} className={`w-10 h-10 rounded border-2 flex-shrink-0 transition-all ${activeImg === img ? 'border-indigo-600 ring-2 ring-indigo-100' : 'border-transparent opacity-60'}`}>
            <img src={img} className="w-full h-full object-cover rounded-[1px]" />
          </button>
        ))}
      </div>
      <div className="p-5 flex-1 flex flex-col">
        <h3 className="font-bold text-slate-900 mb-1">{product.name}</h3>
        <p className="text-slate-500 text-xs mb-4 line-clamp-2 h-8 leading-relaxed font-medium">{product.description}</p>

        <div className="mt-auto">
          <div className="flex justify-between items-center">
            <span className="text-xl font-bold text-indigo-700">₹{product.price.toLocaleString('en-IN')}</span>
            <div className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center transition-all active:scale-95 shadow-sm">
              <CartIcon /> <span className="ml-2">Add</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

function CartItem({ item, onRemove, onQtyChange }: { item: QuoteItem, onRemove: () => void, onQtyChange: (q: number) => void }) {
  return (
    <div className="flex flex-col p-3 bg-slate-50 rounded-xl group border border-slate-100 space-y-2">
      <div className="flex items-center space-x-3">
        <img src={item.product.image} className="w-12 h-12 rounded-lg object-cover bg-white border shadow-sm" />
        <div className="flex-1 min-w-0">
          <p className="text-xs font-bold text-slate-800 truncate leading-tight">{item.product.name}</p>
          <div className="flex items-center space-x-2 mt-0.5">
            {item.size && <span className="text-[9px] bg-slate-200 text-slate-600 px-1.5 py-0.5 rounded font-bold">{item.size}</span>}
            {item.color && <span className="text-[9px] bg-slate-200 text-slate-600 px-1.5 py-0.5 rounded font-bold">{item.color}</span>}
          </div>
          <p className="text-[10px] text-indigo-600 font-bold mt-1">₹{item.product.price.toLocaleString('en-IN')}</p>
        </div>
        <button onClick={onRemove} className="text-slate-300 hover:text-red-500 p-1 opacity-100 lg:opacity-0 group-hover:opacity-100 transition-opacity">
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
        </button>
      </div>
      <div className="flex justify-between items-center pt-1 border-t border-slate-200">
        <span className="text-[10px] text-slate-500 font-bold italic truncate flex-1 mr-2">{item.placeName || "Unspecified Area"}</span>
        <div className="flex items-center bg-white border rounded shadow-sm overflow-hidden flex-shrink-0">
          <button onClick={() => onQtyChange(item.quantity - 1)} className="px-2 py-0.5 hover:bg-slate-50 text-slate-500 font-bold">-</button>
          <span className="px-1 text-[10px] font-bold w-5 text-center">{item.quantity}</span>
          <button onClick={() => onQtyChange(item.quantity + 1)} className="px-2 py-0.5 hover:bg-slate-50 text-slate-500 font-bold">+</button>
        </div>
      </div>
    </div>
  );
}

function QuotationSheet({ quote, subtotal, qrCodeUrl, shareUrl, isCustomerView }: { quote: Quotation, subtotal: number, qrCodeUrl?: string | null, shareUrl?: string | null, isCustomerView?: boolean }) {
  return (
    <div className="flex flex-col min-h-full">
      {/* Top Banner */}
      <div className="w-full bg-[#004aad] text-white text-center py-2 font-bold tracking-[0.2em] uppercase text-sm print:text-xs print:py-1.5">
        Quotation
      </div>

      <div className="p-10 print:p-8 flex-1">
        <div className="flex justify-between items-end border-b-2 border-slate-800 pb-4 mb-2">
          <div>
            <div className="mb-2">
              <img src="./assets/magnific-web.png" alt="website logo" className="w-[100px] font-black text-indigo-600 tracking-tighter italic mb-4" />
              <div className="flex items-center space-x-2 mt-[-4px]">

                <div className="h-[1px] bg-slate-400 flex-1"></div>

                <span className="text-[7px] font-bold text-slate-500 uppercase tracking-[0.2em] whitespace-nowrap">Designer Fans — Luxury Premium Lighting</span>
                <div className="h-[1px] bg-slate-400 flex-1"></div>
              </div>
            </div>
            <div className="text-[9px] text-slate-800 font-medium leading-tight">
              <p>No. 42/1, 2nd Floor, I-Towers, 100ft Intermediate Ring Road</p>
              <p>(Near Royal Oak), Koramangala, Bengaluru - 560047</p>
              <p>Tel: +91 80413 27081, +91 78928 27670 E: info@magnific.in</p>
            </div>
          </div>
          <div className="text-right text-[10px] font-bold text-slate-900 space-y-0.5">
            <p>Quatation.No: {quote.id}</p>
            <p>Date: {quote.date}</p>
          </div>
        </div>

        {!isCustomerView && (
          <div className="mb-6 text-[12px]">
            <div className="flex space-x-1">
              <span className="font-bold w-12 text-slate-900 whitespace-nowrap">To:</span>
              <span className="font-bold text-slate-800 uppercase">{quote.customer.name}</span>
            </div>
            <div className="flex space-x-1">
              <span className="font-bold w-12 text-slate-900 whitespace-nowrap">Phone:</span>
              <span className="font-medium text-slate-700">{quote.customer.phone}</span>
            </div>
          </div>
        )}


        {/* Desktop Table View */}
        <table className="w-full mb-8 border-[1.5px] border-slate-900 border-collapse table-fixed hidden md:table">
          <thead>
            <tr className="bg-slate-200/80 border-[1.5px] border-slate-900">
              <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[6%]">S.NO.</th>
              <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[30%]">MODEL & IMAGE</th>
              {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[14%]">TECHNICAL DETAILS</th>}
              <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[7%]">QTY</th>
              {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[13%]">AREA</th>}
              <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[10%]">PRICE</th>
              {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] font-bold text-slate-800 uppercase text-center w-[10%]">TOTAL</th>}
            </tr>
          </thead>
          <tbody>
            {quote.items.map((i, idx) => (
              <tr key={idx} className="border-[1.5px] border-slate-900">
                <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center text-[12px] font-bold text-slate-900">{idx + 1}</td>
                <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center">
                  <div className="flex flex-col items-center justify-center space-y-2">
                    <img src={i.product.image} className="w-24 h-24 object-contain" alt={i.product.name} />
                    <span className="text-[10px] font-black text-slate-900 uppercase tracking-tight">{i.product.modelNumber}</span>
                    {isCustomerView && <span className="text-[11px] font-bold text-slate-700">{i.product.name}</span>}
                  </div>
                </td>

                {!isCustomerView && (
                  <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center align-middle">
                    <div className="flex flex-col items-center justify-center space-y-1 w-full">
                      {i.size && (
                        <div className="text-[10px] flex items-center space-x-1">
                          <span className="font-bold text-slate-500 uppercase">Size:</span>
                          <span className="font-bold text-slate-900">{i.size}</span>
                        </div>
                      )}
                      {i.lamp && (
                        <div className="text-[10px] flex items-center space-x-1">
                          <span className="font-bold text-slate-500 uppercase">Lamp:</span>
                          <span className="font-bold text-slate-900">{i.lamp}</span>
                        </div>
                      )}
                      {i.color && (
                        <div className="text-[10px] flex items-center space-x-1">
                          <span className="font-bold text-slate-500 uppercase">Finish:</span>
                          <span className="font-bold text-indigo-700">{i.color}</span>
                        </div>
                      )}
                    </div>
                  </td>
                )}

                <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center text-[12px] font-bold text-slate-900">{i.quantity}</td>

                {!isCustomerView && (
                  <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center text-[11px] font-bold text-slate-900 leading-tight">
                    {i.placeName || '-'}
                  </td>
                )}

                <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center text-[12px] font-bold text-slate-900">
                  {i.product.price.toLocaleString('en-IN')}
                </td>

                {!isCustomerView && (
                  <td className="border-[1.5px] border-slate-900 py-4 px-2 text-center text-[12px] font-black text-slate-900">
                    {((i.product.price - (i.discount || 0)) * i.quantity).toLocaleString('en-IN')}
                  </td>
                )}
              </tr>
            ))}
          </tbody>
          {!isCustomerView && (
            <tfoot>
              <tr>
                <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">Gross Total</td>
                <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">{totalPrice(quote.items).toLocaleString('en-IN')}</td>
              </tr>

              {quote.globalDiscountType && (
                <tr>
                  <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-red-600 uppercase leading-none">
                    Discount ({quote.globalDiscountType === 'flat' ? 'Flat' : `${quote.globalDiscountValue}%`})
                  </td>
                  <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-red-600 leading-none">
                    -{(quote.globalDiscountType === 'flat'
                      ? (quote.globalDiscountValue || 0)
                      : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100)
                    ).toLocaleString('en-IN')}
                  </td>
                </tr>
              )}

              <tr>
                <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">Net Total</td>
                <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                  {(totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))).toLocaleString('en-IN')}
                </td>
              </tr>

              <tr>
                <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">GST @18%</td>
                <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                  {Math.round((totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))) * 0.18).toLocaleString('en-IN')}
                </td>
              </tr>
              {quote.advanceAmount ? (
                <>
                  <tr>
                    <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">Advance ({quote.advanceDate || 'N/A'})</td>
                    <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">{quote.advanceAmount.toLocaleString('en-IN')}</td>
                  </tr>
                  <tr>
                    <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Amount Paid</td>
                    <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[14px] font-black text-indigo-700 bg-slate-100 leading-none">
                      ₹{Math.round((totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))) * 1.18 - quote.advanceAmount).toLocaleString('en-IN')}
                    </td>
                  </tr>
                </>
              ) : (
                <tr>
                  <td colSpan={7} className="border-[1.5px] border-slate-900 py-3 px-4 text-right text-[12px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Grand Total</td>
                  <td className="border-[1.5px] border-slate-900 py-3 px-2 text-center text-[14px] font-black text-indigo-700 bg-slate-100 leading-none">
                    ₹{Math.round((totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))) * 1.18).toLocaleString('en-IN')}
                  </td>
                </tr>
              )}
            </tfoot>
          )}
        </table>

        {/* Mobile Card View (Hidden on Desktop) */}
        <div className="md:hidden space-y-6 mb-8">
          {quote.items.map((i, idx) => (
            <div key={idx} className="bg-white border rounded-xl shadow-sm overflow-hidden">
              <div className="flex p-4 gap-4">
                {/* Image */}
                <div className="w-24 h-24 flex-shrink-0 bg-slate-50 rounded-lg flex items-center justify-center p-2 border">
                  <img src={i.product.image} className="w-full h-full object-contain" alt={i.product.name} />
                </div>
                {/* Header Info */}
                <div className="flex-1 min-w-0">
                  <div className="flex justify-between items-start">
                    <span className="text-[10px] bg-slate-100 text-slate-500 font-bold px-2 py-0.5 rounded uppercase tracking-wider">{i.product.modelNumber}</span>
                    <span className="text-xs font-bold text-slate-400">#{idx + 1}</span>
                  </div>
                  <h4 className="font-bold text-slate-900 text-sm mt-1 leading-tight">{i.product.name}</h4>

                  {!isCustomerView && (
                    <div className="mt-3 grid grid-cols-2 gap-2 text-[10px]">
                      {i.size && (
                        <div><span className="text-slate-400 font-bold">Size:</span> <span className="font-bold">{i.size}</span></div>
                      )}
                      {i.color && (
                        <div><span className="text-slate-400 font-bold">Color:</span> <span className="font-bold">{i.color}</span></div>
                      )}
                      {i.lamp && (
                        <div className="col-span-2"><span className="text-slate-400 font-bold">Lamp:</span> <span className="font-bold">{i.lamp}</span></div>
                      )}
                      {i.placeName && (
                        <div className="col-span-2 border-t pt-1 mt-1 text-slate-500 italic">{i.placeName}</div>
                      )}
                    </div>
                  )}
                </div>
              </div>

              {/* Pricing Footer */}
              <div className="bg-slate-50 px-4 py-3 border-t flex justify-between items-center text-xs">
                <div className="flex flex-col">
                  <span className="text-[10px] text-slate-400 font-bold uppercase">Qty: {i.quantity}</span>
                  <span className="font-medium text-slate-500 line-through text-[10px]">₹{i.product.price.toLocaleString('en-IN')}</span>
                </div>
                <div className="flex flex-col items-end">
                  {!isCustomerView && i.discount ? (
                    <>
                      <span className="text-[10px] text-green-600 font-bold">-{i.discount} Off</span>
                      <span className="font-black text-indigo-700 text-base">₹{((i.product.price - (i.discount || 0)) * i.quantity).toLocaleString('en-IN')}</span>
                    </>
                  ) : (
                    <span className="font-black text-indigo-700 text-base">₹{(i.product.price * i.quantity).toLocaleString('en-IN')}</span>
                  )}
                </div>
              </div>
            </div>
          ))}

          {/* Mobile Totals */}
          {!isCustomerView && (
            <div className="bg-slate-800 text-white rounded-xl p-4 space-y-2 text-xs">
              <div className="flex justify-between">
                <span className="text-slate-400">Gross Total</span>
                <span className="font-bold">{totalPrice(quote.items).toLocaleString('en-IN')}</span>
              </div>

              {quote.globalDiscountType && (
                <div className="flex justify-between text-red-400">
                  <span>Discount ({quote.globalDiscountType === 'flat' ? 'Flat' : `${quote.globalDiscountValue}%`})</span>
                  <span className="font-bold">
                    -{(quote.globalDiscountType === 'flat'
                      ? (quote.globalDiscountValue || 0)
                      : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100)
                    ).toLocaleString('en-IN')}
                  </span>
                </div>
              )}

              {quote.globalDiscountType && (
                <div className="flex justify-between border-t border-slate-700 pt-2">
                  <span className="text-slate-300">Net Total</span>
                  <span className="font-bold">
                    {(totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))).toLocaleString('en-IN')}
                  </span>
                </div>
              )}

              <div className="flex justify-between">
                <span className="text-slate-400">GST @18%</span>
                <span className="font-bold">
                  {Math.round((totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))) * 0.18).toLocaleString('en-IN')}
                </span>
              </div>

              {quote.advanceAmount ? (
                <>
                  <div className="flex justify-between">
                    <span className="text-slate-400">Advance ({quote.advanceDate || 'N/A'})</span>
                    <span className="font-bold">{quote.advanceAmount.toLocaleString('en-IN')}</span>
                  </div>
                  <div className="flex justify-between border-t border-slate-600 pt-2 text-sm">
                    <span className="font-bold uppercase tracking-wider">Amount Paid</span>
                    <span className="font-bold text-green-400">
                      ₹{Math.round((totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))) * 1.18 - quote.advanceAmount).toLocaleString('en-IN')}
                    </span>
                  </div>
                </>
              ) : (
                <div className="flex justify-between border-t border-slate-600 pt-2 text-sm">
                  <span className="font-bold uppercase tracking-wider">Grand Total</span>
                  <span className="font-bold text-green-400">
                    ₹{Math.round((totalPrice(quote.items) - (quote.globalDiscountType === 'flat' ? (quote.globalDiscountValue || 0) : Math.round(totalPrice(quote.items) * (quote.globalDiscountValue || 0) / 100))) * 1.18).toLocaleString('en-IN')}
                  </span>
                </div>
              )}
            </div>)}
        </div>

        {/* {!isCustomerView && (
        <div className="mb-8">
          <p className="text-[10px] text-slate-500 italic leading-tight">
            * This is a tentative quote. Final GST 18% as applicable and actual transport will be added manually at the time of final invoice.
          </p>
        </div>
      )} */}

        <div className="mt-12 pt-8 border-t border-slate-200">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
            {/* Banking Details */}
            <div className="space-y-4">
              <h4 className="text-sm font-bold text-slate-900 border-b pb-2 uppercase tracking-tight">Banking Details (RTGS / NEFT)</h4>
              <div className="space-y-2 text-xs text-slate-600">
                <div className="flex">
                  <span className="w-28 font-bold text-slate-400">Company Name</span>
                  <span className="font-bold text-slate-800">Magnific Home Appliances</span>
                </div>
                <div className="flex">
                  <span className="w-28 font-bold text-slate-400">Bank Name</span>
                  <span className="font-bold text-slate-800">Axis Bank</span>
                </div>
                <div className="flex">
                  <span className="w-28 font-bold text-slate-400">Account No</span>
                  <span className="font-bold text-indigo-700 tracking-wider">924030028295392</span>
                </div>
                <div className="flex">
                  <span className="w-28 font-bold text-slate-400">Branch</span>
                  <span className="font-bold text-slate-800">Koramangala</span>
                </div>
                <div className="flex">
                  <span className="w-28 font-bold text-slate-400">IFSC Code</span>
                  <span className="font-bold text-indigo-700 tracking-wider">UTIB0000194</span>
                </div>
              </div>
            </div>

            {/* QR Code / Summary */}
            {qrCodeUrl && (
              <div className="flex flex-col items-center justify-center p-6 border rounded-2xl bg-slate-50 relative group">
                {shareUrl ? (
                  <a href={shareUrl} target="_blank" rel="noopener noreferrer">
                    <img src={qrCodeUrl} alt="Magnific QR" className="w-28 h-28 mb-3 hover:scale-105 transition-transform cursor-pointer" />
                  </a>
                ) : (
                  <img src={qrCodeUrl} alt="Magnific QR" className="w-28 h-28 mb-3" />
                )}
                <p className="text-[10px] uppercase font-bold text-slate-400 tracking-widest">Scan Quote Online</p>
                <div className="absolute top-2 right-2 opacity-5">
                  <svg className="w-12 h-12" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M11.3 1.046A1 1 0 0112 2v5h4a1 1 0 01.82 1.573l-7 10A1 1 0 018 18v-5H4a1 1 0 01-.82-1.573l7-10a1 1 0 011.12-.38z" clipRule="evenodd" /></svg>
                </div>
              </div>
            )}
          </div>

          {/* Terms & Conditions */}
          <div className="mt-10 pt-8 border-t border-slate-100">
            <h4 className="text-sm font-bold text-slate-900 mb-6 uppercase tracking-tight">Terms & Conditions:</h4>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-3">
              {[
                "Validity: 15 Days from the date of quotation.",
                "Payment: 50% of advance to be paid while booking, 100% payment before delivery.",
                "If applicable: Kindly ensure your GST details are provided prior to the dispatch of the product. No changes can be made once the invoice is generated.",
                "No refunds will be issued unless there is an error on the company's part.",
                "Delivery of the product will only be considered once the customer's cheque has been issued and cleared. Until that time, no delivery can be expected, so customers should plan accordingly.",
                "Company is not responsible for any breakage.",
                "Goods once sold cannot be taken back or exchanged.",
                "Request you to co-operate until delivery is done.",
                "Product should be checked at the time of delivery itself.",
                "Bulbs are not included with the purchase of any light fittings.",
                "Bulbs are charged additionally.",
                "Freight charges exclusive. Installation is chargeable.",
                "The company will deliver light products only if the order value exceeds 50,000.",
                "Light customization will be charged based on requirements."
              ].map((term, i) => (
                <div key={i} className="flex space-x-3 items-start">
                  <span className="text-[10px] font-bold text-indigo-500 bg-indigo-50 w-5 h-5 flex items-center justify-center rounded-full flex-shrink-0">{i + 1}</span>
                  <p className="text-[11px] text-slate-500 leading-tight font-medium">{term}</p>
                </div>
              ))}
            </div>
          </div>

          <div className="mt-12 text-center pt-8 border-t border-slate-100">
            <p className="font-bold text-indigo-700 uppercase tracking-[0.4em] text-[10px]">Experience Luxury • Magnific Designer Fans and Lights • Koramangala</p>
          </div>
        </div>
      </div >

      <div className="w-full bg-[#004aad] text-white text-center py-2 font-bold tracking-widest text-sm print:text-xs print:py-1.5">
        www.magnific.in
      </div>
    </div >
  );
}

const totalPrice = (items: QuoteItem[]) => items.reduce((sum, item) => sum + ((item.product.price - (item.discount || 0)) * item.quantity), 0);
