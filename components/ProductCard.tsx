
import React from 'react';
import { Product } from '../types';
import { CartIcon } from './Icons';

interface ProductCardProps {
    key?: any;
    product: Product;
    onAddClick: () => void;
    inCartQty?: number;
}

export default function ProductCard({ product, onAddClick, inCartQty = 0 }: ProductCardProps) {
    const hasImage = !!product.image;

    return (
        <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden flex flex-col h-full group transition-all hover:shadow-md cursor-pointer" onClick={onAddClick}>
            <div className="relative h-64 overflow-hidden bg-white p-4 flex items-center justify-center border-b">
                {hasImage ? (
                    <img src={product.image} alt={product.name} className="max-w-full max-h-full object-contain transition-transform duration-500 group-hover:scale-105" />
                ) : (
                    <div className="flex flex-col items-center justify-center w-full h-full bg-slate-50">
                        <svg className="w-14 h-14 text-slate-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                        </svg>
                        <span className="mt-2 text-xs font-bold text-slate-300 uppercase tracking-wider">No Image</span>
                    </div>
                )}
                {inCartQty > 0 && (
                    <div className="absolute top-3 left-3 bg-green-500 text-white text-[10px] font-bold h-5 min-w-[20px] px-1.5 rounded-full shadow-sm flex items-center justify-center border border-white">
                        {inCartQty}
                    </div>
                )}
                {!hasImage && (
                    <div className="absolute top-3 right-3 bg-amber-400 text-white text-[9px] font-bold px-2 py-0.5 rounded-full shadow-sm">
                        Upload Image
                    </div>
                )}
            </div>
            <div className="pt-1 px-4 pb-4 flex-1 flex flex-col">
                <h3 className="font-bold text-slate-900 mb-1 leading-tight">{product.name}</h3>
                {product.description && (
                    <p className="text-slate-500 text-xs mb-3 line-clamp-2 h-8 leading-tight font-medium">{product.description}</p>
                )}

                <div className="mt-auto">
                    <div className="flex justify-between items-center">
                        <span className="text-xl font-bold text-indigo-700">₹{product.price.toLocaleString('en-IN')}</span>
                        <div className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center transition-all active:scale-95 shadow-sm">
                            <CartIcon /> <span className="ml-2">Add</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
