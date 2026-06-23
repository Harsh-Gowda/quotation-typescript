import React from 'react';
import { Quotation, Customer } from '../types';
import { BackIcon, SaveIcon, ExcelIcon, CheckIcon } from './Icons';
import QuotationSheet from './QuotationSheet';
import { useNavigate } from 'react-router-dom';

interface QuotationPreviewProps {
    finalQuote: Quotation;
    subtotal: number;
    isSaved: boolean;
    isSaving?: boolean;
    onSave: () => void;
    onExportExcel: () => void;
    onEdit: () => void;
    onUpdateCustomer?: (updates: Partial<Customer & { advanceAmount?: number; advanceDate?: string }>) => void;
    onUpdateItemQuantity?: (index: number, quantity: number) => void;
    onUpdateItemPlace?: (index: number, placeName: string) => void;
    onUpdateItemSetting?: (index: number, key: 'showLineart' | 'includeGst' | 'includeDiscount', value: boolean) => void;
    onNewQuote: () => void;
    isPublicMode: boolean;
    isCustomerView: boolean;
    viewOnly?: boolean;
}

export default function QuotationPreview({
    finalQuote, subtotal, isSaved, isSaving, onSave, onExportExcel, onEdit, onUpdateCustomer, onUpdateItemQuantity, onUpdateItemPlace, onUpdateItemSetting, onNewQuote,
    isPublicMode, isCustomerView, viewOnly
}: QuotationPreviewProps) {
    const navigate = useNavigate();

    React.useEffect(() => {
        const originalTitle = document.title;
        if (finalQuote) {
            const cName = finalQuote.customer.name.replace(/\s+/g, '_');
            const phone = finalQuote.customer.phone.replace(/\s+/g, '_');
            document.title = `${cName}_${phone}_${finalQuote.id}`;
        }
        return () => {
            document.title = originalTitle;
        };
    }, [finalQuote]);

    return (
        <div className="max-w-[210mm] mx-auto print:max-w-none print:mx-0">
            {/* Action Toolbar */}
            {!isPublicMode && (
                <div className="mb-6 print:hidden">
                    {viewOnly ? (
                        /* VIEW-ONLY MODE */
                        <div className="flex justify-between items-center bg-white px-5 py-3 rounded-2xl shadow-md border border-slate-100">
                            <button onClick={() => navigate('/saved')} className="flex items-center gap-2 text-slate-500 hover:text-indigo-600 text-sm font-semibold transition-colors group">
                                <span className="w-8 h-8 rounded-xl bg-slate-100 group-hover:bg-indigo-50 flex items-center justify-center transition-colors">
                                    <BackIcon />
                                </span>
                                Back to Archive
                            </button>
                            <button onClick={() => {
                                const el = document.querySelector('.bg-white.shadow-xl') as HTMLElement;
                                if (!el) return;
                                const cName = finalQuote.customer.name.replace(/\s+/g, '_');
                                const phone = finalQuote.customer.phone.replace(/\s+/g, '_');
                                const filename = `${cName}_${phone}_${finalQuote.id}.pdf`;
                                const opt = {
                                    margin: [0, 0, 0, 0],
                                    filename,
                                    image: { type: 'jpeg', quality: 0.98 },
                                    html2canvas: { scale: 2, useCORS: true, logging: false },
                                    jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' },
                                    pagebreak: { mode: ['css'], before: '.pdf-page-break-before', avoid: ['tr', 'td'] }
                                };
                                (window as any).html2pdf().set(opt).from(el).save();
                            }} className="flex items-center gap-2 bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-700 hover:to-violet-700 text-white px-5 py-2.5 rounded-xl font-bold text-sm transition-all shadow-md hover:shadow-lg hover:-translate-y-0.5 active:translate-y-0">
                                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>
                                Download PDF
                            </button>
                        </div>
                    ) : (
                        /* FULL EDIT MODE */
                        <div className="flex items-center justify-between gap-3 bg-white px-5 py-3 rounded-2xl shadow-md border border-slate-100">
                            {/* Left: Back */}
                            <button onClick={() => navigate('/catalog')} className="flex items-center gap-2 text-slate-500 hover:text-indigo-600 text-sm font-semibold transition-colors group shrink-0">
                                <span className="w-8 h-8 rounded-xl bg-slate-100 group-hover:bg-indigo-50 flex items-center justify-center transition-colors">
                                    <BackIcon />
                                </span>
                                <span className="hidden sm:inline">Edit Data</span>
                            </button>

                            {/* Center: Advance Payment */}
                            <div className="flex items-center gap-2 bg-slate-50 border border-slate-200 rounded-xl px-4 py-2 shadow-inner flex-1 min-w-0 max-w-xs">
                                <div className="flex flex-col min-w-0 w-full">
                                    <span className="text-[8px] font-black text-slate-400 uppercase tracking-widest leading-none mb-1.5">Advance Payment</span>
                                    <div className="flex items-center gap-2">
                                        <div className="flex items-center">
                                            <span className="text-slate-400 text-xs mr-0.5 shrink-0">₹</span>
                                            <input
                                                type="number"
                                                value={finalQuote.advanceAmount || ''}
                                                onChange={(e) => onUpdateCustomer?.({ advanceAmount: Number(e.target.value) })}
                                                className="w-20 bg-transparent border-none outline-none text-sm font-bold text-indigo-600 p-0 focus:ring-0"
                                                placeholder="0"
                                            />
                                        </div>
                                        <div className="w-px h-5 bg-slate-300 shrink-0"></div>
                                        <input
                                            type="date"
                                            value={finalQuote.advanceDate || ''}
                                            onChange={(e) => onUpdateCustomer?.({ advanceDate: e.target.value })}
                                            className="w-[115px] bg-transparent border-none outline-none text-sm font-bold text-indigo-600 p-0 focus:ring-0"
                                        />
                                    </div>
                                </div>
                            </div>

                            {/* Right: Action Buttons */}
                            <div className="flex items-center gap-2 shrink-0">
                                {/* Save */}
                                <button
                                    onClick={onSave}
                                    disabled={isSaved || isSaving}
                                    className={`flex items-center gap-1.5 px-4 py-2.5 rounded-xl font-bold text-sm transition-all shadow-sm border
                                        ${isSaved
                                            ? 'bg-emerald-50 text-emerald-600 border-emerald-200'
                                            : isSaving
                                                ? 'bg-indigo-50 text-indigo-400 border-indigo-200 cursor-wait'
                                                : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50 hover:border-slate-300'
                                        }`}
                                >
                                    {isSaving ? (
                                        <>
                                            <svg className="animate-spin h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
                                            </svg>
                                            Saving...
                                        </>
                                    ) : isSaved ? (
                                        <><CheckIcon /> Saved</>
                                    ) : (
                                        <><SaveIcon /> Save Quote</>
                                    )}
                                </button>

                                {/* Download PDF */}
                                <button onClick={() => {
                                    const el = document.querySelector('.bg-white.shadow-xl') as HTMLElement;
                                    if (!el) return;
                                    const cName = finalQuote.customer.name.replace(/\s+/g, '_');
                                    const phone = finalQuote.customer.phone.replace(/\s+/g, '_');
                                    const filename = `${cName}_${phone}_${finalQuote.id}.pdf`;
                                    const opt = {
                                        margin: [0, 0, 0, 0],
                                        filename,
                                        image: { type: 'jpeg', quality: 0.98 },
                                        html2canvas: { scale: 2, useCORS: true, logging: false },
                                        jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' },
                                        pagebreak: { mode: ['css'], before: '.pdf-page-break-before', avoid: ['tr', 'td'] }
                                    };
                                    (window as any).html2pdf().set(opt).from(el).save();
                                }} className="flex items-center gap-2 bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-700 hover:to-violet-700 text-white px-5 py-2.5 rounded-xl font-bold text-sm transition-all shadow-md hover:shadow-lg hover:-translate-y-0.5 active:translate-y-0">
                                    <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>
                                    Download PDF
                                </button>

                                {/* New Quote */}
                                <button
                                    onClick={() => { onNewQuote(); navigate('/'); }}
                                    className="flex items-center gap-2 bg-slate-800 hover:bg-slate-900 text-white px-4 py-2.5 rounded-xl font-bold text-sm transition-all shadow-md hover:shadow-lg hover:-translate-y-0.5 active:translate-y-0"
                                >
                                    <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg>
                                    New Quote
                                </button>
                            </div>
                        </div>
                    )}
                </div>
            )}

            {/* Printable Sheet */}
            <div className="bg-white shadow-xl print:shadow-none print:m-0 overflow-visible print:overflow-visible w-full">
                <QuotationSheet
                    quote={finalQuote}
                    subtotal={subtotal}
                    isCustomerView={isCustomerView}
                    isEditable={!isPublicMode && !viewOnly}
                    onUpdateCustomer={viewOnly ? undefined : onUpdateCustomer}
                    onUpdateItemQuantity={viewOnly ? undefined : onUpdateItemQuantity}
                    onUpdateItemPlace={viewOnly ? undefined : onUpdateItemPlace}
                    onUpdateItemSetting={viewOnly ? undefined : onUpdateItemSetting}
                />
            </div>
        </div>
    );
}
