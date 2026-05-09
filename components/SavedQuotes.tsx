import React from 'react';
import { Quotation } from '../types';
import { BackIcon } from './Icons';
import { useNavigate } from 'react-router-dom';

interface SavedQuotesProps {
    savedQuotes: Quotation[];
    onLoad: (q: Quotation) => void;
    onEdit: (q: Quotation) => void;
    onDelete: (e: React.MouseEvent, id: string) => void;
}

export default function SavedQuotes({ savedQuotes, onLoad, onEdit, onDelete }: SavedQuotesProps) {
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
                        <div key={q.id} className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm hover:border-indigo-400 transition-all group">
                            <div className="flex justify-between items-start mb-2">
                                <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-widest">{q.id}</span>
                                <button onClick={(e) => onDelete(e, q.id)} className="text-slate-300 hover:text-red-500 opacity-0 group-hover:opacity-100 transition-opacity p-1"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg></button>
                            </div>
                            <h4 className="font-bold text-slate-600 text-lg">{q.customer.name}</h4>
                            <p className="text-xs text-slate-400 font-medium mb-3">{q.date}</p>
                            <div className="flex justify-between items-center pt-3 border-t mb-3">
                                <span className="text-slate-500 text-xs">Items: {q.items.length}</span>
                                <span className="font-bold text-indigo-700">₹{q.items.reduce((s, i) => s + (i.product.price * i.quantity), 0).toLocaleString('en-IN')}</span>
                            </div>
                            <div className="flex space-x-2">
                                <button
                                    onClick={() => onEdit(q)}
                                    className="flex-1 bg-amber-500 hover:bg-amber-600 text-white px-3 py-2 rounded-lg font-bold text-xs transition-all flex items-center justify-center"
                                >
                                    <svg className="w-3.5 h-3.5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                    </svg>
                                    Edit
                                </button>
                                <button
                                    onClick={() => onLoad(q)}
                                    className="flex-1 bg-indigo-600 hover:bg-indigo-700 text-white px-3 py-2 rounded-lg font-bold text-xs transition-all flex items-center justify-center"
                                >
                                    <svg className="w-3.5 h-3.5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                    </svg>
                                    View
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );

}
