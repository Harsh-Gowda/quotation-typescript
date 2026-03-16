import React from 'react';
import { Quotation, Customer } from '../types';
import { BackIcon, SaveIcon, ExcelIcon, CheckIcon } from './Icons';
import QuotationSheet from './QuotationSheet';
import { useNavigate } from 'react-router-dom';

interface QuotationPreviewProps {
    finalQuote: Quotation;
    subtotal: number;
    isSaved: boolean;
    onSave: () => void;
    onExportExcel: () => void;
    onEdit: () => void;
    onUpdateCustomer?: (updates: Partial<Customer>) => void;
    onUpdateItemQuantity?: (index: number, quantity: number) => void;
    onUpdateItemPlace?: (index: number, placeName: string) => void;
    onNewQuote: () => void;
    isPublicMode: boolean;
    isCustomerView: boolean;
}

export default function QuotationPreview({
    finalQuote, subtotal, isSaved, onSave, onExportExcel, onEdit, onUpdateCustomer, onUpdateItemQuantity, onUpdateItemPlace, onNewQuote,
    isPublicMode, isCustomerView
}: QuotationPreviewProps) {
    const navigate = useNavigate();

    return (
        <div className="max-w-[210mm] mx-auto print:max-w-none print:mx-0">
            {/* Action Toolbar */}
            {!isPublicMode && (
                <div className="mb-6 flex justify-between items-center print:hidden bg-white p-4 rounded-xl shadow-sm border border-slate-200">
                    <button onClick={() => navigate('/catalog')} className="text-slate-500 hover:text-slate-800 flex items-center text-sm font-bold">
                        <BackIcon /> <span className="ml-1">Edit Data</span>
                    </button>
                    <div className="flex space-x-3">
                        <button onClick={onSave} disabled={isSaved} className={`flex items-center px-4 py-2 rounded-lg font-bold text-sm transition-all shadow-sm ${isSaved ? 'bg-green-50 text-green-600 border border-green-200' : 'bg-white border border-slate-300 text-slate-700 hover:bg-slate-50'}`}>
                            {isSaved ? <CheckIcon /> : <SaveIcon />} {isSaved ? 'Saved' : 'Save Quote'}
                        </button>
                        <button onClick={onExportExcel} className="flex items-center bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-bold text-sm transition-all shadow-sm">
                            <ExcelIcon /> Export Excel
                        </button>
                        <button onClick={() => window.print()} className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded-lg font-bold text-sm transition-all shadow-sm">
                            Print PDF
                        </button>
                        <button onClick={() => { onNewQuote(); navigate('/'); }} className="bg-slate-800 hover:bg-slate-900 text-white px-4 py-2 rounded-lg font-bold text-sm transition-all shadow-sm ml-4">
                            New Quote
                        </button>
                    </div>
                </div>
            )}

            {/* Printable Sheet */}
            <div className="bg-white shadow-xl print:shadow-none print:m-0 overflow-hidden print:overflow-visible w-full">
                <QuotationSheet
                    quote={finalQuote}
                    subtotal={subtotal}
                    isCustomerView={isCustomerView}
                    isEditable={!isPublicMode}
                    onUpdateCustomer={onUpdateCustomer}
                    onUpdateItemQuantity={onUpdateItemQuantity}
                    onUpdateItemPlace={onUpdateItemPlace}
                />
            </div>
        </div>
    );
}
