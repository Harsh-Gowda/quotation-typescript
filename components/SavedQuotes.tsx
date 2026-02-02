import React from 'react';
import { Quotation } from '../types';
import { BackIcon } from './Icons';
import { useNavigate } from 'react-router-dom';

interface SavedQuotesProps {
    savedQuotes: Quotation[];
    onLoad: (q: Quotation) => void;
    onDelete: (e: React.MouseEvent, id: string) => void;
}

export default function SavedQuotes({ savedQuotes, onLoad, onDelete }: SavedQuotesProps) {
    const navigate = useNavigate();
    return (
        <div className="max-w-4xl mx-auto">
            <div className="flex justify-between items-center mb-8">
                <h2 className="text-3xl font-bold text-slate-800">Quote Archive</h2>
                <button onClick={() => navigate('/')} className="bg-white border text-slate-700 px-4 py-2 rounded-lg font-bold text-sm shadow-sm hover:bg-slate-50 flex items-center">
                    <BackIcon /> <span className="ml-1">Home</span>
                </button>
            </div>
            {savedQuotes.length === 0 ? (
                <div className="bg-white rounded-xl p-16 text-center shadow-sm border border-slate-200">
                    <p className="text-slate-400 font-medium italic">No quotations found in local history.</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    {savedQuotes.map(q => (
                        <div key={q.id} onClick={() => onLoad(q)} className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm hover:border-indigo-400 cursor-pointer transition-all group">
                            <div className="flex justify-between items-start mb-2">
                                <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-widest">{q.id}</span>
                                <button onClick={(e) => onDelete(e, q.id)} className="text-slate-300 hover:text-red-500 opacity-0 group-hover:opacity-100 transition-opacity p-1"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg></button>
                            </div>
                            <h4 className="font-bold text-slate-800 text-lg">{q.customer.name}</h4>
                            <p className="text-xs text-slate-400 font-medium mb-3">{q.date}</p>
                            <div className="flex justify-between items-center pt-3 border-t">
                                <span className="text-slate-500 text-xs">Items: {q.items.length}</span>
                                <span className="font-bold text-indigo-700">₹{q.items.reduce((s, i) => s + (i.product.price * i.quantity), 0).toLocaleString('en-IN')}</span>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );

}
