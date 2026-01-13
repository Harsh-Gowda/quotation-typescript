
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
  const [customer, setCustomer] = useState<Customer>({ name: '', email: '', phone: '', address: '', company: '' });
  const [cart, setCart] = useState<QuoteItem[]>([]);
  const [isGenerating, setIsGenerating] = useState(false);
  const [finalQuote, setFinalQuote] = useState<Quotation | null>(null);
  const [qrCodeUrl, setQrCodeUrl] = useState<string | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [savedQuotes, setSavedQuotes] = useState<Quotation[]>([]);
  const [isSaved, setIsSaved] = useState(false);

  useEffect(() => {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      try { setSavedQuotes(JSON.parse(raw)); } catch (e) { console.error(e); }
    }
  }, []);

  const addToCart = (product: Product, placeName?: string) => {
    const trimmedPlace = placeName?.trim() || '';
    setCart(prev => {
      const existing = prev.find(item => item.product.id === product.id && (item.placeName || '') === trimmedPlace);
      if (existing) {
        return prev.map(item => (item.product.id === product.id && (item.placeName || '') === trimmedPlace) ? { ...item, quantity: item.quantity + 1 } : item);
      }
      return [...prev, { product, quantity: 1, placeName: trimmedPlace }];
    });
  };

  const removeFromCart = (productId: string, placeName?: string) => {
    const trimmedPlace = placeName || '';
    setCart(prev => prev.filter(item => !(item.product.id === productId && (item.placeName || '') === trimmedPlace)));
  };

  const updateQuantity = (productId: string, placeName: string | undefined, qty: number) => {
    const trimmedPlace = placeName || '';
    if (qty <= 0) { removeFromCart(productId, trimmedPlace); return; }
    setCart(prev => prev.map(item => (item.product.id === productId && (item.placeName || '') === trimmedPlace) ? { ...item, quantity: qty } : item));
  };

  const subtotal = useMemo(() => cart.reduce((sum, item) => sum + (item.product.price * item.quantity), 0), [cart]);

  const filteredProducts = useMemo(() => {
    const term = searchTerm.toLowerCase().trim();
    if (!term) return MOCK_PRODUCTS;
    return MOCK_PRODUCTS.filter(p => p.name.toLowerCase().includes(term) || p.description.toLowerCase().includes(term) || p.category.toLowerCase().includes(term));
  }, [searchTerm]);

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
    const quote: Quotation = { id: quoteId, customer, items: cart, date: new Date().toLocaleDateString('en-IN'), taxRate: 0 };
    try {
      const [summary, qr] = await Promise.all([
        generateQuoteSummary(quote),
        QRCode.toDataURL(`${window.location.origin}?quoteId=${quoteId}`, { width: 120, margin: 1 })
      ]);
      setQrCodeUrl(qr);
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
    setSearchTerm('');
    setView('CUSTOMER_ENTRY');
  };

  const handleExportExcel = () => {
    if (!finalQuote) return;
    const data = [
      ["Magnific Quotation"], ["ID", finalQuote.id], ["Date", finalQuote.date], ["Office", OFFICE_ADDRESS], [""],
      ["Customer"], ["Name", finalQuote.customer.name], ["Company", finalQuote.customer.company || ""], ["Email", finalQuote.customer.email], ["Phone", finalQuote.customer.phone], ["Address", finalQuote.customer.address], [""],
      ["Items"], ["Product", "Location", "Qty", "Price", "Total"],
      ...finalQuote.items.map(i => [i.product.name, i.placeName || "N/A", i.quantity, i.product.price, i.product.price * i.quantity]),
      [""], ["", "", "", "Net Total", subtotal]
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

      <main className="max-w-7xl mx-auto px-4 py-8">
        
        {/* Registration View */}
        {view === 'CUSTOMER_ENTRY' && (
          <div className="max-w-2xl mx-auto">
            <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-8">
              <h2 className="text-2xl font-bold mb-6 text-slate-800 flex items-center">
                <UserIcon /> <span className="ml-2">Visitor Information</span>
              </h2>
              <form onSubmit={(e) => { e.preventDefault(); setView('PRODUCT_SELECTION'); }} className="space-y-5">
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                  <div className="space-y-1">
                    <label className="text-xs font-bold text-slate-500 uppercase tracking-wide">Full Name</label>
                    <input required type="text" className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium" placeholder="Ex: Rahul Kumar" value={customer.name} onChange={e => setCustomer({...customer, name: e.target.value})} />
                  </div>
                  <div className="space-y-1">
                    <label className="text-xs font-bold text-slate-500 uppercase tracking-wide">Company / Firm</label>
                    <input type="text" className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium" placeholder="Optional" value={customer.company || ''} onChange={e => setCustomer({...customer, company: e.target.value})} />
                  </div>
                </div>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                  <div className="space-y-1">
                    <label className="text-xs font-bold text-slate-500 uppercase tracking-wide">Email</label>
                    <input required type="email" className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium" placeholder="rahul@example.com" value={customer.email} onChange={e => setCustomer({...customer, email: e.target.value})} />
                  </div>
                  <div className="space-y-1">
                    <label className="text-xs font-bold text-slate-500 uppercase tracking-wide">Phone</label>
                    <input required type="tel" className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium" placeholder="+91 00000 00000" value={customer.phone} onChange={e => setCustomer({...customer, phone: e.target.value})} />
                  </div>
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-bold text-slate-500 uppercase tracking-wide">Project Address</label>
                  <textarea rows={3} className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium" placeholder="Enter complete site address..." value={customer.address} onChange={e => setCustomer({...customer, address: e.target.value})} />
                </div>
                <button type="submit" className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-xl transition-all shadow-md active:scale-95">
                  Continue to Selection
                </button>
              </form>
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
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                  <SearchIcon />
                </div>
                <input
                  type="text"
                  className="block w-full pl-10 pr-3 py-3 border border-slate-200 rounded-xl leading-5 bg-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm transition-all shadow-sm font-medium"
                  placeholder="Search fans and lights..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                />
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                {filteredProducts.map(p => (
                  <ProductCard key={p.id} product={p} onAdd={(place) => addToCart(p, place)} />
                ))}
              </div>
            </div>
            <div className="lg:col-span-1">
              <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-6 sticky top-24">
                <h3 className="text-lg font-bold mb-4 flex items-center border-b pb-2">
                  <CartIcon /> <span className="ml-2">Selection Cart</span>
                </h3>
                <div className="space-y-4 max-h-[400px] overflow-y-auto mb-6 pr-2 no-scrollbar">
                  {cart.length === 0 ? <p className="text-slate-400 text-center py-8 italic text-sm">Cart is empty</p> : 
                    cart.map((item, idx) => (
                      <CartItem 
                        key={`${item.product.id}-${item.placeName}-${idx}`} 
                        item={item} 
                        onRemove={() => removeFromCart(item.product.id, item.placeName)} 
                        onQtyChange={q => updateQuantity(item.product.id, item.placeName, q)} 
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
                      <span className="font-bold text-indigo-700">₹{q.items.reduce((s,i) => s + (i.product.price * i.quantity), 0).toLocaleString('en-IN')}</span>
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

            {/* Quote Sheet */}
            <div className="bg-white rounded-lg shadow-xl p-10 print:shadow-none print:p-0 border border-slate-100">
              <div className="flex justify-between items-start border-b-2 pb-8 mb-8">
                <div>
                  <div className="flex items-center space-x-3 mb-4">
                    <h1 className="text-3xl font-bold text-slate-900 tracking-tight">MAGNIFIC</h1>
                  </div>
                  <p className="text-xl font-bold text-slate-800">#{finalQuote.id}</p>
                  <p className="text-sm text-slate-400">Date: {finalQuote.date}</p>
                </div>
                <div className="text-right">
                  <h2 className="text-lg font-bold text-slate-800 uppercase tracking-wide">Magnific Designer Studio</h2>
                  <p className="text-xs text-slate-500 max-w-[250px] ml-auto leading-relaxed mt-1">
                    {OFFICE_ADDRESS}
                  </p>
                  <p className="text-indigo-600 text-xs font-bold mt-2">experience@magnific.in</p>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-10 mb-10">
                <div className="bg-slate-50 p-6 rounded-xl border">
                  <h3 className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">Customer Information:</h3>
                  <p className="text-xl font-bold text-slate-900">{finalQuote.customer.name}</p>
                  {finalQuote.customer.company && <p className="text-indigo-600 font-bold text-sm mb-2">{finalQuote.customer.company}</p>}
                  <div className="text-sm text-slate-500 space-y-1 pt-3 border-t mt-3">
                    <p>{finalQuote.customer.phone}</p>
                    <p className="truncate">{finalQuote.customer.email}</p>
                  </div>
                </div>
                <div>
                  <h3 className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">Project Site Location:</h3>
                  <p className="text-sm text-slate-700 leading-relaxed font-medium italic">
                    "{finalQuote.customer.address}"
                  </p>
                </div>
              </div>

              <table className="w-full mb-8 border-collapse">
                <thead>
                  <tr className="bg-slate-50 border-y">
                    <th className="text-left py-4 px-3 text-[10px] font-bold text-slate-500 uppercase">Description</th>
                    <th className="text-left py-4 px-3 text-[10px] font-bold text-slate-500 uppercase">Location / Room</th>
                    <th className="text-center py-4 px-3 text-[10px] font-bold text-slate-500 uppercase">Qty</th>
                    <th className="text-right py-4 px-3 text-[10px] font-bold text-slate-500 uppercase">Unit Price</th>
                    <th className="text-right py-4 px-3 text-[10px] font-bold text-slate-500 uppercase">Total</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {finalQuote.items.map((i, idx) => (
                    <tr key={idx}>
                      <td className="py-5 px-3">
                        <p className="font-bold text-slate-800">{i.product.name}</p>
                        <p className="text-[10px] text-slate-400 font-medium uppercase">{i.product.category}</p>
                      </td>
                      <td className="py-5 px-3">
                        <span className="text-sm text-slate-600 font-medium italic">{i.placeName || "-"}</span>
                      </td>
                      <td className="py-5 px-3 text-center text-sm">{i.quantity}</td>
                      <td className="py-5 px-3 text-right text-slate-600 text-sm">₹{i.product.price.toLocaleString('en-IN')}</td>
                      <td className="py-5 px-3 text-right font-bold text-slate-900 text-sm">₹{(i.product.price * i.quantity).toLocaleString('en-IN')}</td>
                    </tr>
                  ))}
                </tbody>
              </table>

              <div className="flex justify-end mb-10">
                <div className="w-full max-w-xs space-y-3">
                  <div className="flex justify-between items-center text-slate-500">
                    <span className="text-sm font-medium">Subtotal</span>
                    <span className="font-bold">₹{subtotal.toLocaleString('en-IN')}</span>
                  </div>
                  <div className="flex justify-between items-center text-indigo-800 border-t pt-3">
                    <span className="text-lg font-bold">Total Amount</span>
                    <span className="text-2xl font-bold">₹{subtotal.toLocaleString('en-IN')}</span>
                  </div>
                  <p className="text-[9px] text-slate-400 text-right italic leading-tight">
                    * This is a tentative quote. Final GST (12% or 18% as applicable) and actual transport will be added manually at the time of final invoice.
                  </p>
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-start pt-6 border-t">
                <div className="md:col-span-2">
                  <h4 className="text-slate-800 font-bold mb-3 flex items-center text-xs uppercase tracking-wider">
                    <svg className="w-4 h-4 mr-2 text-indigo-500" fill="currentColor" viewBox="0 0 20 20"><path d="M11 3a1 1 0 10-2 0v1a1 1 0 102 0V3zM15.657 5.757a1 1 0 00-1.414-1.414l-.707.707a1 1 0 001.414 1.414l.707-.707zM18 10a1 1 0 01-1 1h-1a1 1 0 110-2h1a1 1 0 011 1zM5.05 6.464A1 1 0 106.464 5.05l-.707-.707a1 1 0 00-1.414 1.414l.707.707zM5 10a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zM8 16v-1a1 1 0 112 0v1a1 1 0 11-2 0zM13.536 14.95a1 1 0 011.414 0l.707.707a1 1 0 01-1.414 1.414l-.707-.707a1 1 0 010-1.414zM14.95 6.464a1 1 0 010-1.414l.707-.707a1 1 0 011.414 1.414l-.707.707a1 1 0 01-1.414 0zM6.464 14.95a1 1 0 010 1.414l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 0z"></path></svg>
                    Designer's Summary
                  </h4>
                  <p className="text-slate-600 text-sm italic leading-relaxed">"{finalQuote.aiSummary}"</p>
                </div>
                {qrCodeUrl && (
                  <div className="flex flex-col items-center justify-center p-4 border rounded-xl bg-slate-50 text-center">
                    <img src={qrCodeUrl} alt="Magnific QR" className="w-24 h-24 mb-2" />
                    <p className="text-[9px] uppercase font-bold text-slate-400">Scan Quote Online</p>
                  </div>
                )}
              </div>
              
              <div className="mt-12 text-center text-slate-400 text-[10px] border-t pt-8 space-y-1">
                <p>Validity: 30 Days | Terms: 100% Advance Payment | No Returns or Refunds on confirmed orders</p>
                <p className="font-bold text-indigo-700 uppercase tracking-[0.3em] mt-2">Experience Luxury • Magnific Studio • Koramangala</p>
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}

// Components
function ProductCard({ product, onAdd }: { product: Product, onAdd: (place: string) => void }) {
  const [activeImg, setActiveImg] = useState(product.image);
  const [place, setPlace] = useState('');
  const gallery = [product.image, ...(product.gallery || [])];

  const handleAdd = () => {
    onAdd(place);
    setPlace('');
  };

  return (
    <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden flex flex-col h-full group transition-all hover:shadow-md">
      <div className="relative h-52 overflow-hidden bg-slate-100">
        <img src={activeImg} alt={product.name} className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" />
        <div className="absolute top-3 right-3 bg-indigo-600 text-white text-[10px] font-bold px-2 py-1 rounded shadow-sm">{product.category}</div>
      </div>
      <div className="p-2 bg-slate-50 border-b flex space-x-2 overflow-x-auto no-scrollbar">
        {gallery.map((img, idx) => (
          <button key={idx} onMouseEnter={() => setActiveImg(img)} onClick={() => setActiveImg(img)} className={`w-10 h-10 rounded border-2 flex-shrink-0 transition-all ${activeImg === img ? 'border-indigo-600 ring-2 ring-indigo-100' : 'border-transparent opacity-60'}`}>
            <img src={img} className="w-full h-full object-cover rounded-[1px]" />
          </button>
        ))}
      </div>
      <div className="p-5 flex-1 flex flex-col">
        <h3 className="font-bold text-slate-900 mb-1">{product.name}</h3>
        <p className="text-slate-500 text-xs mb-4 line-clamp-2 h-8 leading-relaxed font-medium">{product.description}</p>
        
        <div className="mt-auto space-y-3">
          <input 
            type="text" 
            placeholder="Room/Place (e.g. Living Room)" 
            className="w-full text-[11px] p-2 border rounded-lg focus:ring-1 focus:ring-indigo-500 outline-none bg-slate-50 font-medium"
            value={place}
            onChange={e => setPlace(e.target.value)}
          />
          <div className="flex justify-between items-center">
            <span className="text-xl font-bold text-indigo-700">₹{product.price.toLocaleString('en-IN')}</span>
            <button onClick={handleAdd} className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center transition-all active:scale-95 shadow-sm">
              <CartIcon /> <span className="ml-2">Add</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

function CartItem({ item, onRemove, onQtyChange }: { item: QuoteItem, onRemove: () => void, onQtyChange: (q: number) => void }) {
  return (
    <div className="flex flex-col p-3 bg-slate-50 rounded-lg group border border-slate-100 space-y-2">
      <div className="flex items-center space-x-3">
        <img src={item.product.image} className="w-12 h-12 rounded-lg object-cover bg-white" />
        <div className="flex-1 min-w-0">
          <p className="text-xs font-bold text-slate-800 truncate leading-tight">{item.product.name}</p>
          <p className="text-[10px] text-indigo-600 font-bold">₹{item.product.price.toLocaleString('en-IN')}</p>
        </div>
        <button onClick={onRemove} className="text-slate-300 hover:text-red-500 p-1 opacity-0 group-hover:opacity-100 transition-opacity">
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
