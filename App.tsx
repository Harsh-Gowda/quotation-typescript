
import React, { useState, useEffect } from 'react';
import { Routes, Route, useNavigate, useLocation } from 'react-router-dom';
import { Customer, Product, QuoteItem, Quotation } from './types';
import { MOCK_PRODUCTS, STORAGE_KEY } from './constants';
import QRCode from 'qrcode';
import * as XLSX from 'xlsx';
import { totalPrice } from './utils';
import { HistoryIcon } from './components/Icons';

// Components
import CustomerEntry from './components/CustomerEntry';
import ProductSelection from './components/ProductSelection';
import QuotationPreview from './components/QuotationPreview';
import SavedQuotes from './components/SavedQuotes';

export default function App() {
  const navigate = useNavigate();
  const location = useLocation();

  // Global State
  const [customer, setCustomer] = useState<Customer & { advanceAmount?: number, advanceDate?: string }>({ name: '', email: '', phone: '', address: '', company: '', advanceAmount: 0, advanceDate: '' });
  const [cart, setCart] = useState<QuoteItem[]>([]);
  const [isGenerating, setIsGenerating] = useState(false);
  const [finalQuote, setFinalQuote] = useState<Quotation | null>(null);
  const [qrCodeUrl, setQrCodeUrl] = useState<string | null>(null);
  const [shareUrl, setShareUrl] = useState<string | null>(null);
  const [savedQuotes, setSavedQuotes] = useState<Quotation[]>([]);
  const [isSaved, setIsSaved] = useState(false);

  const [isCustomerView, setIsCustomerView] = useState(false);
  const [isPublicMode, setIsPublicMode] = useState(false);
  const [discountType, setDiscountType] = useState<'flat' | 'percentage' | null>(null);
  const [discountValue, setDiscountValue] = useState<number>(0);

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
      setIsCustomerView(true);
    }

    if (data) {
      try {
        const decoded = JSON.parse(decodeURIComponent(escape(atob(data))));
        const restoredItems = decoded.items.map((item: any) => ({
          ...item,
          product: MOCK_PRODUCTS.find(p => p.id === item.productId)
        })).filter((item: any) => item.product);

        setFinalQuote({ ...decoded, items: restoredItems });
        navigate('/preview');
      } catch (e) { console.error("Failed to decode QR data", e); }
    }
  }, [navigate]);

  const addToCart = (product: Product, options: { placeName?: string, size?: string, color?: string, lamp?: string, discount?: number, customDescription?: string, extraNote?: string }) => {
    const trimmedPlace = options.placeName?.trim() || '';
    const trimmedSize = options.size?.trim() || '';
    const trimmedColor = options.color?.trim() || '';
    const trimmedLamp = options.lamp?.trim() || '';
    const trimmedDesc = options.customDescription?.trim() || '';
    const trimmedNote = options.extraNote?.trim() || '';
    const discountVal = options.discount || 0;

    setCart(prev => {
      const existing = prev.find(item =>
        item.product.id === product.id &&
        (item.placeName || '') === trimmedPlace &&
        (item.size || '') === trimmedSize &&
        (item.color || '') === trimmedColor &&
        (item.lamp || '') === trimmedLamp &&
        (item.customDescription || '') === trimmedDesc &&
        (item.extraNote || '') === trimmedNote &&
        (item.discount || 0) === discountVal
      );
      if (existing) {
        return prev.map(item =>
          (item.product.id === product.id &&
            (item.placeName || '') === trimmedPlace &&
            (item.size || '') === trimmedSize &&
            (item.color || '') === trimmedColor &&
            (item.lamp || '') === trimmedLamp &&
            (item.customDescription || '') === trimmedDesc &&
            (item.extraNote || '') === trimmedNote &&
            (item.discount || 0) === discountVal)
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      }
      return [...prev, { product, quantity: 1, placeName: trimmedPlace, size: trimmedSize, color: trimmedColor, lamp: trimmedLamp, customDescription: trimmedDesc, extraNote: trimmedNote, discount: discountVal }];
    });
  };

  const removeFromCart = (productId: string, options: { placeName?: string, size?: string, color?: string, lamp?: string, discount?: number, customDescription?: string, extraNote?: string }) => {
    const trimmedPlace = options.placeName || '';
    const trimmedSize = options.size || '';
    const trimmedColor = options.color || '';
    const trimmedLamp = options.lamp || '';
    const trimmedDesc = options.customDescription || '';
    const trimmedNote = options.extraNote || '';
    const discountVal = options.discount || 0;

    setCart(prev => prev.filter(item => !(
      item.product.id === productId &&
      (item.placeName || '') === trimmedPlace &&
      (item.size || '') === trimmedSize &&
      (item.color || '') === trimmedColor &&
      (item.lamp || '') === trimmedLamp &&
      (item.customDescription || '') === trimmedDesc &&
      (item.extraNote || '') === trimmedNote &&
      (item.discount || 0) === discountVal
    )));
  };

  const updateQuantity = (productId: string, options: any, qty: number) => {
    if (qty < 1) return;
    const trimmedPlace = options.placeName || '';
    const trimmedSize = options.size || '';
    const trimmedColor = options.color || '';
    const trimmedLamp = options.lamp || '';
    const trimmedDesc = options.customDescription || '';
    const trimmedNote = options.extraNote || '';
    const discountVal = options.discount || 0;

    setCart(prev => {
      const idx = prev.findIndex(item =>
        item.product.id === productId &&
        (item.placeName || '') === trimmedPlace &&
        (item.size || '') === trimmedSize &&
        (item.color || '') === trimmedColor &&
        (item.lamp || '') === trimmedLamp &&
        (item.customDescription || '') === trimmedDesc &&
        (item.extraNote || '') === trimmedNote &&
        (item.discount || 0) === discountVal
      );
      if (idx > -1) {
        const newCart = [...prev];
        newCart[idx] = { ...newCart[idx], quantity: qty };
        return newCart;
      }
      return prev;
    });
  };

  const updateCartItem = (index: number, options: any) => {
    setCart(prev => {
      const newCart = [...prev];
      const oldItem = newCart[index];
      const newItem = {
        ...oldItem,
        placeName: options.placeName,
        size: options.size,
        color: options.color,
        lamp: options.lamp,
        customDescription: options.customDescription,
        extraNote: options.extraNote,
        discount: options.discount
      };
      newCart[index] = newItem;
      return newCart;
    });
  };

  const handleCreateQuotation = async () => {
    setIsGenerating(true);
    // const aiSummary = await generateQuoteSummary(cart);
    const aiSummary = "Generated Quote";

    const quote: Quotation = {
      id: `MQ-${Date.now().toString().slice(-6)}`,
      customer,
      items: cart,
      date: new Date().toLocaleDateString('en-IN', { day: 'numeric', month: 'long', year: 'numeric' }),
      taxRate: 0.18,
      aiSummary,
      advanceAmount: customer.advanceAmount,
      advanceDate: customer.advanceDate,
      globalDiscountType: discountType || undefined,
      globalDiscountValue: discountValue || undefined
    };

    setFinalQuote(quote);
    setIsSaved(false);

    // Generate Shareable Link
    const minifiedItems = quote.items.map(i => ({
      productId: i.product.id,
      quantity: i.quantity,
      placeName: i.placeName,
      size: i.size,
      color: i.color,
      lamp: i.lamp,
      discount: i.discount,
      customDescription: i.customDescription,
      extraNote: i.extraNote
    }));

    const payload = btoa(unescape(encodeURIComponent(JSON.stringify({ ...quote, items: minifiedItems }))));
    const baseUrl = window.location.origin + window.location.pathname;
    const link = `${baseUrl}?data=${payload}&view=customer`; // Default to customer view
    setShareUrl(link);

    // Generate QR
    QRCode.toDataURL(link, { margin: 2, scale: 10 })
      .then(url => setQrCodeUrl(url))
      .catch(err => console.error(err));

    navigate('/preview');
    setIsGenerating(false);
  };

  const saveToLocal = () => {
    if (!finalQuote) return;
    const newList = [finalQuote, ...savedQuotes];
    setSavedQuotes(newList);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(newList));
    setIsSaved(true);
  };

  const deleteSaved = (e: React.MouseEvent, id: string) => {
    e.stopPropagation();
    const newList = savedQuotes.filter(q => q.id !== id);
    setSavedQuotes(newList);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(newList));
  };

  const handleExportExcel = () => {
    if (!finalQuote) return;

    const workbook = XLSX.utils.book_new();
    const worksheetData = [
      ['MAGNIFIC DESIGNER FANS & LIGHTING'],
      ['Quotation Details'],
      ['Ref No:', finalQuote.id],
      ['Date:', finalQuote.date],
      [''],
      ['Customer Details'],
      ['Name:', finalQuote.customer.name],
      ['Phone:', finalQuote.customer.phone],
      ['Email:', finalQuote.customer.email],
      ['Address:', finalQuote.customer.address],
      [''],
      ['Item Details'],
      ['S.No', 'Model', 'Category', 'Description', 'Room/Place', 'Qty', 'Unit Price', 'Total']
    ];

    finalQuote.items.forEach((item, idx) => {
      const discount = item.product.price * (finalQuote.globalDiscountValue || 0) / 100;
      const price = finalQuote.globalDiscountValue ? (item.product.price - discount) : item.product.price;

      worksheetData.push([
        (idx + 1).toString(),
        item.product.modelNumber,
        item.product.category,
        (item.customDescription || item.product.description) + (item.extraNote ? `\nNote: ${item.extraNote}` : ''),
        item.placeName || '-',
        item.quantity.toString(),
        price.toString(),
        (price * item.quantity).toString()
      ]);
    });

    const netAmount = totalPrice(finalQuote.items) - Math.round(totalPrice(finalQuote.items) * (finalQuote.globalDiscountValue || 0) / 100);
    const gstAmount = Math.round(netAmount * 0.18);
    const grandTotal = finalQuote.globalDiscountType === 'flat' ? netAmount : Math.round(netAmount * 1.18);

    worksheetData.push(['']);
    worksheetData.push(['', '', '', '', '', '', 'Gross Total', totalPrice(finalQuote.items).toString()]);
    if (finalQuote.globalDiscountValue) {
      worksheetData.push(['', '', '', '', '', '', `Discount (${finalQuote.globalDiscountValue}%)`, `-${Math.round(totalPrice(finalQuote.items) * (finalQuote.globalDiscountValue || 0) / 100)}`]);
    }
    worksheetData.push(['', '', '', '', '', '', 'Net Total', netAmount.toString()]);
    if (finalQuote.globalDiscountType === 'percentage' || !finalQuote.globalDiscountValue) {
      worksheetData.push(['', '', '', '', '', '', 'GST (18%)', gstAmount.toString()]);
    }
    if (finalQuote.advanceAmount) {
      worksheetData.push(['', '', '', '', '', '', 'Advance Paid', finalQuote.advanceAmount.toString()]);
      worksheetData.push(['', '', '', '', '', '', 'Balance Due', (grandTotal - finalQuote.advanceAmount).toString()]);
    } else {
      worksheetData.push(['', '', '', '', '', '', 'Grand Total', grandTotal.toString()]);
    }

    const worksheet = XLSX.utils.aoa_to_sheet(worksheetData);

    // Styling checks
    const range = XLSX.utils.decode_range(worksheet['!ref'] || 'A1:H1');
    for (let C = range.s.c; C <= range.e.c; ++C) {
      const address = XLSX.utils.encode_col(C) + '1';
      if (!worksheet[address]) continue;
      worksheet[address].s = { font: { bold: true, sz: 14 } };
    }

    XLSX.utils.book_append_sheet(workbook, worksheet, 'Quotation');
    XLSX.writeFile(workbook, `Quotation_${finalQuote.customer.name.replace(/\s+/g, '_')}_${finalQuote.id}.xlsx`);
  };

  const subtotal = totalPrice(cart);

  return (
    <div className="min-h-screen bg-slate-50 font-sans text-slate-900 selection:bg-indigo-100 selection:text-indigo-900">
      <style>{`
        @media print {
          @page { 
            size: A4 portrait; 
            margin: 10mm;
          }
          body { 
            print-color-adjust: exact; 
            -webkit-print-color-adjust: exact; 
            background: white;
            font-size: 10pt;
          }
          .no-print-break { page-break-inside: avoid; }
          .print-compact { margin-top: 5px !important; padding-top: 5px !important; }
        }
        /* Hide scrollbar for gallery */
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
      `}</style>

      {/* Header */}
      {!isCustomerView && (
        <header className="bg-white border-b border-slate-200 sticky top-0 z-40 print:hidden shadow-sm">
          <div className="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div className="flex items-center space-x-3 cursor-pointer" onClick={() => { setIsCustomerView(false); navigate('/'); }}>
              <div className="logo">
                <img src="./assets/magnific-web.png" alt="magnific" width="100px" height="100px" />
              </div>
              <div>
                <h1 className="text-lg font-bold text-slate-800 tracking-tight leading-none">MAGNIFIC</h1>
                <p className="text-[9px] text-slate-500 uppercase tracking-widest font-semibold">Designer Fans & Lights</p>
              </div>
            </div>
            <div className="flex items-center space-x-4">
              <button onClick={() => navigate('/saved')} className="text-slate-500 hover:text-indigo-600 font-bold text-sm transition-colors flex items-center">
                <HistoryIcon /> <span className="ml-1">Archive</span>
              </button>
              {location.pathname === '/preview' && (
                <div className="text-xs font-bold bg-indigo-50 text-indigo-700 px-3 py-1 rounded-full border border-indigo-100">
                  {isSaved ? 'Saved Locally' : 'Unsaved Draft'}
                </div>
              )}
            </div>
          </div>
        </header>
      )}

      {/* Main Content */}
      <main className={`max-w-7xl mx-auto p-4 sm:p-6 lg:p-8 print:p-0 print:max-w-none ${isCustomerView ? 'pt-0' : ''}`}>

        <Routes>
          <Route path="/" element={
            <CustomerEntry
              customer={customer}
              setCustomer={setCustomer}
            />
          } />

          <Route path="/catalog" element={
            <ProductSelection
              cart={cart}
              subtotal={subtotal}
              addToCart={addToCart}
              removeFromCart={removeFromCart}
              updateQuantity={updateQuantity}
              updateCartItem={updateCartItem}
              discountType={discountType}
              setDiscountType={setDiscountType}
              discountValue={discountValue}
              setDiscountValue={setDiscountValue}
              onGenerateQuote={handleCreateQuotation}
              isGenerating={isGenerating}
            />
          } />

          <Route path="/preview" element={
            finalQuote ? (
              <QuotationPreview
                finalQuote={finalQuote}
                subtotal={totalPrice(finalQuote.items)}
                isSaved={isSaved}
                onSave={saveToLocal}
                onExportExcel={handleExportExcel}
                onNewQuote={() => {
                  setCart([]);
                  setCustomer({ name: '', email: '', phone: '', address: '', company: '' });
                  setFinalQuote(null);
                  setQrCodeUrl(null);
                  setDiscountType(null);
                  setDiscountValue(0);
                  navigate('/');
                }}
                isPublicMode={isPublicMode}
                isCustomerView={isCustomerView}
                qrCodeUrl={qrCodeUrl}
                shareUrl={shareUrl}
              />
            ) : (
              // Redirect if no quote
              // Effect handles this usually, but a placeholder is good
              <div className="text-center p-10">No quote generated. <a href="/" className="text-indigo-600 underline">Start New</a></div>
            )
          } />

          <Route path="/saved" element={
            <SavedQuotes
              savedQuotes={savedQuotes}
              onLoad={(q) => {
                setFinalQuote(q);
                setCustomer(q.customer);
                setCart(q.items);
                setDiscountType(q.globalDiscountType || null);
                setDiscountValue(q.globalDiscountValue || 0);
                setIsSaved(true);
                navigate('/preview');
              }}
              onDelete={deleteSaved}
            />
          } />
        </Routes>

      </main>
    </div>
  );
}
