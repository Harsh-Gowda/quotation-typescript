import React, { useState, useMemo } from 'react';
import { Product, QuoteItem } from '../types';
import { discountableSubtotal, servicesSubtotal } from '../utils';
import { BackIcon, SearchIcon, CartIcon } from './Icons';
import ProductCard from './ProductCard';
import ProductModal from './ProductModal';
import CartItem from './CartItem';
import { useNavigate } from 'react-router-dom';

interface ProductSelectionProps {
    cart: QuoteItem[];
    products: Product[];
    addToCart: (product: Product, options: any) => void;
    removeFromCart: (productId: string, options: any) => void;
    updateQuantity: (productId: string, options: any, qty: number) => void;
    updateCartItem: (index: number, options: any) => void;
    subtotal: number;
    discountType: 'flat' | 'percentage' | null;
    setDiscountType: (type: 'flat' | 'percentage' | null) => void;
    discountValue: number;
    setDiscountValue: (val: number) => void;
    onGenerateQuote: () => void;
    isGenerating: boolean;
    isEditMode?: boolean;
    editingQuoteId?: string | null;
    isLoading?: boolean;
}

export default function ProductSelection({
    cart, products, addToCart, removeFromCart, updateQuantity, updateCartItem, subtotal,
    discountType, setDiscountType, discountValue, setDiscountValue,
    onGenerateQuote, isGenerating, isEditMode, editingQuoteId, isLoading
}: ProductSelectionProps) {

    const navigate = useNavigate();

    const [searchTerm, setSearchTerm] = useState('');
    const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);
    const [editingIndex, setEditingIndex] = useState<number | null>(null);

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

    const categories = useMemo(() => {
        const counts: { [key: string]: number } = {};
        products.forEach(p => {
            if (p.category) {
                counts[p.category] = (counts[p.category] || 0) + 1;
            }
        });
        return counts;
    }, [products]);

    const colors = useMemo(() => {
        const counts: { [key: string]: number } = {};
        products.forEach(p => {
            const color = p.bodyColor;
            if (color) {
                counts[color] = (counts[color] || 0) + 1;
            }
        });
        return counts;
    }, [products]);

    const sizes = useMemo(() => {
        const counts: { [key: string]: number } = {};
        products.forEach(p => {
            const size = p.size;
            if (size) {
                counts[size] = (counts[size] || 0) + 1;
            }
        });
        return counts;
    }, [products]);

    const finishes = useMemo(() => {
        const counts: { [key: string]: number } = {};
        products.forEach(p => {
            const finish = p.finishing || p.bodyColor;
            if (finish) {
                counts[finish] = (counts[finish] || 0) + 1;
            }
        });
        return counts;
    }, [products]);

    const filteredProducts = useMemo(() => {
        const specialProducts: Product[] = [
            {
                id: 'customization-charge',
                name: 'Service Card',
                modelNumber: 'SRV-CUST',
                description: 'Charges for customizing the product to specific requirements.',
                price: 0,
                category: 'Services',
                image: 'https://cdn-icons-png.flaticon.com/512/3588/3588647.png',
            },
            {
                id: 'fan-installation',
                name: 'Fan Installation',
                modelNumber: 'SRV-INST',
                price: 600,
                category: 'Services',
                image: '/Assets/products/fan-service.png', // Professional fan installation image
            }
        ];

        const allProducts = [...products, ...specialProducts];

        const term = searchTerm.toLowerCase().trim();
        let filtered = allProducts;

        // Apply search filter
        if (term) {
            filtered = filtered.filter(p =>
                p.name.toLowerCase().includes(term) ||
                p.modelNumber.toLowerCase().includes(term) ||
                p.description.toLowerCase().includes(term) ||
                p.category.toLowerCase().includes(term)
            );
        }

        // Apply category filter
        if (categoryFilter !== 'All') {
            filtered = filtered.filter(p => p.category === categoryFilter);
        }

        // Apply color filter
        if (colorFilter !== 'All') {
            filtered = filtered.filter(p =>
                (p.bodyColor || '').toLowerCase().includes(colorFilter.toLowerCase()) ||
                (p.description || '').toLowerCase().includes(colorFilter.toLowerCase())
            );
        }

        // Apply size filter
        if (sizeFilter !== 'All') {
            filtered = filtered.filter(p =>
                (p.size || '').toLowerCase().includes(sizeFilter.toLowerCase()) ||
                (p.description || '').toLowerCase().includes(sizeFilter.toLowerCase())
            );
        }

        // Apply finishing filter
        if (finishingFilter !== 'All') {
            filtered = filtered.filter(p =>
                (p.finishing || '').toLowerCase().includes(finishingFilter.toLowerCase()) ||
                (p.description || '').toLowerCase().includes(finishingFilter.toLowerCase())
            );
        }

        return filtered;
    }, [searchTerm, categoryFilter, colorFilter, sizeFilter, finishingFilter, products]);

    return (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 lg:h-[calc(100vh-140px)]">
            <div className="lg:col-span-2 space-y-6 lg:h-full lg:overflow-y-auto no-scrollbar pb-10">
                <div className="flex justify-between items-center">
                    <h2 className="text-2xl font-bold text-slate-800">Magnific Catalog</h2>
                    <button onClick={() => navigate('/')} className="text-indigo-600 hover:text-indigo-800 flex items-center text-sm font-bold">
                        <BackIcon /> <span className="ml-1">Registration</span>
                    </button>
                </div>

                {/* Edit Mode Banner */}
                {isEditMode && editingQuoteId && (
                    <div className="bg-amber-50 border-l-4 border-amber-500 p-4 rounded-lg shadow-sm">
                        <div className="flex items-center">
                            <svg className="w-5 h-5 text-amber-600 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                            <div>
                                <p className="text-sm font-bold text-amber-800">Editing Quotation: {editingQuoteId}</p>
                                <p className="text-xs text-amber-600">Make your changes and click "Update Quotation" to save</p>
                            </div>
                        </div>
                    </div>
                )}

                {/* Combined Filter Section */}
                <div className="bg-white rounded-xl p-4 shadow-sm border border-slate-200">
                    <div className="space-y-4">
                        {/* Search Bar */}
                        <div className="flex flex-col sm:flex-row gap-4 items-end">
                            <div className="flex-1">
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
                            <button
                                onClick={() => setSelectedProduct({
                                    id: 'custom-item',
                                    name: '',
                                    modelNumber: 'CUSTOM',
                                    description: '',
                                    price: 0,
                                    category: 'Custom',
                                    image: 'https://cdn-icons-png.flaticon.com/512/3588/3588647.png'
                                })}
                                className="px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold transition-all shadow-md active:scale-95 flex items-center whitespace-nowrap text-sm h-[42px]"
                            >
                                <span className="mr-2 text-lg">+</span> Add Custom Item
                            </button>
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
                                                <button
                                                    type="button"
                                                    onClick={() => { setCategoryFilter('All'); setIsCategoryOpen(false); setCategorySearch(''); }}
                                                    className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${categoryFilter === 'All' ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                                >
                                                    All Products ({products.length})
                                                </button>
                                                {Object.entries(categories).filter(([opt]) => opt.toLowerCase().includes(categorySearch.toLowerCase())).map(([option, count]) => (
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
                                                        {option} ({count})
                                                        {categoryFilter === option && <span className="float-right">✓</span>}
                                                    </button>
                                                ))}
                                                {['Services', 'Custom'].filter(opt => opt.toLowerCase().includes(categorySearch.toLowerCase())).map(option => (
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
                                                        {option}
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
                                                <button
                                                    type="button"
                                                    onClick={() => { setColorFilter('All'); setIsColorOpen(false); setColorSearch(''); }}
                                                    className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${colorFilter === 'All' ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                                >
                                                    All Colors
                                                </button>
                                                {Object.entries(colors).filter(([opt]) => opt.toLowerCase().includes(colorSearch.toLowerCase())).map(([option, count]) => (
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
                                                        {option} ({count})
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
                                                <button
                                                    type="button"
                                                    onClick={() => { setSizeFilter('All'); setIsSizeOpen(false); setSizeSearch(''); }}
                                                    className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${sizeFilter === 'All' ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                                >
                                                    All Sizes
                                                </button>
                                                {Object.entries(sizes).filter(([opt]) => opt.toLowerCase().includes(sizeSearch.toLowerCase())).map(([option, count]) => (
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
                                                        {option} ({count})
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
                                                <button
                                                    type="button"
                                                    onClick={() => { setFinishingFilter('All'); setIsFinishingOpen(false); setFinishingSearch(''); }}
                                                    className={`w-full px-3 py-2 text-left text-sm hover:bg-indigo-50 transition-colors ${finishingFilter === 'All' ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-slate-700'}`}
                                                >
                                                    All Finishes
                                                </button>
                                                {Object.entries(finishes).filter(([opt]) => opt.toLowerCase().includes(finishingSearch.toLowerCase())).map(([option, count]) => (
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
                                                        {option} ({count})
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
                        </div>
                    )}
                </div>
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-5">
                    {isLoading ? (
                        <div className="col-span-full py-20 flex flex-col items-center justify-center space-y-4">
                            <div className="w-12 h-12 border-4 border-indigo-200 border-t-indigo-600 rounded-full animate-spin"></div>
                            <p className="text-slate-500 font-bold animate-pulse">Fetching Magnific Catalog...</p>
                        </div>
                    ) : filteredProducts.length > 0 ? (
                        filteredProducts.map(p => {
                            const inCartQty = cart.filter(item => item.product.id === p.id).reduce((sum, item) => sum + item.quantity, 0);
                            return <ProductCard key={p.id} product={p} onAddClick={() => setSelectedProduct(p)} inCartQty={inCartQty} />;
                        })
                    ) : (
                        <div className="col-span-full py-20 bg-white border-2 border-dashed border-slate-200 rounded-2xl flex flex-col items-center justify-center text-center p-8">
                            <div className="w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center mb-4">
                                <SearchIcon />
                            </div>
                            <h3 className="text-lg font-bold text-slate-800">No products found</h3>
                            <p className="text-slate-500 max-w-xs mt-2">Try adjusting your search or filters to find what you're looking for.</p>
                            {(searchTerm || categoryFilter !== 'All' || colorFilter !== 'All' || sizeFilter !== 'All' || finishingFilter !== 'All') && (
                                <button
                                    onClick={() => {
                                        setCategoryFilter('All');
                                        setColorFilter('All');
                                        setSizeFilter('All');
                                        setFinishingFilter('All');
                                        setSearchTerm('');
                                    }}
                                    className="mt-6 px-6 py-2 bg-indigo-600 text-white font-bold rounded-xl hover:bg-indigo-700 transition-all shadow-md"
                                >
                                    Clear All Filters
                                </button>
                            )}
                        </div>
                    )}
                </div>
            </div>
            {(selectedProduct || editingIndex !== null) && (
                <ProductModal
                    product={selectedProduct || cart[editingIndex!].product}
                    initialValues={editingIndex !== null ? cart[editingIndex!] : undefined}
                    onClose={() => { setSelectedProduct(null); setEditingIndex(null); }}
                    onAdd={(options) => {
                        const fullOptions = {
                            ...options,
                            size: sizeFilter === 'All' ? '' : sizeFilter,
                            color: colorFilter === 'All' ? '' : colorFilter,
                            lamp: finishingFilter === 'All' ? '' : finishingFilter,
                        };
                        if (editingIndex !== null) {
                            updateCartItem(editingIndex, fullOptions);
                        } else {
                            addToCart(selectedProduct!, fullOptions);
                        }
                        setSelectedProduct(null);
                        setEditingIndex(null);
                    }}
                />
            )}
            <div className="lg:col-span-1 lg:h-full">
                <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-6 lg:h-full lg:flex lg:flex-col lg:overflow-y-auto no-scrollbar">
                    <h3 className="text-lg font-bold mb-4 flex items-center border-b pb-2">
                        <CartIcon /> <span className="ml-2">Selection Cart</span>
                    </h3>
                    <div className="space-y-4 mb-6 pr-2 no-scrollbar">
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
                                        customDescription: item.customDescription,
                                        extraNote: item.extraNote,
                                        discount: item.discount
                                    })}
                                    onQtyChange={q => updateQuantity(item.product.id, {
                                        placeName: item.placeName,
                                        size: item.size,
                                        color: item.color,
                                        lamp: item.lamp,
                                        customDescription: item.customDescription,
                                        extraNote: item.extraNote,
                                        discount: item.discount
                                    }, q)}
                                    onEdit={() => setEditingIndex(idx)}
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
                                            <span>Discount {discountType === 'percentage' ? `(${discountValue}%)` : ''} (excl. services):</span>
                                            <span>
                                                -₹{(discountType === 'flat'
                                                    ? discountValue
                                                    : Math.round(discountableSubtotal(cart) * discountValue / 100)
                                                ).toLocaleString('en-IN')}
                                            </span>
                                        </div>
                                        <div className="flex justify-between font-bold text-slate-900 pt-1">
                                            <span>Net Total:</span>
                                            <span>
                                                ₹{(() => {
                                                    const discSub = discountableSubtotal(cart);
                                                    const srvSub = servicesSubtotal(cart);
                                                    const discAmt = discountType === 'flat' ? discountValue : Math.round(discSub * discountValue / 100);
                                                    return (discSub - discAmt + srvSub).toLocaleString('en-IN');
                                                })()}
                                            </span>
                                        </div>
                                        <div className="flex justify-between text-slate-500 italic">
                                            <span>+ GST @18%:</span>
                                            <span>₹{(() => {
                                                const discSub = discountableSubtotal(cart);
                                                const srvSub = servicesSubtotal(cart);
                                                const discAmt = discountType === 'flat' ? discountValue : Math.round(discSub * discountValue / 100);
                                                return Math.round((discSub - discAmt + srvSub) * 0.18).toLocaleString('en-IN');
                                            })()}</span>
                                        </div>
                                        <div className="flex justify-between font-black text-indigo-700 pt-1 border-t border-dashed">
                                            <span>Final Amount:</span>
                                            <span>
                                                ₹{(() => {
                                                    const discSub = discountableSubtotal(cart);
                                                    const srvSub = servicesSubtotal(cart);
                                                    const discAmt = discountType === 'flat' ? discountValue : Math.round(discSub * discountValue / 100);
                                                    return Math.round((discSub - discAmt + srvSub) * 1.18).toLocaleString('en-IN');
                                                })()}
                                            </span>
                                        </div>
                                    </div>
                                )}
                            </div>

                            <p className="text-[10px] text-slate-400 italic text-center">* GST to be calculated manually</p>
                            <button
                                onClick={onGenerateQuote}
                                disabled={isGenerating}
                                className="w-full bg-green-600 hover:bg-green-700 text-white font-bold py-3 rounded-xl transition-all shadow-md flex items-center justify-center disabled:opacity-50"
                            >
                                {isGenerating ? "Processing..." : (isEditMode ? "Update Quotation" : "Generate Quote")}
                            </button>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
}
