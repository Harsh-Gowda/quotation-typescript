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
                <div className="mb-6 flex justify-between items-center print:hidden bg-white p-4 rounded-xl shadow-sm border border-slate-200">
                    {viewOnly ? (
                        /* VIEW-ONLY MODE: Only Back + Print */
                        <>
                            <button onClick={() => navigate('/saved')} className="text-slate-500 hover:text-slate-800 flex items-center text-sm font-bold">
                                <BackIcon /> <span className="ml-1">Back to Archive</span>
                            </button>
                            <div className="flex space-x-3">
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
                                        pagebreak: { mode: ['avoid-all', 'css', 'legacy'] }
                                    };
                                    (window as any).html2pdf().set(opt).from(el).save();
                                }} className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded-lg font-bold text-sm transition-all shadow-sm">
                                    Download PDF
                                </button>
                            </div>
                        </>
                    ) : (
                        /* FULL EDIT MODE */
                        <>
                            <button onClick={() => navigate('/catalog')} className="text-slate-500 hover:text-slate-800 flex items-center text-sm font-bold">
                                <BackIcon /> <span className="ml-1">Edit Data</span>
                            </button>
                            <div className="flex space-x-3">
                                <div className="flex items-center space-x-2 bg-slate-50 px-4 py-2 rounded-lg border border-slate-200 shadow-inner">
                                    <div className="flex flex-col">
                                        <span className="text-[8px] font-black text-slate-400 uppercase tracking-widest leading-none mb-1">Advance Payment</span>
                                        <div className="flex items-center space-x-2">
                                            <div className="flex items-center">
                                                <span className="text-slate-400 text-xs mr-0.5">₹</span>
                                                <input 
                                                    type="number" 
                                                    value={finalQuote.advanceAmount || ''} 
                                                    onChange={(e) => onUpdateCustomer?.({ advanceAmount: Number(e.target.value) })}
                                                    className="w-24 bg-transparent border-none outline-none text-sm font-bold text-indigo-600 p-0 focus:ring-0"
                                                    placeholder="0"
                                                />
                                            </div>
                                            <div className="w-px h-5 bg-slate-300"></div>
                                            <input 
                                                type="date" 
                                                value={finalQuote.advanceDate || ''} 
                                                onChange={(e) => onUpdateCustomer?.({ advanceDate: e.target.value })}
                                                className="w-[125px] bg-transparent border-none outline-none text-sm font-bold text-indigo-600 p-0 focus:ring-0"
                                            />
                                        </div>
                                    </div>
                                </div>
                                <button onClick={onSave} disabled={isSaved || isSaving} className={`flex items-center px-4 py-2 rounded-lg font-bold text-sm transition-all shadow-sm ${isSaved ? 'bg-green-50 text-green-600 border border-green-200' : isSaving ? 'bg-indigo-50 text-indigo-400 border border-indigo-200 cursor-wait' : 'bg-white border border-slate-300 text-slate-700 hover:bg-slate-50'}`}>
                                    {isSaving ? (
                                        <>
                                            <svg className="animate-spin h-4 w-4 mr-1.5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
                                            </svg>
                                            Saving...
                                        </>
                                    ) : isSaved ? <><CheckIcon /> Saved</> : <><SaveIcon /> Save Quote</>}
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
                                        pagebreak: { mode: ['avoid-all', 'css', 'legacy'] }
                                    };
                                    (window as any).html2pdf().set(opt).from(el).save();
                                }} className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded-lg font-bold text-sm transition-all shadow-sm">
                                    Download PDF
                                </button>
                                <button onClick={() => { onNewQuote(); navigate('/'); }} className="bg-slate-800 hover:bg-slate-900 text-white px-4 py-2 rounded-lg font-bold text-sm transition-all shadow-sm ml-4">
                                    New Quote
                                </button>
                            </div>
                        </>
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
