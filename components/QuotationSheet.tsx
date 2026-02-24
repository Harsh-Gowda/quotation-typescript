

import React, { useState } from 'react';
import { Quotation, QuoteItem, Customer } from '../types';
import { totalPrice } from '../utils';

interface QuotationSheetProps {
    quote: Quotation;
    subtotal: number;
    qrCodeUrl?: string | null;
    shareUrl?: string | null;
    isCustomerView?: boolean;
    isEditable?: boolean;
    onUpdateCustomer?: (updates: Partial<Customer>) => void;
    onUpdateItemQuantity?: (index: number, quantity: number) => void;
    onUpdateItemPlace?: (index: number, placeName: string) => void;
}

export default function QuotationSheet({ quote, subtotal, qrCodeUrl, shareUrl, isCustomerView, isEditable, onUpdateCustomer, onUpdateItemQuantity, onUpdateItemPlace }: QuotationSheetProps) {
    const [editingField, setEditingField] = useState<string | null>(null);
    const [tempValue, setTempValue] = useState<string>('');

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

    return (
        <div className="flex flex-col min-h-full bg-white">
            {/* Top Banner */}
            <div className="w-full bg-[#004aad] text-white text-center py-2 font-bold tracking-[0.2em] uppercase text-sm print:text-xs print:py-1.5">
                Quotation
            </div>

            <div className="p-10 print:p-2 flex-1">
                <div className="flex justify-between items-end border-b-2 border-slate-800 pb-4 mb-2">
                    <div>
                        <div className="mb-2">
                            <img src="./Assets/magnific-web.png" alt="website logo" className="w-[100px] font-black text-indigo-600 tracking-tighter italic mb-4" />
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
                            <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[6%]">S.NO.</th>
                            <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[24%]">MODEL & IMAGE</th>
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[20%]">TECHNICAL DETAILS</th>}
                            <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[5%]">QTY</th>
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[10%]">AREA</th>}
                            <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[12%]">PRICE</th>
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[11%]">AFTER DISCOUNT</th>}
                            {!isCustomerView && <th className="border-[1.5px] border-slate-900 py-3 px-1 text-[11px] print:text-[9px] font-bold text-slate-800 uppercase text-center w-[20%]">TOTAL</th>}
                        </tr>
                    </thead>
                    <tbody>
                        {quote.items.map((i, idx) => (
                            <tr key={idx} className="border-[1.5px] border-slate-900 break-inside-avoid">
                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-bold text-slate-900">{idx + 1}</td>
                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center">
                                    <div className="flex flex-col items-center justify-center space-y-2 print:space-y-0.5">
                                        <img src={i.product.image} className="w-24 h-24 print:w-14 print:h-14 object-contain" alt={i.product.name} />
                                        <span className="text-[10px] print:text-[8px] font-black text-slate-900 uppercase tracking-tight">{i.product.modelNumber}</span>
                                        {isCustomerView && <span className="text-[11px] font-bold text-slate-700">{i.product.name}</span>}
                                    </div>
                                </td>

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center align-middle">
                                        <div className="flex flex-col items-center justify-center space-y-1 w-full">
                                            <span className="text-[11px] text-slate-600 font-medium leading-relaxed italic block underline decoration-indigo-200/50 underline-offset-4 whitespace-pre-line">
                                                {i.customDescription || i.product.description}
                                            </span>
                                            {i.extraNote && (
                                                <span className="text-[10px] text-blue-600 font-bold whitespace-pre-line border-t border-blue-100 mt-1 pt-1 w-full text-center">
                                                    {i.extraNote}
                                                </span>
                                            )}
                                        </div>
                                    </td>
                                )}

                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-bold text-slate-900 group">
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
                                            {isEditable && <span className="ml-1 text-indigo-400 opacity-0 group-hover:opacity-100 text-[10px]">✏️</span>}
                                        </span>
                                    )}
                                </td>

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[11px] font-bold text-slate-900 leading-tight group">
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
                                                {isEditable && <span className="ml-1 text-indigo-400 opacity-0 group-hover:opacity-100 text-[10px]">✏️</span>}
                                            </span>
                                        )}
                                    </td>
                                )}

                                <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-bold text-slate-900">
                                    {Math.round(i.product.price).toLocaleString('en-IN')}
                                </td>

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-black text-slate-900">
                                        {(() => {
                                            if (!quote.globalDiscountValue) return '-';
                                            if (quote.globalDiscountType === 'percentage') {
                                                const discountAmount = i.product.price * quote.globalDiscountValue / 100;
                                                return Math.round(i.product.price - discountAmount).toLocaleString('en-IN');
                                            }
                                            // For Flat, we don't usually show 'after discount' per item in this specific table layout 
                                            // as it's a global absolute value, but we can return price if it's confusing.
                                            // The user i-8 i-9 might want it to remain as original price if it's a lump sum.
                                            return Math.round(i.product.price).toLocaleString('en-IN');
                                        })()}
                                    </td>
                                )}

                                {!isCustomerView && (
                                    <td className="border-[1.5px] border-slate-900 py-4 print:py-1 px-2 text-center text-[12px] font-black text-slate-900">
                                        {(() => {
                                            const isPercentage = quote.globalDiscountType === 'percentage';
                                            const gDiscount = quote.globalDiscountValue || 0;

                                            if (gDiscount <= 0) return Math.round(i.product.price * i.quantity).toLocaleString('en-IN');

                                            if (isPercentage) {
                                                const discountAmount = i.product.price * gDiscount / 100;
                                                const discountedPrice = i.product.price - discountAmount;
                                                return Math.round(discountedPrice * i.quantity).toLocaleString('en-IN');
                                            }
                                            // For Flat, we show original total for the item, as the discount is a lump sum at the bottom.
                                            return Math.round(i.product.price * i.quantity).toLocaleString('en-IN');
                                        })()}
                                    </td>
                                )}
                            </tr>
                        ))}

                        {!isCustomerView && (
                            <>
                                <tr>
                                    <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">Gross Total</td>
                                    <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                                        {totalPrice(quote.items).toLocaleString('en-IN')}
                                    </td>
                                </tr>

                                {quote.globalDiscountValue ? (
                                    <tr>
                                        <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-red-600 uppercase leading-none">
                                            Discount {quote.globalDiscountType === 'percentage' ? `(${quote.globalDiscountValue}%)` : '(Flat)'}
                                        </td>
                                        <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-red-600 leading-none">
                                            - {(() => {
                                                const sub = totalPrice(quote.items);
                                                const isPercentage = quote.globalDiscountType === 'percentage';
                                                const val = quote.globalDiscountValue || 0;
                                                const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                                return discount.toLocaleString('en-IN');
                                            })()}
                                        </td>
                                    </tr>
                                ) : null}

                                {/* Show GST row: Only if it's a PERCENTAGE discount or NO discount. Flat discount orders are net total only as per requirement. */}
                                {((quote.globalDiscountType === 'percentage' && (quote.globalDiscountValue || 0) >= 0) || !quote.globalDiscountValue) && (
                                    <tr>
                                        <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">GST @18%</td>
                                        <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">
                                            {(() => {
                                                const sub = totalPrice(quote.items);
                                                const isPercentage = quote.globalDiscountType === 'percentage';
                                                const val = quote.globalDiscountValue || 0;
                                                const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                                return Math.round((sub - discount) * 0.18).toLocaleString('en-IN');
                                            })()}
                                        </td>
                                    </tr>
                                )}

                                {quote.advanceAmount ? (
                                    <>
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-bold text-slate-800 uppercase leading-none">Advance ({quote.advanceDate || 'N/A'})</td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[12px] font-bold text-slate-900 leading-none">{quote.advanceAmount.toLocaleString('en-IN')}</td>
                                        </tr>
                                        <tr>
                                            <td colSpan={7} className="border-[1.5px] border-slate-900 py-2 px-4 text-right text-[11px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Amount Paid</td>
                                            <td className="border-[1.5px] border-slate-900 py-2 px-2 text-center text-[11px] font-black text-indigo-700 bg-slate-100 leading-none whitespace-nowrap">
                                                ₹{(() => {
                                                    const sub = totalPrice(quote.items);
                                                    const isPercentage = quote.globalDiscountType === 'percentage';
                                                    const val = quote.globalDiscountValue || 0;
                                                    const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                                    const net = sub - discount;
                                                    const finalAmount = isPercentage ? Math.round(net * 1.18) : net;
                                                    return (finalAmount - quote.advanceAmount!).toLocaleString('en-IN');
                                                })()}
                                            </td>
                                        </tr>
                                    </>
                                ) : (
                                    <tr>
                                        <td colSpan={7} className="border-[1.5px] border-slate-900 py-3 px-4 text-right text-[12px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Grand Total</td>
                                        <td className="border-[1.5px] border-slate-900 py-3 px-2 text-center text-[11px] font-black text-indigo-700 bg-slate-100 leading-none whitespace-nowrap">
                                            ₹{(() => {
                                                const sub = totalPrice(quote.items);
                                                const isPercentage = quote.globalDiscountType === 'percentage';
                                                const val = quote.globalDiscountValue || 0;
                                                const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                                const net = sub - discount;
                                                const finalAmount = isPercentage ? Math.round(net * 1.18) : net;
                                                return finalAmount.toLocaleString('en-IN');
                                            })()}
                                        </td>
                                    </tr>
                                )}
                            </>
                        )}

                        {isCustomerView && (
                            <tr>
                                <td colSpan={3} className="border-[1.5px] border-slate-900 py-3 px-4 text-right text-[12px] font-black text-slate-900 bg-slate-100 uppercase tracking-widest leading-none">Total Amount</td>
                                <td className="border-[1.5px] border-slate-900 py-3 px-2 text-center text-[11px] font-black text-indigo-700 bg-slate-100 leading-none whitespace-nowrap">
                                    ₹{(() => {
                                        const sub = totalPrice(quote.items);
                                        const isPercentage = quote.globalDiscountType === 'percentage';
                                        const val = quote.globalDiscountValue || 0;
                                        const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                        const net = sub - discount;
                                        const finalAmount = isPercentage ? Math.round(net * 1.18) : net;
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
                                <div className="w-21 h-24 flex-shrink-0 bg-slate-50 rounded-lg flex items-center justify-center p-4 border">
                                    <img src={i.product.image} className="w-full h-full object-contain" alt={i.product.name} />
                                </div>
                                {/* Header Info */}
                                <div className="flex-1 min-w-0">
                                    <div className="flex justify-between items-start p-4">
                                        <span className="text-[10px] bg-slate-100 text-slate-500 font-bold px-2 py-0.5 rounded uppercase tracking-wider">{i.product.modelNumber}</span>
                                        <span className="text-xs font-bold text-slate-400">#{idx + 1}</span>
                                    </div>
                                    <h4 className="font-bold text-slate-900 text-sm mt-1 leading-tight">{i.product.name}</h4>

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
                                    {!isCustomerView && <span className="font-medium text-slate-500 line-through text-[10px]">₹{i.product.price.toLocaleString('en-IN')}</span>}
                                </div>
                                <div className="flex flex-col items-end">
                                    {(() => {
                                        const isPercentage = quote.globalDiscountType === 'percentage';
                                        const gDiscount = quote.globalDiscountValue || 0;
                                        if (isPercentage && gDiscount > 0) {
                                            const discountAmount = i.product.price * gDiscount / 100;
                                            const discountedPrice = i.product.price - discountAmount;
                                            return (
                                                <span className="font-black text-indigo-700 text-base">₹{Math.round(discountedPrice * i.quantity).toLocaleString('en-IN')}</span>
                                            );
                                        }
                                        return (
                                            <span className="font-black text-indigo-700 text-base">₹{Math.round(i.product.price * i.quantity).toLocaleString('en-IN')}</span>
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

                            {quote.globalDiscountValue && (
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

                            {quote.globalDiscountValue && (
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
                                    {(() => {
                                        const sub = totalPrice(quote.items);
                                        const isPercentage = quote.globalDiscountType === 'percentage';
                                        const val = quote.globalDiscountValue || 0;
                                        const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                        return Math.round((sub - discount) * 0.18).toLocaleString('en-IN');
                                    })()}
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
                                            ₹{(() => {
                                                const sub = totalPrice(quote.items);
                                                const isPercentage = quote.globalDiscountType === 'percentage';
                                                const val = quote.globalDiscountValue || 0;
                                                const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                                const net = sub - discount;
                                                const finalAmount = isPercentage ? Math.round(net * 1.18) : net;
                                                return (finalAmount - quote.advanceAmount!).toLocaleString('en-IN');
                                            })()}
                                        </span>
                                    </div>
                                </>
                            ) : (
                                <div className="flex justify-between border-t border-slate-600 pt-2 text-sm">
                                    <span className="font-bold uppercase tracking-wider">Grand Total</span>
                                    <span className="font-bold text-green-400">
                                        ₹{(() => {
                                            const sub = totalPrice(quote.items);
                                            const isPercentage = quote.globalDiscountType === 'percentage';
                                            const val = quote.globalDiscountValue || 0;
                                            const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                            const net = sub - discount;
                                            const finalAmount = isPercentage ? Math.round(net * 1.18) : net;
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
                                        const sub = totalPrice(quote.items);
                                        const isPercentage = quote.globalDiscountType === 'percentage';
                                        const val = quote.globalDiscountValue || 0;
                                        const discount = isPercentage ? Math.round(sub * val / 100) : val;
                                        const net = sub - discount;
                                        const finalAmount = isPercentage ? Math.round(net * 1.18) : net;
                                        return finalAmount.toLocaleString('en-IN');
                                    })()}
                                </span>
                            </div>
                        </div>
                    )}
                </div>

                <div className="mt-6 pt-4 border-t border-slate-200 print-compact print:mt-1 print:pt-1">
                    <div className="grid grid-cols-1 md:grid-cols-2 print:grid-cols-2 gap-6 print:gap-3">
                        {/* Banking Details */}
                        <div className="space-y-3 no-print-break">
                            <h4 className="text-sm font-bold text-slate-900 border-b pb-1.5 uppercase tracking-tight">Banking Details (RTGS / NEFT)</h4>
                            <div className="space-y-1.5 text-xs text-slate-600">
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

                        {/* Payment QR Code Scanner */}
                        <div className="flex flex-col items-center no-print-break">
                            <h4 className="text-sm font-bold text-slate-900 border-b pb-1.5 mb-3 uppercase tracking-tight w-full text-center">UPI Payment</h4>
                            <img
                                src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=upi://pay?pa=magnific@axisbank&pn=Magnific%20Home%20Appliances&cu=INR"
                                alt="Payment QR Code"
                                className="w-40 h-40 object-contain border-2 border-slate-200 rounded-lg p-2 bg-white"
                            />
                            <p className="text-xs font-bold text-indigo-700 mt-2 uppercase tracking-wide">Scan to Pay</p>
                        </div>
                    </div>

                    {/* Original Quote QR Code - Only show if available */}
                    {qrCodeUrl && (
                        <div className="mt-6 flex justify-center print:hidden">
                            <div className="flex flex-col items-center justify-center p-4 border rounded-xl bg-slate-50 relative group">
                                {shareUrl ? (
                                    <a href={shareUrl} target="_blank" rel="noopener noreferrer">
                                        <img src={qrCodeUrl} alt="Magnific QR" className="w-24 h-24 mb-2 hover:scale-105 transition-transform cursor-pointer" />
                                    </a>
                                ) : (
                                    <img src={qrCodeUrl} alt="Magnific QR" className="w-24 h-24 mb-2" />
                                )}
                                <p className="text-[9px] uppercase font-bold text-slate-400 tracking-widest">View Quote Online</p>
                            </div>
                        </div>
                    )}

                    {/* Terms & Conditions */}
                    <div className="mt-6 pt-4 border-t border-slate-100 no-print-break print:mt-1 print:pt-1">
                        <h4 className="text-xs font-bold text-slate-900 mb-3 uppercase tracking-tight">Terms & Conditions:</h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 print:grid-cols-2 gap-x-4 gap-y-1 print:gap-x-4 print:gap-y-0.5">
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
