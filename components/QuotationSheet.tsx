
import React, { useState } from 'react';
import { Quotation, QuoteItem, Customer } from '../types';
import { totalPrice, discountableSubtotal, servicesSubtotal, computeGstBase, calculateTotalDiscount } from '../utils';
import UPIScanner from './UPIScanner';

interface QuotationSheetProps {
    quote: Quotation;
    subtotal: number;
    isCustomerView?: boolean;
    isEditable?: boolean;
    onUpdateCustomer?: (updates: Partial<Customer & { advanceAmount?: number; advanceDate?: string }>) => void;
    onUpdateItemQuantity?: (index: number, quantity: number) => void;
    onUpdateItemPlace?: (index: number, placeName: string) => void;
    onUpdateItemSetting?: (index: number, key: 'showLineart' | 'includeGst' | 'includeDiscount', value: boolean) => void;
}

export default function QuotationSheet({ quote, subtotal, isCustomerView, isEditable, onUpdateCustomer, onUpdateItemQuantity, onUpdateItemPlace, onUpdateItemSetting }: QuotationSheetProps) {
    const [editingField, setEditingField] = useState<string | null>(null);
    const [tempValue, setTempValue] = useState<string>('');

    // Using shared utilities from utils.ts
    const gstBase = computeGstBase(quote.items, quote.globalDiscountType, quote.globalDiscountValue);
    const totalDiscountAmount = calculateTotalDiscount(quote.items, quote.globalDiscountType, quote.globalDiscountValue);

    const startEdit = (field: string, currentValue: string | number) => {
        if (!isEditable) return;
        setEditingField(field);
        setTempValue(String(currentValue));
    };

    const saveEdit = (field: string) => {
        if (!onUpdateCustomer && !onUpdateItemQuantity && !onUpdateItemPlace) return;

        const [type, ...rest] = field.split('-');

        if (type === 'customer') {
            const fieldName = rest[0];
            onUpdateCustomer?.({ [fieldName]: tempValue });
        } else if (type === 'qty') {
            const index = parseInt(rest[0]);
            onUpdateItemQuantity?.(index, parseInt(tempValue) || 1);
        } else if (type === 'place') {
            const index = parseInt(rest[0]);
            onUpdateItemPlace?.(index, tempValue);
        }

        setEditingField(null);
        setTempValue('');
    };

    const cancelEdit = () => {
        setEditingField(null);
        setTempValue('');
    };

    const formatAdvanceDate = (dateStr?: string) => {
        if (!dateStr) return '';
        const parts = dateStr.split('-');
        if (parts.length === 3) {
            return `${parts[2]}/${parts[1]}/${parts[0]}`;
        }
        return dateStr;
    };

    return (
        <div className="flex flex-col min-h-full bg-white overflow-visible">
            {/* Top Banner */}
            <div className="w-full bg-[#004aad] text-white text-center py-2 font-bold tracking-[0.2em] uppercase text-sm print:text-xs print:py-1.5">
                Quotation
            </div>

            <div className="p-6 print:p-0 print:px-2 flex-1">
                <div className="flex justify-between items-end border-b-2 border-slate-800 pb-4 mb-2">
                    <div>
                        <div className="mb-2">
                            <img src="/images/magnific-web.png" alt="website logo" className="w-[100px] font-black text-indigo-600 tracking-tighter italic mb-4" />
                            <div className="flex items-center space-x-2 mt-[-4px]">



                                <span className="text-[7px] font-bold text-slate-500 uppercase tracking-[0.2em] whitespace-nowrap">Designer Fans — Luxury Premium Lighting</span>

                            </div>
                        </div>
                        <div className="text-[9px] text-slate-800 font-medium leading-tight">
                            <p>No. 42/1, 2nd Floor, I-Towers, 100ft Intermediate Ring Road</p>
                            <p>(Near Royal Oak), Koramangala, Bengaluru - 560047</p>
                            <p>Tel: 9513866001
                                E: info@magnific.in</p>
                        </div>
                    </div>
                    <div className="text-right text-[10px] font-bold text-slate-900 space-y-0.5">
                        <p>Quatation.No: {quote.id}</p>
                        <p>Date: {quote.date}</p>
                    </div>
                </div>

                {!isCustomerView && (
                    <div className="mb-6 text-[12px]">
                        <div className="flex space-x-1 items-center group">
                            <span className="font-bold w-12 text-slate-900 whitespace-nowrap">To:</span>
                            {editingField === 'customer-name' ? (
                                <div className="flex items-center space-x-1">
                                    <input
                                        type="text"
                                        value={tempValue}
                                        onChange={(e) => setTempValue(e.target.value)}
                                        onBlur={() => saveEdit('customer-name')}
                                        onKeyDown={(e) => {
                                            if (e.key === 'Enter') saveEdit('customer-name');
                                            if (e.key === 'Escape') cancelEdit();
                                        }}
                                        className="font-bold text-slate-800 uppercase border-b-2 border-indigo-500 outline-none bg-transparent px-1"
                                        autoFocus
                                    />
                                </div>
                            ) : (
                                <span
                                    className="font-bold text-slate-800 uppercase cursor-pointer hover:bg-indigo-50 px-1 rounded"
                                    onClick={() => startEdit('customer-name', quote.customer.name)}
                                >
                                    {quote.customer.name}
                                    {isEditable && <span className="ml-1 text-indigo-400 opacity-0 group-hover:opacity-100 text-[10px]">✏️</span>}
                                </span>
                            )}
                        </div>
                        <div className="flex space-x-1 items-center group">
                            <span className="font-bold w-12 text-slate-900 whitespace-nowrap">Phone:</span>
                            {editingField === 'customer-phone' ? (
                                <div className="flex items-center space-x-1">
                                    <input
                                        type="text"
                                        value={tempValue}
                                        onChange={(e) => setTempValue(e.target.value)}
                                        onBlur={() => saveEdit('customer-phone')}
                                        onKeyDown={(e) => {
                                            if (e.key === 'Enter') saveEdit('customer-phone');
                                            if (e.key === 'Escape') cancelEdit();
                                        }}
                                        className="font-medium text-slate-700 border-b-2 border-indigo-500 outline-none bg-transparent px-1"
                                        autoFocus
                                    />
                                </div>
                            ) : (
                                <span
                                    className="font-medium text-slate-700 cursor-pointer hover:bg-indigo-50 px-1 rounded"
                                    onClick={() => startEdit('customer-phone', quote.customer.phone)}
                                >
                                    {quote.customer.phone}
                                    {isEditable && <span className="ml-1 text-indigo-400 opacity-0 group-hover:opacity-100 text-[10px]">✏️</span>}
                                </span>
                            )}
                        </div>
                    </div>
                )}


                {/* Desktop Table View */}
                <table className="w-full mb-8 border-[1.5px] border-slate-900 border-collapse table-fixed hidden md:table print:table">
                    <thead>
                        <tr className="bg-slate-200/80 border-[1.5px] border-slate-900">
                            <th className={`border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center ${isCustomerView ? 'w-[5%]' : 'w-[4%]'}`}>S.NO.</th>
                            <th className={`border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center ${isCustomerView ? 'w-[40%]' : 'w-[20%]'}`}>MODEL & IMAGE</th>
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[28%]">TECHNICAL DETAILS</th>}
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[8%]">AREA</th>}
                            <th className={`border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center ${isCustomerView ? 'w-[10%]' : 'w-[5%]'}`}>QTY</th>
                            <th className={`border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center ${isCustomerView ? 'w-[20%]' : 'w-[10%]'}`}>PRICE</th>
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[9%]">AFTER DISCOUNT</th>}
                            <th className={`border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center ${isCustomerView ? 'w-[25%]' : 'w-[16%]'}`}>TOTAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        {quote.items.map((i, idx) => (
                            <tr key={idx} className="border-[1.5px] border-slate-900 break-inside-avoid group relative transition-colors hover:bg-slate-50/50 group-hover:z-[100]">
                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-bold text-slate-900">{idx + 1}</td>

                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center">
                                    <div className="flex flex-col items-center justify-center space-y-2 print:space-y-0.5">
                                        {(i.customImage || i.product.image) ? (
                                            <img
                                                src={i.customImage || i.product.image}
                                                className="w-24 h-24 print:w-14 print:h-14 object-contain transition-all duration-300"
                                                alt={i.customName || i.product.name}
                                                style={i.showLineart ? {
                                                    filter: 'grayscale(1) contrast(1.8) brightness(1.2) invert(0)',
                                                    opacity: 0.85
                                                } : {}}
                                            />
                                        ) : (
                                            <div className="w-24 h-24 print:w-14 print:h-14 flex flex-col items-center justify-center bg-slate-100 rounded-lg border border-dashed border-slate-300">
                                                <svg className="w-8 h-8 text-slate-300" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                                <span className="text-[8px] text-slate-400 font-bold mt-1">No Image</span>
                                            </div>
                                        )}
                                        <span className="text-[10px] print:text-[8px] font-black text-slate-900 uppercase tracking-tight">{i.customModelNumber || i.product.modelNumber}</span>
                                        {(isCustomerView || i.isCustom) && <span className="text-[11px] font-bold text-slate-700">{i.customName || i.product.name}</span>}
                                    </div>
                                </td>

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center align-middle">
                                        <div className="flex flex-col items-center justify-center space-y-1 w-full relative">
                                            <span className="text-[11px] text-slate-600 font-medium leading-relaxed italic block underline decoration-indigo-200/50 underline-offset-4 whitespace-pre-line">
                                                {i.customDescription || i.product.description || [
                                                    i.product.size && `Size: ${i.product.size}`,
                                                    i.product.lamp && `Lamp: ${i.product.lamp}`,
                                                    i.product.finishing && `Finish: ${i.product.finishing}`,
                                                    i.product.sweep && `Sweep: ${i.product.sweep}`,
                                                    i.product.motorSpec && `Motor: ${i.product.motorSpec}`
                                                ].filter(Boolean).join('\n')}
                                            </span>
                                            {i.extraNote && (
                                                <span className="text-[10px] text-blue-600 font-bold whitespace-pre-line border-t border-blue-100 mt-1 pt-1 w-full text-center">
                                                    {i.extraNote}
                                                </span>
                                            )}
                                        </div>
                                    </td>
                                )}
                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[11px] font-bold text-slate-900 leading-tight group/area">
                                        {editingField === `place-${idx}` ? (
                                            <input
                                                type="text"
                                                value={tempValue}
                                                onChange={(e) => setTempValue(e.target.value)}
                                                onBlur={() => saveEdit(`place-${idx}`)}
                                                onKeyDown={(e) => {
                                                    if (e.key === 'Enter') saveEdit(`place-${idx}`);
                                                    if (e.key === 'Escape') cancelEdit();
                                                }}
                                                className="w-full text-center border-b-2 border-indigo-500 outline-none bg-transparent font-bold"
                                                autoFocus
                                                placeholder="Area"
                                            />
                                        ) : (
                                            <span
                                                className="cursor-pointer hover:bg-indigo-50 px-2 py-1 rounded inline-block"
                                                onClick={() => startEdit(`place-${idx}`, i.placeName || '')}
                                            >
                                                {i.placeName || '-'}
                                                {isEditable && <span className="ml-1 text-indigo-400 opacity-0 group-hover/area:opacity-100 text-[10px]">✏️</span>}
                                            </span>
                                        )}
                                    </td>
                                )}

                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-bold text-slate-900 group/qty">
                                    {editingField === `qty-${idx}` ? (
                                        <input
                                            type="number"
                                            value={tempValue}
                                            onChange={(e) => setTempValue(e.target.value)}
                                            onBlur={() => saveEdit(`qty-${idx}`)}
                                            onKeyDown={(e) => {
                                                if (e.key === 'Enter') saveEdit(`qty-${idx}`);
                                                if (e.key === 'Escape') cancelEdit();
                                            }}
                                            className="w-12 text-center border-b-2 border-indigo-500 outline-none bg-transparent font-bold"
                                            autoFocus
                                            min="1"
                                        />
                                    ) : (
                                        <span
                                            className="cursor-pointer hover:bg-indigo-50 px-2 py-1 rounded inline-block"
                                            onClick={() => startEdit(`qty-${idx}`, i.quantity)}
                                        >
                                            {i.quantity}
                                            {isEditable && <span className="ml-1 text-indigo-400 opacity-0 group-hover/qty:opacity-100 text-[10px]">✏️</span>}
                                        </span>
                                    )}
                                </td>

                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-bold text-slate-900">
                                    {(() => {
                                        const basePrice = i.customPrice !== undefined ? i.customPrice : i.product.price;
                                        const p = i.includeGst !== false ? basePrice : basePrice / 1.18;
                                        return Math.round(p).toLocaleString('en-IN');
                                    })()}
                                </td>

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-black text-slate-900">
                                        {(() => {
                                            const basePrice = i.customPrice !== undefined ? i.customPrice : i.product.price;
                                            const effectivePrice = i.includeGst !== false ? basePrice : basePrice / 1.18;
                                            const gDiscount = quote.globalDiscountValue || 0;
                                            const appliesDisc = quote.globalDiscountType === 'exclude'
                                                ? (i.includeDiscount !== false)
                                                : (i.product.category !== 'Services' && i.includeDiscount !== false);

                                            // Internal Unit Price shows the price with global discount if type is set
                                            if (appliesDisc && quote.globalDiscountType && gDiscount > 0) {
                                                const discountAmount = effectivePrice * gDiscount / 100;
                                                return Math.round(effectivePrice - discountAmount).toLocaleString('en-IN');
                                            }
                                            return (
                                                <div className="flex flex-col items-center">
                                                    <span>{Math.round(effectivePrice).toLocaleString('en-IN')}</span>
                                                    {i.includeDiscount === false && i.product.category !== 'Services' && (
                                                        <span className="text-[9px] text-red-600 font-bold uppercase mt-0.5 leading-none print:hidden">
                                                            (Disc Off)
                                                        </span>
                                                    )}
                                                </div>
                                            );
                                        })()}
                                    </td>
                                )}

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-black text-indigo-700 bg-slate-50/30 relative">
                                        {/* Item Total */}
                                        {(() => {
                                            const gDiscount = quote.globalDiscountValue || 0;
                                            const basePrice = i.customPrice !== undefined ? i.customPrice : i.product.price;
                                            const effectivePrice = i.includeGst !== false ? basePrice : basePrice / 1.18;
                                            const appliesDisc = quote.globalDiscountType === 'exclude'
                                                ? (i.includeDiscount !== false)
                                                : (i.product.category !== 'Services' && i.includeDiscount !== false);

                                            const discountedPrice = (quote.globalDiscountType && gDiscount > 0 && appliesDisc)
                                                ? effectivePrice * (1 - gDiscount / 100)
                                                : effectivePrice;

                                            return Math.round(discountedPrice * i.quantity).toLocaleString('en-IN');
                                        })()}

                                        {/* Floating Actions Bar (Vertical Slim Capsule) */}
                                        {i.product.category !== 'Services' && (
                                            <div className="absolute left-[calc(100%+8px)] top-1/2 -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-all duration-300 pointer-events-none group-hover:pointer-events-auto flex flex-col items-center gap-2 p-2 bg-white/95 backdrop-blur-md rounded-2xl border border-slate-200 shadow-[0_15px_40px_rgba(0,0,0,0.15)] z-[9999] print:hidden scale-95 group-hover:scale-100 origin-left after:content-[''] after:absolute after:-left-4 after:top-0 after:bottom-0 after:w-4 after:bg-transparent">

                                                {/* Style Toggle */}
                                                <button
                                                    type="button"
                                                    onClick={() => onUpdateItemSetting?.(idx, 'showLineart', !i.showLineart)}
                                                    className={`w-9 h-9 rounded-xl text-[10px] font-black transition-all flex items-center justify-center border shadow-sm ${i.showLineart
                                                        ? 'bg-purple-600 text-white border-purple-700'
                                                        : 'bg-white text-purple-600 border-purple-100 hover:bg-purple-50'
                                                        }`}
                                                    title="Toggle Style"
                                                >
                                                    {i.showLineart ? 'L' : 'S'}
                                                </button>

                                                {/* Discount Toggle */}
                                                <button
                                                    type="button"
                                                    onClick={() => onUpdateItemSetting?.(idx, 'includeDiscount', !i.includeDiscount)}
                                                    className={`w-9 h-9 rounded-xl text-[10px] font-black transition-all flex flex-col items-center justify-center border shadow-sm ${i.includeDiscount !== false
                                                        ? 'bg-orange-600 text-white border-orange-700'
                                                        : 'bg-white text-orange-600 border-orange-100 hover:bg-orange-50'
                                                        }`}
                                                    title="Discount Toggle"
                                                >
                                                    <span className="scale-75">DISC</span>
                                                    <span className="text-[7px] mt-[-4px]">{i.includeDiscount !== false ? 'ON' : 'OFF'}</span>
                                                </button>
                                            </div>
                                        )}
                                    </td>
                                )}

                                {isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-black text-slate-900">
                                        {(() => {
                                            const gDiscount = quote.globalDiscountValue || 0;
                                            const basePrice = i.customPrice !== undefined ? i.customPrice : i.product.price;
                                            const effectivePrice = i.includeGst !== false ? basePrice : basePrice / 1.18;
                                            const appliesDisc = quote.globalDiscountType === 'exclude'
                                                ? (i.includeDiscount !== false)
                                                : (i.product.category !== 'Services' && i.includeDiscount !== false);

                                            const discountedPrice = (quote.globalDiscountType && gDiscount > 0 && appliesDisc)
                                                ? effectivePrice * (1 - gDiscount / 100)
                                                : effectivePrice;

                                            return Math.round(discountedPrice * i.quantity).toLocaleString('en-IN');
                                        })()}
                                    </td>
                                )}
                            </tr>
                        ))}

                        {!isCustomerView && (
                            <>


                                {/* GST always shown: applies to net discountable amount + full services amount */}
                                {quote.globalDiscountType === 'exclude' ? (
                                    <>
                                        {/* EXCLUDE FLOW: Gross -> Discount -> Net -> GST -> Final */}
                                        {quote.globalDiscountValue ? (
                                            <tr>
                                                <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-blue-600 uppercase leading-none">
                                                    discount
                                                </td>
                                                <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-blue-600 leading-none">
                                                    - {totalDiscountAmount.toLocaleString('en-IN')}
                                                </td>
                                            </tr>
                                        ) : null}
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-900 uppercase leading-none">
                                                Net Total
                                            </td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                                                {(totalPrice(quote.items) - totalDiscountAmount).toLocaleString('en-IN')}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">GST @18%</td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                                                {Math.round(gstBase * 0.18).toLocaleString('en-IN')}
                                            </td>
                                        </tr>
                                    </>
                                ) : quote.globalDiscountType === 'include' ? (
                                    <>
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-900 uppercase leading-none">
                                                Net Total (Inc. 18% GST)
                                            </td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                                                {totalPrice(quote.items).toLocaleString('en-IN')}
                                            </td>
                                        </tr>
                                        {quote.globalDiscountValue ? (
                                            <tr>
                                                <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-blue-600 uppercase leading-none">
                                                    discount
                                                </td>
                                                <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-blue-600 leading-none">
                                                    - {totalDiscountAmount.toLocaleString('en-IN')}
                                                </td>
                                            </tr>
                                        ) : null}
                                    </>
                                ) : (
                                    <>
                                        {/* DEFAULT FLOW (No discount): Gross -> GST -> Final */}
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">GST @18%</td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                                                {Math.round(gstBase * 0.18).toLocaleString('en-IN')}
                                            </td>
                                        </tr>
                                    </>
                                )}

                                {quote.advanceAmount ? (
                                    <>
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">
                                                Advance{quote.advanceDate ? ` (${formatAdvanceDate(quote.advanceDate)})` : ''}
                                            </td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">{quote.advanceAmount.toLocaleString('en-IN')}</td>
                                        </tr>
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Total Amount</td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[11px] font-black text-indigo-700 bg-slate-100 leading-none whitespace-nowrap">
                                                ₹{(() => {
                                                    const totalNoTax = totalPrice(quote.items);
                                                    const gstAmt = Math.round(gstBase * 0.18);

                                                    const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                                    return (finalAmount - quote.advanceAmount!).toLocaleString('en-IN');
                                                })()}
                                            </td>
                                        </tr>
                                    </>
                                ) : (
                                    <tr>
                                        <td colSpan={7} className="border-[1.5px] border-slate-900 py-3 px-4 text-right text-[12px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Total Amount
                                        </td>
                                        <td className="border-[1.5px] border-slate-900 py-3 px-2 text-center text-[11px] font-black text-indigo-700 bg-slate-100 leading-none whitespace-nowrap">
                                            ₹{(() => {
                                                const totalNoTax = totalPrice(quote.items);
                                                const gstAmt = Math.round(gstBase * 0.18);

                                                const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                                return finalAmount.toLocaleString('en-IN');
                                            })()}
                                        </td>
                                    </tr>
                                )}
                            </>
                        )}

                        {isCustomerView && (
                            <tr>
                                <td colSpan={4} className="border-[1.5px] border-slate-900 py-3 px-4 text-right text-[12px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Total Amount</td>
                                <td className="border-[1.5px] border-slate-900 py-3 px-2 text-center text-[11px] font-black text-indigo-700 bg-slate-100 leading-none whitespace-nowrap">
                                    ₹{(() => {
                                        const totalNoTax = totalPrice(quote.items);
                                        const gstAmt = Math.round(gstBase * 0.18);

                                        const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                        return finalAmount.toLocaleString('en-IN');
                                    })()}
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>

                {/* Mobile Card View (Hidden on Desktop & Print) */}
                <div className="md:hidden print:hidden space-y-6 mb-8">
                    {quote.items.map((i, idx) => (
                        <div key={idx} className="bg-white border rounded-xl shadow-sm overflow-hidden">
                            <div className="flex p-4 gap-4">
                                {/* Image */}
                                <div className="w-21 h-24 flex-shrink-0 bg-slate-50 rounded-lg flex items-center justify-center p-4 border overflow-hidden">
                                    {(i.customImage || i.product.image) ? (
                                        <img
                                            src={i.customImage || i.product.image}
                                            className="w-full h-full object-contain transition-all duration-300"
                                            alt={i.product.name}
                                            style={i.showLineart ? {
                                                filter: 'grayscale(1) contrast(1.8) brightness(1.2) invert(0)',
                                                opacity: 0.85
                                            } : {}}
                                        />
                                    ) : (
                                        <div className="w-full h-full flex flex-col items-center justify-center">
                                            <svg className="w-8 h-8 text-slate-300" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                            <span className="text-[8px] text-slate-400 font-bold mt-1">No Image</span>
                                        </div>
                                    )}
                                </div>
                                {/* Header Info */}
                                <div className="flex-1 min-w-0">
                                    <div className="flex justify-between items-start p-4">
                                        <span className="text-[10px] bg-slate-100 text-slate-500 font-bold px-2 py-0.5 rounded uppercase tracking-wider">{i.customModelNumber || i.product.modelNumber}</span>
                                        <span className="text-xs font-bold text-slate-400">#{idx + 1}</span>
                                    </div>
                                    <h4 className="font-bold text-slate-900 text-sm mt-1 leading-tight">{i.customName || i.product.name}</h4>

                                    {!isCustomerView && (
                                        <div className="mt-3 flex flex-col space-y-2">
                                            <p className="text-[10px] text-slate-500 font-medium leading-relaxed italic border-l-2 border-indigo-200 pl-2 whitespace-pre-line">
                                                {i.customDescription || i.product.description}
                                            </p>
                                            {i.extraNote && (
                                                <p className="text-[10px] text-blue-600 font-bold leading-relaxed whitespace-pre-line bg-blue-50 p-2 rounded-lg">
                                                    {i.extraNote}
                                                </p>
                                            )}
                                            {i.placeName && (
                                                <div className="text-slate-500 italic text-[10px] pt-1 border-t border-slate-100">{i.placeName}</div>
                                            )}
                                        </div>
                                    )}
                                </div>
                            </div>

                            {/* Pricing Footer */}
                            <div className="bg-slate-50 px-4 py-3 border-t flex justify-between items-center text-xs">
                                <div className="flex flex-col">
                                    <span className="text-[10px] text-slate-400 font-bold uppercase">Qty: {i.quantity}</span>
                                    {!isCustomerView && <span className="font-medium text-slate-500 line-through text-[10px]">₹{(i.customPrice !== undefined ? i.customPrice : i.product.price).toLocaleString('en-IN')}</span>}
                                </div>
                                <div className="flex flex-col items-end">
                                    {(() => {
                                        const gDiscount = quote.globalDiscountValue || 0;
                                        const basePrice = i.customPrice !== undefined ? i.customPrice : i.product.price;
                                        const effectivePrice = i.includeGst !== false ? basePrice : basePrice / 1.18;

                                        const appliesDisc = quote.globalDiscountType === 'exclude'
                                            ? (i.includeDiscount !== false)
                                            : (i.product.category !== 'Services' && i.includeDiscount !== false);
                                        const discountedPrice = (quote.globalDiscountType && gDiscount > 0 && appliesDisc)
                                            ? effectivePrice * (1 - gDiscount / 100)
                                            : effectivePrice;

                                        return (
                                            <div className="flex flex-col items-end">
                                                <span className="font-black text-indigo-700 text-base">₹{Math.round(discountedPrice * i.quantity).toLocaleString('en-IN')}</span>
                                                {i.includeDiscount === false && i.product.category !== 'Services' && (
                                                    <span className="text-[9px] text-red-600 font-bold uppercase mt-0.5 leading-none px-1 py-0.5 bg-red-50 rounded print:hidden">
                                                        Disc Off
                                                    </span>
                                                )}
                                            </div>
                                        );
                                    })()}
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

                            {quote.globalDiscountType === 'exclude' ? (
                                <>
                                    {quote.globalDiscountValue ? (
                                        <div className="flex justify-between text-blue-400">
                                            <span>discount</span>
                                            <span className="font-bold">-{totalDiscountAmount.toLocaleString('en-IN')}</span>
                                        </div>
                                    ) : null}
                                    <div className="flex justify-between border-t border-slate-700 pt-1">
                                        <span className="text-slate-300">Net Total</span>
                                        <span className="font-bold">{(totalPrice(quote.items) - totalDiscountAmount).toLocaleString('en-IN')}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="text-slate-400">GST @18%</span>
                                        <span className="font-bold">{Math.round(gstBase * 0.18).toLocaleString('en-IN')}</span>
                                    </div>
                                </>
                            ) : (
                                <>
                                    <div className="flex justify-between">
                                        <span className="text-slate-400">Net Total (Inc. 18% GST)</span>
                                        <span className="font-bold">{totalPrice(quote.items).toLocaleString('en-IN')}</span>
                                    </div>
                                    {quote.globalDiscountValue ? (
                                        <div className="flex justify-between text-blue-400">
                                            <span>discount </span>
                                            <span className="font-bold">-{totalDiscountAmount.toLocaleString('en-IN')}</span>
                                        </div>
                                    ) : null}
                                </>
                            )}

                            {quote.advanceAmount ? (
                                <>
                                    <div className="flex justify-between">
                                        <span className="text-slate-400">Advance ({quote.advanceDate || 'N/A'})</span>
                                        <span className="font-bold">{quote.advanceAmount.toLocaleString('en-IN')}</span>
                                    </div>
                                    <div className="flex justify-between border-t border-slate-600 pt-2 text-sm">
                                        <span className="font-bold uppercase tracking-wider">Total Amount</span>
                                        <span className="font-bold text-green-400">
                                            ₹{(() => {
                                                const totalNoTax = totalPrice(quote.items);
                                                const gstAmt = Math.round(gstBase * 0.18);

                                                const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                                return (finalAmount - quote.advanceAmount!).toLocaleString('en-IN');
                                            })()}
                                        </span>
                                    </div>
                                </>
                            ) : (
                                <div className="flex justify-between border-t border-slate-600 pt-2 text-sm">
                                    <span className="font-bold uppercase tracking-wider">Total Amount</span>
                                    <span className="font-bold text-green-400">
                                        ₹{(() => {
                                            const totalNoTax = totalPrice(quote.items);
                                            const gstAmt = Math.round(gstBase * 0.18);

                                            const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                            return finalAmount.toLocaleString('en-IN');
                                        })()}
                                    </span>
                                </div>
                            )}
                        </div>)}

                    {isCustomerView && (
                        <div className="bg-slate-800 text-white rounded-xl p-4 space-y-2 text-xs">
                            <div className="flex justify-between items-center text-sm font-bold uppercase tracking-wider">
                                <span>Total Amount</span>
                                <span className="text-green-400 text-lg">
                                    ₹{(() => {
                                        const totalNoTax = totalPrice(quote.items);
                                        const gstAmt = Math.round(gstBase * 0.18);

                                        const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                        return finalAmount.toLocaleString('en-IN');
                                    })()}
                                </span>
                            </div>
                        </div>
                    )}
                </div>

                <div className="mt-6 pt-4 border-t border-slate-200 print-compact print:mt-1 print:pt-1">
                    <div className="flex flex-col gap-6 print:gap-3">
                        {/* Banking Details & UPI QR */}
                        <div className="flex flex-col md:flex-row print:flex-row gap-12 items-start justify-between no-print-break w-full">
                            {/* Banking Column */}
                            <div className="flex-1 flex flex-col items-start">
                                <h4 className="text-[10px] font-black text-indigo-700 border-b-2 border-indigo-700 pb-2 mb-4 uppercase tracking-[0.2em] w-full text-left">Banking Details (RTGS / NEFT)</h4>
                                <div className="space-y-3">
                                    <div className="flex items-center text-[10px]">
                                        <span className="w-28 font-black text-slate-500 uppercase tracking-widest leading-none">Company Name</span>
                                        <span className="font-bold text-slate-900 uppercase leading-none">Magnific Home Appliances</span>
                                    </div>
                                    <div className="flex items-center text-[10px]">
                                        <span className="w-28 font-black text-slate-500 uppercase tracking-widest leading-none">Bank & Branch</span>
                                        <span className="font-bold text-slate-900 uppercase leading-none">Axis Bank Gottigere </span>
                                    </div>
                                    <div className="flex items-center text-[10px]">
                                        <span className="w-28 font-black text-slate-500 uppercase tracking-widest leading-none">A/c No</span>
                                        <span className="font-black text-indigo-700 tracking-wider text-xs leading-none">926030005650178</span>
                                    </div>
                                    <div className="flex items-center text-[10px]">
                                        <span className="w-28 font-black text-slate-500 uppercase tracking-widest leading-none">IFSC Code</span>
                                        <span className="font-black text-indigo-700 tracking-[0.2em] text-xs uppercase leading-none">UTIB0004071</span>
                                    </div>
                                </div>
                            </div>

                            {/* UPI Column */}
                            <div className="w-full md:w-56 print:w-48 flex-shrink-0 flex flex-col items-start">
                                <h4 className="text-[10px] font-black text-indigo-700 border-b-2 border-indigo-700 pb-2 mb-4 uppercase tracking-[0.2em] w-full text-left">Secure UPI Payment</h4>
                                {(() => {
                                    const totalNoTax = totalPrice(quote.items);
                                    const gstAmt = Math.round(gstBase * 0.18);
                                    const finalAmount = (totalNoTax + gstAmt - totalDiscountAmount);
                                    const balanceDue = quote.advanceAmount ? Math.max(0, finalAmount - quote.advanceAmount) : finalAmount;

                                    return (
                                        <div className="text-left w-full flex flex-col items-start">
                                            <p className="text-[8px] text-slate-500 font-bold uppercase mb-4">Scan to pay balance: <span className="text-indigo-600">₹{Math.round(balanceDue).toLocaleString('en-IN')}</span></p>
                                            <UPIScanner
                                                amount={Math.round(balanceDue)}
                                                quotationId={quote.id || 'NEW'}
                                                customerName={quote.customer.name}
                                            />
                                        </div>
                                    );
                                })()}
                            </div>
                        </div>
                    </div>


                    {/* Terms & Conditions */}
                    <div className="mt-6 pt-4 border-t border-slate-100 no-print-break print:mt-1 print:pt-1">
                        <h4 className="text-xs font-bold text-slate-900 mb-3 uppercase tracking-tight">Terms & Conditions:</h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 print:grid-cols-2 gap-x-4 gap-y-1 print:gap-x-4 print:gap-y-0.5">
                            {[
                                "Validity: 15 Days from the date of quotation.",
                                "Payment: 50% of advance to be paid while booking, 100% payment before delivery.",
                                "If applicable: Kindly ensure your GST details are provided prior to the dispatch of the product. No changes can be made once the invoice is generated.",
                                "No refunds will be issued unless there is an error on the company's part. ",
                                "Delivery of the product will only be considered once the customer’s cheque has been issued and cleared. Until that time, no delivery can be expected, so customers should plan accordingly.",
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
                                <div key={i} className="flex space-x-2 items-start">
                                    <span className="text-[8px] font-bold text-indigo-500 bg-indigo-50 w-4 h-4 flex items-center justify-center rounded-full flex-shrink-0">{i + 1}</span>
                                    <p className="text-[9px] text-slate-500 leading-tight font-medium">{term}</p>
                                </div>
                            ))}
                        </div>
                    </div>

                    <div className="mt-8 text-center pt-4 border-t border-slate-100 print:mt-1">
                        <p className="font-bold text-indigo-700 uppercase tracking-[0.4em] text-[10px] print:text-[8px]">Experience Luxury • Magnific Designer Fans and Lights • Koramangala</p>
                    </div>
                </div>
            </div >

            <div className="w-full bg-[#004aad] text-white text-center py-2 font-bold tracking-widest text-sm print:text-xs print:py-1.5">
                www.magnific.in
            </div>
        </div >
    );
}
