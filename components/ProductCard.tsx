
import React, { useState } from 'react';
import { Product } from '../types';
import { CartIcon } from './Icons';

interface ProductCardProps {
    key?: any;
    product: Product;
    onAddClick: () => void;
    inCartQty?: number;
}

export default function ProductCard({ product, onAddClick, inCartQty = 0 }: ProductCardProps) {
    const [activeImg, setActiveImg] = useState(product.image);
    const gallery = [product.image, ...(product.gallery || [])];

    return (
        <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden flex flex-col h-full group transition-all hover:shadow-md cursor-pointer" onClick={onAddClick}>
            <div className="relative h-64 overflow-hidden bg-white p-4 flex items-center justify-center border-b">
                <img src={activeImg} alt={product.name} className="max-w-full max-h-full object-contain transition-transform duration-500 group-hover:scale-105" />
                {inCartQty > 0 && (
                    <div className="absolute top-3 left-3 bg-green-500 text-white text-[10px] font-bold h-5 min-w-[20px] px-1.5 rounded-full shadow-sm flex items-center justify-center border border-white">
                        {inCartQty}
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
