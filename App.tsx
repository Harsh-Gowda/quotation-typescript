
import React, { useState, useEffect } from 'react';
import { Routes, Route, useNavigate, useLocation } from 'react-router-dom';
import { Customer, Product, QuoteItem, Quotation } from './types';
import { STORAGE_KEY, DRAFT_STORAGE_KEY } from './constants';
import * as XLSX from 'xlsx';
import { totalPrice, computeGstBase, calculateTotalDiscount } from './utils';
import { HistoryIcon } from './components/Icons';
import { supabase } from './services/supabase';

// Components
import CustomerEntry from './components/CustomerEntry';
import ProductSelection from './components/ProductSelection';
import QuotationPreview from './components/QuotationPreview';
import SavedQuotes from './components/SavedQuotes';
import LoginPage from './components/LoginPage';

const AUTH_STORAGE_KEY = 'magnific_auth_user';

export default function App() {
  const navigate = useNavigate();
  const location = useLocation();

  // Auth State
  const [loggedInUser, setLoggedInUser] = useState<{ name: string; role: string } | null>(() => {
    const raw = localStorage.getItem(AUTH_STORAGE_KEY);
    if (raw) {
      try { return JSON.parse(raw); } catch { return null; }
    }
    return null;
  });

  const handleLogin = (user: { name: string; role: string }) => {
    setLoggedInUser(user);
    localStorage.setItem(AUTH_STORAGE_KEY, JSON.stringify(user));
  };

  const handleLogout = () => {
    setLoggedInUser(null);
    localStorage.removeItem(AUTH_STORAGE_KEY);
    navigate('/');
  };

  // Global State
  const [customer, setCustomer] = useState<Customer & { advanceAmount?: number, advanceDate?: string }>(() => {
    const raw = localStorage.getItem(`${DRAFT_STORAGE_KEY}_customer`);
    return raw ? JSON.parse(raw) : { name: '', email: '', phone: '', address: '', company: '', advanceAmount: 0, advanceDate: '' };
  });
  const [cart, setCart] = useState<QuoteItem[]>(() => {
    const raw = localStorage.getItem(`${DRAFT_STORAGE_KEY}_cart`);
    return raw ? JSON.parse(raw) : [];
  });
  const [isGenerating, setIsGenerating] = useState(false);
  const [finalQuote, setFinalQuote] = useState<Quotation | null>(null);
  const [savedQuotes, setSavedQuotes] = useState<Quotation[]>([]);
  const [isSaved, setIsSaved] = useState(false);
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoadingProducts, setIsLoadingProducts] = useState(true);

  const [isCustomerView, setIsCustomerView] = useState(false);
  const [isPublicMode, setIsPublicMode] = useState(false);
  const [discountType, setDiscountType] = useState<'include' | 'exclude' | null>(() => {
    const raw = localStorage.getItem(`${DRAFT_STORAGE_KEY}_discountType`);
    return (raw === 'include' || raw === 'exclude') ? raw : null;
  });
  const [discountValue, setDiscountValue] = useState<number>(() => {
    const raw = localStorage.getItem(`${DRAFT_STORAGE_KEY}_discountValue`);
    return raw ? Number(raw) : 0;
  });

  // Edit Mode State
  const [isEditMode, setIsEditMode] = useState(false);
  const [editingQuoteId, setEditingQuoteId] = useState<string | null>(null);

  useEffect(() => {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      try { setSavedQuotes(JSON.parse(raw)); } catch (e) { console.error(e); }
    }
  }, []);

  // Save draft to localStorage
  useEffect(() => {
    localStorage.setItem(`${DRAFT_STORAGE_KEY}_customer`, JSON.stringify(customer));
    localStorage.setItem(`${DRAFT_STORAGE_KEY}_cart`, JSON.stringify(cart));
    localStorage.setItem(`${DRAFT_STORAGE_KEY}_discountType`, discountType || '');
    localStorage.setItem(`${DRAFT_STORAGE_KEY}_discountValue`, String(discountValue));
  }, [customer, cart, discountType, discountValue]);

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const dataParam = params.get('data');
    const viewMode = params.get('view');

    if (viewMode === 'customer') {
      setIsPublicMode(true);
      setIsCustomerView(true);
    }

    // Fetch Products from Supabase (new schema: product_variants → product_templates → product_categories)
    const fetchProducts = async () => {
      let allData: any[] = [];
      let fetchMore = true;
      let from = 0;
      const limit = 1000;

      while (fetchMore) {
        const { data, error } = await supabase
          .from('product_variants')
          .select(`
            *,
            product_templates (
              name,
              description,
              product_categories (
                name
              )
            )
          `)
          .range(from, from + limit - 1);

        if (error) {
          console.error('❌ Supabase error:', error.message);
          console.error('Details:', error.details, '| Hint:', error.hint);
          setIsLoadingProducts(false);
          return;
        }

        if (data && data.length > 0) {
          allData = [...allData, ...data];
          from += limit;
          if (data.length < limit) {
            fetchMore = false;
          }
        } else {
          fetchMore = false;
        }
      }

      const data = allData;

      console.log(`✅ product_variants returned ${data.length} rows`);
      if (data.length > 0) {
        console.log('Sample row:', data[0]);
      } else {
        console.warn('⚠️ No rows returned. Run migrations/05_rls_policies.sql in Supabase SQL Editor to enable reads, and verify 04_variants.sql was executed.');
      }

      if (data && data.length > 0) {
        const mappedProducts: Product[] = data
          .filter((v: any) => v.isSellable !== false) // client-side filter — avoids column-casing issues
          .map((v: any) => {
            const template = v.product_templates || {};
            const category = template.product_categories || {};
            const media = v.attributes?.media || {};
            
            // Fan technical details are directly on attributes, older products might have them in technicalDetails
            const tech = v.attributes?.technicalDetails || v.attributes || {};

            const primaryImg: string = media.primaryImage || media.images?.[0] || '';
            const allImages: string[] = media.images || (primaryImg ? [primaryImg] : []);

            return {
              id:          v.variantId,
              name:        template.name || v.variantName,
              modelNumber: template.name || v.sku,
              description: template.description || '',
              price:       parseFloat(v.showroomPrice ?? v.catalogPrice ?? '0'),
              category:    category.name || '',
              image:       primaryImg,
              gallery:     allImages.slice(1),
              suitableFor:         tech.suitable_for,
              motorSpec:           tech.motor_spec,
              noOfBlades:          tech.no_of_blades,
              bodyColor:           v.finish || tech.body_color || tech.colour,
              bladeFinish:         tech.blade_finish,
              lightOption:         tech.light_option,
              sweep:               tech.sweep,
              airflow:             tech.airflow,
              heightOfFan:         tech.height_of_fan,
              remoteControl:       tech.remote_control,
              summerWinterOption:  tech.summer_winter_option,
              bladeMechanism:      tech.blade_mechanism,
              reversibleBlade:     tech.reversible_blade,
              oscillationRotation: tech.oscillation_rotation,
              bladeType:           tech.blade_type,
              suitablePlace:       tech.suitable_place,
              size:                v.size || tech.size,
              lamp:                tech.lamp,
              finishing:           v.finish || tech.finishing,
            };
          });

        console.log(`✅ Mapped ${mappedProducts.length} sellable products`);
        setProducts(mappedProducts);

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
            console.error('Failed to decode QR data', e);
          }
        }
      }
      setIsLoadingProducts(false);
    };

    fetchProducts();
  }, [navigate]);

  const resetDraft = () => {
    setCustomer({ name: '', email: '', phone: '', address: '', company: '', advanceAmount: 0, advanceDate: '' });
    setCart([]);
    setDiscountType(null);
    setDiscountValue(0);
    localStorage.removeItem(`${DRAFT_STORAGE_KEY}_customer`);
    localStorage.removeItem(`${DRAFT_STORAGE_KEY}_cart`);
    localStorage.removeItem(`${DRAFT_STORAGE_KEY}_discountType`);
    localStorage.removeItem(`${DRAFT_STORAGE_KEY}_discountValue`);
  };

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
        isCustom: isC,
        showLineart: false,
        includeGst: true,
        includeDiscount: true
      }];
    });
  };

  const handleUpdateItemSetting = (index: number, key: 'showLineart' | 'includeGst' | 'includeDiscount', value: boolean) => {
    if (!finalQuote) return;
    const updatedItems = [...finalQuote.items];
    updatedItems[index] = { ...updatedItems[index], [key]: value };
    setFinalQuote({
      ...finalQuote,
      items: updatedItems
    });
    setIsSaved(false);
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

  // Generate quotation ID in format: ALI-260509-1 (NAME-YYMMDD-DAILY_COUNT)
  const generateQuotationId = (): string => {
    const userName = loggedInUser?.name || 'USR';
    const prefix = userName.substring(0, 3).toUpperCase();

    const now = new Date();
    const yy = String(now.getFullYear()).slice(-2);
    const mm = String(now.getMonth() + 1).padStart(2, '0');
    const dd = String(now.getDate()).padStart(2, '0');
    const dateStr = `${yy}${mm}${dd}`;

    // Daily counter stored in localStorage, resets each day per user prefix
    const counterKey = `magnific_quote_counter_${prefix}_${dateStr}`;
    const stored = localStorage.getItem(counterKey);
    let counter = stored ? parseInt(stored, 10) + 1 : 1;
    localStorage.setItem(counterKey, String(counter));

    return `${prefix}-${dateStr}-${counter}`;
  };

  const handleCreateQuotation = async () => {
    setIsGenerating(true);
    const aiSummary = "Professional Quotation";

    const quote: Quotation = {
      id: isEditMode && editingQuoteId ? editingQuoteId : generateQuotationId(),
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
  const handleUpdateCustomer = (updates: Partial<Customer & { advanceAmount?: number; advanceDate?: string }>) => {
    if (!finalQuote) return;
    
    // Check if advanceAmount is in updates
    const newQuote = { ...finalQuote };
    if ('advanceAmount' in updates) {
      newQuote.advanceAmount = updates.advanceAmount;
    }
    if ('advanceDate' in updates) {
      newQuote.advanceDate = updates.advanceDate;
    }
    
    // Also update the customer object part
    newQuote.customer = { ...newQuote.customer, ...updates };
    
    setFinalQuote(newQuote);
    setIsSaved(false);
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

    // Reset edit mode and clear draft
    setIsEditMode(false);
    setEditingQuoteId(null);
    resetDraft();
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
      const basePrice = item.customPrice !== undefined ? item.customPrice : item.product.price;
      const effectivePrice = item.includeGst !== false ? basePrice : basePrice / 1.18;

      // Internal Unit Price shows the price with global discount if type is 'exclude'
      const isExclude = finalQuote.globalDiscountType === 'exclude';
      const gDiscount = finalQuote.globalDiscountValue || 0;
      const appliesDisc = item.product.category !== 'Services' && item.includeDiscount !== false;

      let unitPrice = effectivePrice;
      if (appliesDisc && isExclude && gDiscount > 0) {
        unitPrice = effectivePrice * (1 - gDiscount / 100);
      }

      const displayUnitPrice = Math.round(unitPrice);
      const displayTotal = Math.round(unitPrice * item.quantity);

      worksheetData.push([
        (idx + 1).toString(),
        item.product.modelNumber,
        item.product.category,
        (item.customDescription || item.product.description) + (item.extraNote ? `\nNote: ${item.extraNote}` : ''),
        item.placeName || '-',
        item.quantity.toString(),
        displayUnitPrice.toLocaleString('en-IN'),
        displayTotal.toLocaleString('en-IN')
      ]);
    });

    const grossTotal = totalPrice(finalQuote.items);
    const gstBaseVal = computeGstBase(finalQuote.items, finalQuote.globalDiscountType, finalQuote.globalDiscountValue || 0);
    const gstAmount = Math.round(gstBaseVal * 0.18);
    const totalDiscountAmount = calculateTotalDiscount(finalQuote.items, finalQuote.globalDiscountType, finalQuote.globalDiscountValue || 0);
    const grandTotal = grossTotal + gstAmount - totalDiscountAmount;
    const val = finalQuote.globalDiscountValue || 0;
    const isInclude = finalQuote.globalDiscountType === 'include';

    worksheetData.push(['']);

    if (finalQuote.globalDiscountType === 'exclude') {
      // EXCLUDE FLOW: Gross -> Discount -> Net -> GST -> Final
      worksheetData.push(['', '', '', '', '', '', 'Gross Total', Math.round(grossTotal).toLocaleString('en-IN')]);
      if (totalDiscountAmount > 0) {
        worksheetData.push(['', '', '', '', '', '', `GST Exclude (${val}%)`, `-${Math.round(totalDiscountAmount).toLocaleString('en-IN')}`]);
        worksheetData.push(['', '', '', '', '', '', 'Net Total', Math.round(grossTotal - totalDiscountAmount).toLocaleString('en-IN')]);
      }
      worksheetData.push(['', '', '', '', '', '', 'GST @18%', Math.round(gstAmount).toLocaleString('en-IN')]);
    } else if (finalQuote.globalDiscountType === 'include') {
      // INCLUDE FLOW: Gross (Incl GST) -> Discount -> Final
      worksheetData.push(['', '', '', '', '', '', 'Total (Incl. GST)', Math.round(grossTotal).toLocaleString('en-IN')]);
      if (totalDiscountAmount > 0) {
        worksheetData.push(['', '', '', '', '', '', `GST Include (${val}%)`, `-${Math.round(totalDiscountAmount).toLocaleString('en-IN')}`]);
      }
    } else {
      // DEFAULT FLOW: Gross -> GST -> Final
      worksheetData.push(['', '', '', '', '', '', 'Gross Total', Math.round(grossTotal).toLocaleString('en-IN')]);
      if (gstAmount > 0) {
        worksheetData.push(['', '', '', '', '', '', 'GST @18%', Math.round(gstAmount).toLocaleString('en-IN')]);
      }
    }

    worksheetData.push(['', '', '', '', '', '', 'Final Amount', Math.round(grandTotal).toLocaleString('en-IN')]);
    if (finalQuote.advanceAmount) {
      worksheetData.push(['', '', '', '', '', '', 'Advance Paid', Math.round(finalQuote.advanceAmount).toLocaleString('en-IN')]);
      worksheetData.push(['', '', '', '', '', '', 'Balance Due', Math.round(grandTotal - finalQuote.advanceAmount).toLocaleString('en-IN')]);
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

  // If not logged in and not a public/customer view URL, show login
  const params = new URLSearchParams(window.location.search);
  const isPublicUrl = params.get('view') === 'customer';
  if (!loggedInUser && !isPublicUrl) {
    return <LoginPage onLogin={handleLogin} />;
  }

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
                <img src="/images/magnific-web.png" alt="magnific" className="h-12 w-auto object-contain" />
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
              {loggedInUser && (
                <div className="flex items-center space-x-3">
                  <div className="flex items-center space-x-2 bg-indigo-50 px-3 py-1.5 rounded-full border border-indigo-100">
                    <div className="w-5 h-5 rounded-full bg-indigo-600 flex items-center justify-center">
                      <span className="text-[10px] font-bold text-white">{loggedInUser.name.charAt(0)}</span>
                    </div>
                    <span className="text-xs font-bold text-indigo-700">{loggedInUser.name}</span>
                  </div>
                  <button
                    onClick={handleLogout}
                    className="text-slate-400 hover:text-red-500 transition-colors p-1"
                    title="Sign Out"
                  >
                    <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                    </svg>
                  </button>
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
                onUpdateItemSetting={handleUpdateItemSetting}
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
