
import React, { useState, useEffect } from 'react';
import { Routes, Route, useNavigate, useLocation } from 'react-router-dom';
import { Customer, Product, QuoteItem, Quotation } from './types';
import { STORAGE_KEY } from './constants';
import * as XLSX from 'xlsx';
import { totalPrice } from './utils';
import { HistoryIcon } from './components/Icons';
import { supabase } from './services/supabase';

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
  const [savedQuotes, setSavedQuotes] = useState<Quotation[]>([]);
  const [isSaved, setIsSaved] = useState(false);
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoadingProducts, setIsLoadingProducts] = useState(true);

  const [isCustomerView, setIsCustomerView] = useState(false);
  const [isPublicMode, setIsPublicMode] = useState(false);
  const [discountType, setDiscountType] = useState<'flat' | 'percentage' | null>(null);
  const [discountValue, setDiscountValue] = useState<number>(0);

  // Edit Mode State
  const [isEditMode, setIsEditMode] = useState(false);
  const [editingQuoteId, setEditingQuoteId] = useState<string | null>(null);

  useEffect(() => {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      try { setSavedQuotes(JSON.parse(raw)); } catch (e) { console.error(e); }
    }

    const params = new URLSearchParams(window.location.search);
    const dataParam = params.get('data');
    const viewMode = params.get('view');

    if (viewMode === 'customer') {
      setIsPublicMode(true);
      setIsCustomerView(true);
    }

    // Fetch Products from Supabase
    const fetchProducts = async () => {
      const { data, error } = await supabase
        .from('products')
        .select('*');

      if (error) {
        console.error('Error fetching products from Supabase:', error);
        setIsLoadingProducts(false);
        return;
      }

      console.log('Supabase Data Received:', data);

      if (data) {
        // Map snake_case from DB to camelCase in Product interface
        const getImageUrl = (img: string) => {
          if (!img) return '';
          if (img.startsWith('http')) return img;
          return `/Assets/products/${img}`;
        };

        const mappedProducts: Product[] = data.map((p: any) => ({
          id: p.product_id,
          name: p.name,
          modelNumber: p.model_number,
          description: p.description || '',
          price: parseFloat(p.showroom_price || '0'),
          category: p.category,
          image: p.images && p.images.length > 0 ? getImageUrl(p.images[0]) : '',
          gallery: p.images && p.images.length > 1 ? p.images.slice(1).map(getImageUrl) : [],
          suitableFor: p.technical_details?.suitable_for,
          motorSpec: p.technical_details?.motor_spec,
          noOfBlades: p.technical_details?.no_of_blades,
          bodyColor: p.body_finish,
          bladeFinish: p.technical_details?.blade_finish,
          lightOption: p.technical_details?.light_option,
          sweep: p.technical_details?.sweep,
          airflow: p.technical_details?.airflow,
          heightOfFan: p.technical_details?.height_of_fan,
          remoteControl: p.technical_details?.remote_control,
          summerWinterOption: p.technical_details?.summer_winter_option,
          bladeMechanism: p.technical_details?.blade_mechanism,
          reversibleBlade: p.technical_details?.reversible_blade,
          oscillationRotation: p.technical_details?.oscillation_rotation,
          bladeType: p.technical_details?.blade_type,
          suitablePlace: p.technical_details?.suitable_place,
          size: p.technical_details?.size || p.size,
          lamp: p.technical_details?.lamp,
          finishing: p.technical_details?.finishing || p.body_finish
        }));

        console.log('Mapped Products:', mappedProducts);

        if (mappedProducts.length > 0) {
          setProducts(mappedProducts);
        }

        // If we have data in URL, wait for products to load before restoring
        if (dataParam) {
          try {
            const decoded = JSON.parse(decodeURIComponent(escape(atob(dataParam))));
            const restoredItems = decoded.items.map((item: any) => ({
              ...item,
              product: mappedProducts.find(prod => prod.id === item.productId)
            })).filter((item: any) => item.product);

            setFinalQuote({ ...decoded, items: restoredItems });
            navigate('/preview');
          } catch (e) {
            console.error("Failed to decode QR data", e);
          }
        }
      }
      setIsLoadingProducts(false);
    };

    fetchProducts();
  }, [navigate]);

  const addToCart = (product: Product, options: { 
    placeName?: string, 
    size?: string, 
    color?: string, 
    lamp?: string, 
    discount?: number, 
    customDescription?: string, 
    extraNote?: string,
    customPrice?: number,
    customName?: string,
    customModelNumber?: string,
    isCustom?: boolean,
    quantity?: number
  }) => {
    const trimmedPlace = options.placeName?.trim() || '';
    const trimmedSize = options.size?.trim() || '';
    const trimmedColor = options.color?.trim() || '';
    const trimmedLamp = options.lamp?.trim() || '';
    const trimmedDesc = options.customDescription?.trim() || '';
    const trimmedNote = options.extraNote?.trim() || '';
    const discountVal = options.discount || 0;
    const cPrice = options.customPrice;
    const cName = options.customName?.trim() || '';
    const cModel = options.customModelNumber?.trim() || '';
    const isC = options.isCustom || false;

    setCart(prev => {
      const existing = prev.find(item =>
        item.product.id === product.id &&
        (item.placeName || '') === trimmedPlace &&
        (item.size || '') === trimmedSize &&
        (item.color || '') === trimmedColor &&
        (item.lamp || '') === trimmedLamp &&
        (item.customDescription || '') === trimmedDesc &&
        (item.extraNote || '') === trimmedNote &&
        (item.discount || 0) === discountVal &&
        (item.customPrice) === cPrice &&
        (item.customName || '') === cName &&
        (item.customModelNumber || '') === cModel
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
            (item.discount || 0) === discountVal &&
            (item.customPrice) === cPrice &&
            (item.customName || '') === cName &&
            (item.customModelNumber || '') === cModel)
            ? { ...item, quantity: item.quantity + (options.quantity || 1) }
            : item
        );
      }
      return [...prev, { 
        product, 
        quantity: options.quantity || 1, 
        placeName: trimmedPlace, 
        size: trimmedSize, 
        color: trimmedColor, 
        lamp: trimmedLamp, 
        customDescription: trimmedDesc, 
        extraNote: trimmedNote, 
        discount: discountVal,
        customPrice: cPrice,
        customName: cName,
        customModelNumber: cModel,
        isCustom: isC
      }];
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
      id: isEditMode && editingQuoteId ? editingQuoteId : `MQ-${Date.now().toString().slice(-6)}`,
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

    navigate('/preview');
    setIsGenerating(false);
  };

  const handleEditQuotation = () => {
    if (!finalQuote) return;

    // Load quotation data into state
    setCustomer(finalQuote.customer);
    setCart(finalQuote.items);
    setDiscountType(finalQuote.globalDiscountType || null);
    setDiscountValue(finalQuote.globalDiscountValue || 0);

    // Set edit mode
    setIsEditMode(true);
    setEditingQuoteId(finalQuote.id);

    // Navigate to catalog
    navigate('/catalog');
  };

  // Inline editing handlers
  const handleUpdateCustomer = (updates: Partial<Customer>) => {
    if (!finalQuote) return;
    setFinalQuote({
      ...finalQuote,
      customer: { ...finalQuote.customer, ...updates }
    });
    setIsSaved(false); // Mark as unsaved when edited
  };

  const handleUpdateItemQuantity = (index: number, quantity: number) => {
    if (!finalQuote) return;
    const updatedItems = [...finalQuote.items];
    updatedItems[index] = { ...updatedItems[index], quantity };
    setFinalQuote({
      ...finalQuote,
      items: updatedItems
    });
    setIsSaved(false);
  };

  const handleUpdateItemPlace = (index: number, placeName: string) => {
    if (!finalQuote) return;
    const updatedItems = [...finalQuote.items];
    updatedItems[index] = { ...updatedItems[index], placeName };
    setFinalQuote({
      ...finalQuote,
      items: updatedItems
    });
    setIsSaved(false);
  };

  const saveToLocal = () => {
    if (!finalQuote) return;

    let newList: Quotation[];
    if (isEditMode && editingQuoteId) {
      // Update existing quotation
      newList = savedQuotes.map(q => q.id === editingQuoteId ? finalQuote : q);
    } else {
      // Add new quotation
      newList = [finalQuote, ...savedQuotes];
    }

    setSavedQuotes(newList);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(newList));
    setIsSaved(true);

    // Reset edit mode
    setIsEditMode(false);
    setEditingQuoteId(null);
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
      // Calculate item-specific discount if any
      const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
      const itemDiscountAmount = item.discount ? (basePrice * item.discount / 100) : 0;
      const itemPriceAfterDiscount = basePrice - itemDiscountAmount;

      worksheetData.push([
        (idx + 1).toString(),
        item.product.modelNumber,
        item.product.category,
        (item.customDescription || item.product.description) + (item.extraNote ? `\nNote: ${item.extraNote}` : ''),
        item.placeName || '-',
        item.quantity.toString(),
        itemPriceAfterDiscount.toFixed(2), // Use item price after its own discount
        (itemPriceAfterDiscount * item.quantity).toFixed(2)
      ]);
    });

    const grossTotal = totalPrice(finalQuote.items); // This is the sum of (basePrice * item.quantity)
    const totalItemDiscount = finalQuote.items.reduce((sum, item) => {
        const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
        return sum + (basePrice * (item.discount || 0) / 100 * item.quantity);
    }, 0);
    const subtotalAfterItemDiscounts = grossTotal - totalItemDiscount;

    const globalDiscountAmount = finalQuote.globalDiscountType === 'percentage'
      ? (subtotalAfterItemDiscounts * (finalQuote.globalDiscountValue || 0) / 100)
      : (finalQuote.globalDiscountValue || 0);

    const netAmountBeforeTax = subtotalAfterItemDiscounts - globalDiscountAmount;
    const gstAmount = netAmountBeforeTax * finalQuote.taxRate;
    const grandTotal = netAmountBeforeTax + gstAmount;

    worksheetData.push(['']);
    worksheetData.push(['', '', '', '', '', '', 'Gross Total', grossTotal.toLocaleString('en-IN')]);
    if (finalQuote.globalDiscountValue) {
      const label = finalQuote.globalDiscountType === 'percentage' ? `Discount (${finalQuote.globalDiscountValue}%)` : 'Discount (Flat)';
      worksheetData.push(['', '', '', '', '', '', label, `-${globalDiscountAmount.toLocaleString('en-IN')}`]);
    }
    worksheetData.push(['', '', '', '', '', '', 'Net Total', netAmountBeforeTax.toLocaleString('en-IN')]);
    if (finalQuote.globalDiscountType === 'percentage' || !finalQuote.globalDiscountValue) {
      worksheetData.push(['', '', '', '', '', '', 'GST (18%)', gstAmount.toLocaleString('en-IN')]);
    }
    if (finalQuote.advanceAmount) {
      worksheetData.push(['', '', '', '', '', '', 'Advance Paid', finalQuote.advanceAmount.toLocaleString('en-IN')]);
      worksheetData.push(['', '', '', '', '', '', 'Balance Due', (grandTotal - finalQuote.advanceAmount).toLocaleString('en-IN')]);
    } else {
      worksheetData.push(['', '', '', '', '', '', 'Grand Total', grandTotal.toLocaleString('en-IN')]);
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
            <div className="flex items-center cursor-pointer" onClick={() => { setIsCustomerView(false); navigate('/'); }}>
              <div className="logo">
                <img src="./assets/magnific-web.png" alt="magnific" className="h-12 w-auto object-contain" />
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
              products={products}
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
              isEditMode={isEditMode}
              editingQuoteId={editingQuoteId}
              isLoading={isLoadingProducts}
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
                onEdit={handleEditQuotation}
                onUpdateCustomer={handleUpdateCustomer}
                onUpdateItemQuantity={handleUpdateItemQuantity}
                onUpdateItemPlace={handleUpdateItemPlace}
                onNewQuote={() => {
                  setCart([]);
                  setCustomer({ name: '', email: '', phone: '', address: '', company: '' });
                  setFinalQuote(null);
                  setDiscountType(null);
                  setDiscountValue(0);
                  setIsEditMode(false);
                  setEditingQuoteId(null);
                  navigate('/');
                }}
                isPublicMode={isPublicMode}
                isCustomerView={isCustomerView}
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
              onEdit={(q) => {
                setCustomer(q.customer);
                setCart(q.items);
                setDiscountType(q.globalDiscountType || null);
                setDiscountValue(q.globalDiscountValue || 0);
                setIsEditMode(true);
                setEditingQuoteId(q.id);
                navigate('/catalog');
              }}
              onDelete={deleteSaved}
            />
          } />
        </Routes>

      </main>
    </div>
  );
}
