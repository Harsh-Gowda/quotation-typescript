
import React from 'react';
import { QuoteItem } from '../types';
import { EditIcon } from './Icons';

interface CartItemProps {
    key?: any;
    item: QuoteItem;
    onRemove: () => void;
    onQtyChange: (q: number) => void;
    onEdit: () => void;
}

export default function CartItem({ item, onRemove, onQtyChange, onEdit }: CartItemProps) {
    return (
        <div className="flex flex-col p-3 bg-slate-50 rounded-xl group border border-slate-100 space-y-2">
            <div className="flex items-center space-x-3">
                <img src={item.product.image} className="w-12 h-12 rounded-lg object-cover bg-white border shadow-sm" />
                <div className="flex-1 min-w-0">
                    <p className="text-xs font-bold text-slate-800 truncate leading-tight">{item.product.name}</p>
                    <div className="flex items-center space-x-2 mt-0.5">
                        {item.size && <span className="text-[9px] bg-slate-200 text-slate-600 px-1.5 py-0.5 rounded font-bold">{item.size}</span>}
                        {item.color && <span className="text-[9px] bg-slate-200 text-slate-600 px-1.5 py-0.5 rounded font-bold">{item.color}</span>}
                    </div>
                    <p className="text-[10px] text-indigo-600 font-bold mt-1">₹{(item.customPrice !== undefined ? item.customPrice : item.product.price).toLocaleString('en-IN')}</p>
                </div>
                <div className="flex flex-col space-y-1 opacity-100 lg:opacity-0 group-hover:opacity-100 transition-opacity">
                    <button onClick={onEdit} className="text-slate-300 hover:text-indigo-600 p-1" title="Edit Item">
                        <EditIcon />
                    </button>
                    <button onClick={onRemove} className="text-slate-300 hover:text-red-500 p-1" title="Remove Item">
                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
                    </button>
                </div>
            </div>
            <div className="flex justify-between items-center pt-1 border-t border-slate-200">
                <span className="text-[10px] text-slate-500 font-bold italic truncate flex-1 mr-2">{item.placeName || "Unspecified Area"}</span>
                <div className="flex items-center bg-white border rounded shadow-sm overflow-hidden flex-shrink-0">
                    <button onClick={() => onQtyChange(item.quantity - 1)} className="px-2 py-0.5 hover:bg-slate-50 text-slate-500 font-bold">-</button>
                    <span className="px-1 text-[10px] font-bold w-5 text-center">{item.quantity}</span>
                    <button onClick={() => onQtyChange(item.quantity + 1)} className="px-2 py-0.5 hover:bg-slate-50 text-slate-500 font-bold">+</button>
                </div>
            </div>
        </div>
    );
}
