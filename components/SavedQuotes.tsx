import React, { useState, useMemo } from 'react';
import { Quotation } from '../types';
import { BackIcon } from './Icons';
import { useNavigate } from 'react-router-dom';
import { totalPrice, computeGstBase, calculateTotalDiscount } from '../utils';

interface SavedQuotesProps {
    savedQuotes: Quotation[];
    currentUser: string;
    currentUserRole?: string;
    isLoading?: boolean;
    onLoad: (q: Quotation) => void;
    onEdit: (q: Quotation) => void;
    onDelete: (e: React.MouseEvent, id: string) => void;
    onDuplicate?: (q: Quotation) => void;
    onNewQuote: () => void;
}

export default function SavedQuotes({ savedQuotes, currentUser, currentUserRole, isLoading, onLoad, onEdit, onDelete, onDuplicate, onNewQuote }: SavedQuotesProps) {
    const navigate = useNavigate();
    const [searchQuery, setSearchQuery] = useState('');
    const [dateFilter, setDateFilter] = useState('');
    const [sortBy, setSortBy] = useState('date_desc');
    const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 10;

    React.useEffect(() => {
        setCurrentPage(1);
    }, [searchQuery, dateFilter, sortBy]);

    const isAdmin = currentUser === 'Admin' || currentUserRole === 'admin';

    // Check if the current user can edit a quote (only their own quotes)
    const canEdit = (q: Quotation): boolean => {
        // Admin can edit all quotes
        if (currentUser === 'Admin' || currentUserRole === 'admin') return true;
        // User can edit their own quotes
        if (q.createdBy === currentUser) return true;
        // Legacy quotes without createdBy — check if ID prefix matches user
        if (!q.createdBy) {
            const newPrefix = 'M' + currentUser.substring(0, 3).toUpperCase();
            const oldPrefix = 'M' + currentUser.substring(0, 2).toUpperCase();
            return q.id.startsWith(newPrefix) || q.id.startsWith(oldPrefix);
        }
        return false;
    };

    const getQuoteStats = (q: Quotation) => {
        const totalNoTax = totalPrice(q.items);
        const gstAmt = Math.round(computeGstBase(q.items, q.globalDiscountType, q.globalDiscountValue) * 0.18);
        const totalDiscountAmount = calculateTotalDiscount(q.items, q.globalDiscountType, q.globalDiscountValue);
        const finalAmount = totalNoTax + gstAmt - totalDiscountAmount;
        return { finalAmount, totalDiscountAmount };
    };

    const filteredAndSortedQuotes = useMemo(() => {
        let result = [...savedQuotes];

        // Search Filter
        if (searchQuery.trim()) {
            const query = searchQuery.toLowerCase();
            result = result.filter(q =>
                q.id.toLowerCase().includes(query) ||
                q.customer.name.toLowerCase().includes(query) ||
                q.customer.phone.toLowerCase().includes(query)
            );
        }

        // Date Filter
        if (dateFilter) {
            // dateFilter is YYYY-MM-DD
            const filterDate = new Date(dateFilter);
            result = result.filter(q => {
                const qDate = new Date(q.date);
                return qDate.getFullYear() === filterDate.getFullYear() &&
                    qDate.getMonth() === filterDate.getMonth() &&
                    qDate.getDate() === filterDate.getDate();
            });
        }

        // Sorting
        result.sort((a, b) => {
            if (sortBy.startsWith('date')) {
                const dateA = new Date(a.date).getTime();
                const dateB = new Date(b.date).getTime();
                // If dates are exactly the same (e.g. same day), fallback to createdAt or ID sort
                if (dateA === dateB) {
                    if (a.createdAt && b.createdAt) {
                        const timeA = new Date(a.createdAt).getTime();
                        const timeB = new Date(b.createdAt).getTime();
                        return sortBy === 'date_desc' ? timeB - timeA : timeA - timeB;
                    }
                    return sortBy === 'date_desc' ? b.id.localeCompare(a.id) : a.id.localeCompare(b.id);
                }
                return sortBy === 'date_desc' ? dateB - dateA : dateA - dateB;
            }

            const statsA = getQuoteStats(a);
            const statsB = getQuoteStats(b);

            if (sortBy.startsWith('amount')) {
                return sortBy === 'amount_desc' ? statsB.finalAmount - statsA.finalAmount : statsA.finalAmount - statsB.finalAmount;
            }

            if (sortBy.startsWith('discount')) {
                return sortBy === 'discount_desc' ? statsB.totalDiscountAmount - statsA.totalDiscountAmount : statsA.totalDiscountAmount - statsB.totalDiscountAmount;
            }

            return 0;
        });

        return result;
    }, [savedQuotes, searchQuery, dateFilter, sortBy]);

    const totalPages = Math.ceil(filteredAndSortedQuotes.length / itemsPerPage);

    const paginatedQuotes = useMemo(() => {
        const startIndex = (currentPage - 1) * itemsPerPage;
        return filteredAndSortedQuotes.slice(startIndex, startIndex + itemsPerPage);
    }, [filteredAndSortedQuotes, currentPage]);

    return (
        <div className="max-w-6xl mx-auto px-4 pb-10">
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4">
                <h2 className="text-3xl font-bold text-slate-800">Quote Archive</h2>
                <button onClick={onNewQuote} className="bg-white border text-slate-700 px-4 py-2 rounded-lg font-bold text-sm shadow-sm hover:bg-slate-50 flex items-center transition-colors">
                    <BackIcon /> <span className="ml-1">New Quote</span>
                </button>
            </div>

            {/* Filter and Sort Controls */}
            <div className="bg-white p-4 rounded-xl shadow-sm border border-slate-200 mb-6 flex flex-col lg:flex-row gap-4 items-center justify-between">
                <div className="flex flex-col sm:flex-row gap-4 w-full lg:w-auto flex-1">
                    {/* Search */}
                    <div className="relative flex-1 min-w-[200px]">
                        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg className="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>
                        </div>
                        <input
                            type="text"
                            placeholder="Search ID, phone, or name..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            className="w-full pl-10 pr-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                        />
                    </div>
                    {/* Date Filter */}
                    <div className="flex items-center gap-2 w-full sm:w-auto">
                        <span className="text-slate-500 text-sm font-semibold whitespace-nowrap">Date:</span>
                        <input
                            type="date"
                            value={dateFilter}
                            onChange={(e) => setDateFilter(e.target.value)}
                            className="flex-1 sm:w-auto px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-slate-700"
                        />
                        {dateFilter && (
                            <button onClick={() => setDateFilter('')} className="p-2 text-slate-400 hover:text-red-500 transition-colors" title="Clear Date">
                                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                            </button>
                        )}
                    </div>
                </div>

                <div className="flex items-center gap-4 w-full lg:w-auto justify-between lg:justify-end">
                    {/* Sort Dropdown */}
                    <div className="flex items-center gap-2">
                        <span className="text-slate-500 text-sm font-semibold whitespace-nowrap">Sort:</span>
                        <select
                            value={sortBy}
                            onChange={(e) => setSortBy(e.target.value)}
                            className="px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 bg-slate-50 font-medium text-slate-700"
                        >
                            <option value="date_desc">Newest First</option>
                            <option value="date_asc">Oldest First</option>
                            <option value="amount_desc">Amount: High to Low</option>
                            <option value="amount_asc">Amount: Low to High</option>
                            <option value="discount_desc">Discount: High to Low</option>
                            <option value="discount_asc">Discount: Low to High</option>
                        </select>
                    </div>

                    {/* View Toggle */}
                    <div className="flex items-center bg-slate-100 p-1 rounded-lg border border-slate-200">
                        <button
                            onClick={() => setViewMode('list')}
                            className={`p-1.5 rounded-md transition-colors ${viewMode === 'list' ? 'bg-white shadow-sm text-indigo-600' : 'text-slate-400 hover:text-slate-600'}`}
                            title="List View"
                        >
                            <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clipRule="evenodd" /></svg>
                        </button>

                        <button
                            onClick={() => setViewMode('grid')}
                            className={`p-1.5 rounded-md transition-colors ${viewMode === 'grid' ? 'bg-white shadow-sm text-indigo-600' : 'text-slate-400 hover:text-slate-600'}`}
                            title="Grid View"
                        >
                            <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" /></svg>
                        </button>

                    </div>
                </div>
            </div>
            {isLoading ? (
                <div className="bg-white rounded-xl p-16 text-center shadow-sm border border-slate-200">
                    <div className="inline-flex items-center space-x-3">
                        <svg className="animate-spin h-5 w-5 text-indigo-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
                        </svg>
                        <span className="text-slate-500 font-medium">Loading quotations...</span>
                    </div>
                </div>
            ) : savedQuotes.length === 0 ? (
                <div className="bg-white rounded-xl p-16 text-center shadow-sm border border-slate-200">
                    <p className="text-slate-400 font-medium italic">No quotations saved yet.</p>
                </div>
            ) : filteredAndSortedQuotes.length === 0 ? (
                <div className="bg-white rounded-xl p-16 text-center shadow-sm border border-slate-200">
                    <p className="text-slate-400 font-medium italic">No quotations found matching your criteria.</p>
                </div>
            ) : viewMode === 'list' ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    {paginatedQuotes.map(q => {
                        const isOwner = canEdit(q);
                        const { finalAmount, totalDiscountAmount } = getQuoteStats(q);
                        return (
                            <div key={q.id} className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm hover:shadow-md hover:border-indigo-300 transition-all group flex flex-col h-full">
                                <div className="flex justify-between items-start mb-3">
                                    <span className="text-[11px] font-black text-indigo-700 uppercase tracking-widest bg-indigo-50 px-2 py-1 rounded-lg">{q.id}</span>
                                    <div className="flex items-center space-x-2">
                                        {q.createdBy && (
                                            <span className="text-[9px] font-bold text-slate-500 bg-slate-100 px-2 py-1 rounded-full">
                                                by {q.createdBy}
                                            </span>
                                        )}
                                        {isAdmin && (
                                            <button onClick={(e) => onDelete(e, q.id)} className="text-slate-300 hover:text-red-500 opacity-0 group-hover:opacity-100 transition-opacity p-1 bg-white rounded-md shadow-sm border border-slate-100 hover:border-red-200">
                                                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                </svg>
                                            </button>
                                        )}
                                    </div>
                                </div>
                                <h4 className="font-bold text-slate-800 text-lg leading-tight mb-1">{q.customer.name}</h4>
                                <div className="flex flex-col mb-4 space-y-1">
                                    <p className="text-xs text-slate-500 font-medium flex items-center">
                                        <svg className="w-3.5 h-3.5 mr-1.5 opacity-70" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" /></svg>
                                        {q.customer.phone}
                                    </p>
                                    <p className="text-xs text-slate-400 font-medium flex items-center">
                                        <svg className="w-3.5 h-3.5 mr-1.5 opacity-70" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                        {q.date}
                                    </p>
                                </div>

                                <div className="mt-auto border-t border-slate-100 pt-3">
                                    <div className="flex justify-between items-end mb-4">
                                        <div className="flex flex-col">
                                            <span className="text-slate-400 text-[10px] font-bold uppercase tracking-wider mb-0.5">Items: {q.items.length}</span>
                                            {totalDiscountAmount > 0 && (
                                                <span className="text-orange-500 text-[10px] font-bold bg-orange-50 px-1.5 py-0.5 rounded uppercase self-start mb-0.5">
                                                    Saved ₹{totalDiscountAmount.toLocaleString('en-IN')}
                                                </span>
                                            )}
                                        </div>
                                        <span className="font-black text-indigo-700 text-lg leading-none">₹{finalAmount.toLocaleString('en-IN')}</span>
                                    </div>

                                    <div className="grid grid-cols-3 gap-2">
                                        {isOwner ? (
                                            <button
                                                onClick={() => onEdit(q)}
                                                className="bg-amber-50 hover:bg-amber-100 text-amber-700 px-2 py-2 rounded-xl font-bold text-[11px] transition-all flex flex-col items-center justify-center border border-amber-200"
                                            >
                                                <svg className="w-4 h-4 mb-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" /></svg>
                                                Edit
                                            </button>
                                        ) : (
                                            <div className="bg-slate-50 text-slate-400 px-2 py-2 rounded-xl font-bold text-[11px] flex flex-col items-center justify-center border border-slate-200 cursor-not-allowed">
                                                <svg className="w-4 h-4 mb-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                                                Locked
                                            </div>
                                        )}
                                        <button
                                            onClick={() => onLoad(q)}
                                            className="bg-indigo-600 hover:bg-indigo-700 text-white px-2 py-2 rounded-xl font-bold text-[11px] transition-all flex flex-col items-center justify-center shadow-sm"
                                        >
                                            <svg className="w-4 h-4 mb-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                                            View
                                        </button>
                                        <button
                                            onClick={() => onDuplicate?.(q)}
                                            className="bg-indigo-50 hover:bg-indigo-100 text-indigo-700 px-2 py-2 rounded-xl font-bold text-[11px] transition-all flex flex-col items-center justify-center border border-indigo-200"
                                        >
                                            <svg className="w-4 h-4 mb-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2" /></svg>
                                            Duplicate
                                        </button>
                                    </div>
                                </div>
                            </div>
                        );
                    })}
                </div>
            ) : (
                <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                    <div className="overflow-x-auto">
                        <table className="w-full text-left border-collapse">
                            <thead>
                                <tr className="bg-slate-50 border-b border-slate-200 text-slate-500 text-[10px] uppercase tracking-wider">
                                    <th className="p-4 font-bold">Quote ID</th>
                                    <th className="p-4 font-bold">Customer Info</th>
                                    <th className="p-4 font-bold">Date</th>
                                    <th className="p-4 font-bold text-right">Items</th>
                                    <th className="p-4 font-bold text-right">Discount</th>
                                    <th className="p-4 font-bold text-right">Amount</th>
                                    <th className="p-4 font-bold text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-slate-100">
                                {paginatedQuotes.map(q => {
                                    const isOwner = canEdit(q);
                                    const { finalAmount, totalDiscountAmount } = getQuoteStats(q);
                                    return (
                                        <tr key={q.id} className="hover:bg-slate-50/50 transition-colors group">
                                            <td className="p-4">
                                                <div className="flex items-center gap-2">
                                                    <span className="text-xs font-black text-indigo-700">{q.id}</span>
                                                    {isAdmin && (
                                                        <button onClick={(e) => onDelete(e, q.id)} className="text-slate-300 hover:text-red-500 opacity-0 group-hover:opacity-100 transition-opacity p-1">
                                                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
                                                        </button>
                                                    )}
                                                </div>
                                                {q.createdBy && (
                                                    <div className="text-[9px] font-bold text-slate-400 mt-1">by {q.createdBy}</div>
                                                )}
                                            </td>
                                            <td className="p-4">
                                                <div className="font-bold text-slate-800 text-sm">{q.customer.name}</div>
                                                <div className="text-xs text-slate-500 font-medium">{q.customer.phone}</div>
                                            </td>
                                            <td className="p-4">
                                                <div className="text-xs text-slate-600 font-medium">{q.date}</div>
                                            </td>
                                            <td className="p-4 text-right">
                                                <span className="text-xs font-bold text-slate-600 bg-slate-100 px-2 py-1 rounded-md">{q.items.length}</span>
                                            </td>
                                            <td className="p-4 text-right">
                                                {totalDiscountAmount > 0 ? (
                                                    <span className="text-xs font-bold text-orange-500">-₹{totalDiscountAmount.toLocaleString('en-IN')}</span>
                                                ) : (
                                                    <span className="text-xs text-slate-300">-</span>
                                                )}
                                            </td>
                                            <td className="p-4 text-right">
                                                <span className="font-black text-indigo-700 text-sm">₹{finalAmount.toLocaleString('en-IN')}</span>
                                            </td>
                                            <td className="p-4">
                                                <div className="flex items-center justify-center gap-2">
                                                    {isOwner ? (
                                                        <button onClick={() => onEdit(q)} className="p-1.5 bg-amber-50 hover:bg-amber-100 text-amber-600 rounded-lg transition-colors border border-amber-200" title="Edit">
                                                            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" /></svg>
                                                        </button>
                                                    ) : (
                                                        <div className="p-1.5 bg-slate-50 text-slate-300 rounded-lg border border-slate-200 cursor-not-allowed" title="Locked">
                                                            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                                                        </div>
                                                    )}
                                                    <button onClick={() => onLoad(q)} className="p-1.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg transition-colors shadow-sm" title="View">
                                                        <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                                                    </button>
                                                    <button onClick={() => onDuplicate?.(q)} className="p-1.5 bg-indigo-50 hover:bg-indigo-100 text-indigo-600 rounded-lg transition-colors border border-indigo-200" title="Duplicate">
                                                        <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2" /></svg>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}

            {/* Pagination Controls */}
            {totalPages > 1 && (
                <div className="mt-8 flex flex-col sm:flex-row items-center justify-between gap-4 bg-white px-6 py-4 rounded-xl border border-slate-200 shadow-sm animate-in fade-in slide-in-from-bottom-4 duration-300">
                    <div className="text-sm font-semibold text-slate-500">
                        Showing <span className="text-slate-800 font-bold">{Math.min((currentPage - 1) * itemsPerPage + 1, filteredAndSortedQuotes.length)}</span> to <span className="text-slate-800 font-bold">{Math.min(currentPage * itemsPerPage, filteredAndSortedQuotes.length)}</span> of <span className="text-slate-800 font-bold">{filteredAndSortedQuotes.length}</span> quotes
                    </div>
                    <div className="flex items-center gap-1.5">
                        {/* Prev Button */}
                        <button
                            onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                            disabled={currentPage === 1}
                            className="p-2 rounded-lg border border-slate-200 text-slate-500 hover:bg-slate-50 hover:text-indigo-600 disabled:opacity-50 disabled:hover:bg-transparent disabled:hover:text-slate-500 transition-all font-bold text-sm flex items-center justify-center min-w-[36px] h-9"
                        >
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2.5} d="M15 19l-7-7 7-7" />
                            </svg>
                        </button>

                        {/* Page Numbers */}
                        {Array.from({ length: totalPages }, (_, idx) => idx + 1).map(page => {
                            const isSelected = page === currentPage;
                            return (
                                <button
                                    key={page}
                                    onClick={() => setCurrentPage(page)}
                                    className={`w-9 h-9 rounded-lg font-bold text-sm transition-all flex items-center justify-center
                                        ${isSelected 
                                            ? 'bg-gradient-to-r from-indigo-600 to-violet-600 text-white shadow-md shadow-indigo-100' 
                                            : 'border border-slate-200 text-slate-600 hover:bg-slate-50 hover:text-indigo-600 hover:border-slate-300'
                                        }`}
                                >
                                    {page}
                                </button>
                            );
                        })}

                        {/* Next Button */}
                        <button
                            onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
                            disabled={currentPage === totalPages}
                            className="p-2 rounded-lg border border-slate-200 text-slate-500 hover:bg-slate-50 hover:text-indigo-600 disabled:opacity-50 disabled:hover:bg-transparent disabled:hover:text-slate-500 transition-all font-bold text-sm flex items-center justify-center min-w-[36px] h-9"
                        >
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2.5} d="M9 5l7 7-7 7" />
                            </svg>
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}
