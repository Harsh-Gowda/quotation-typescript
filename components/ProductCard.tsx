
import React, { useState } from 'react';
import { Product } from '../types';
import { CartIcon } from './Icons';

interface ProductCardProps {
    key?: any;
    product: Product;
    onAddClick: () => void;
}

export default function ProductCard({ product, onAddClick }: ProductCardProps) {
    const [activeImg, setActiveImg] = useState(product.image);
    const gallery = [product.image, ...(product.gallery || [])];

    return (
        <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden flex flex-col h-full group transition-all hover:shadow-md cursor-pointer" onClick={onAddClick}>
            <div className="relative h-52 overflow-hidden bg-slate-100">
                <img src={activeImg} alt={product.name} className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" />
                <div className="absolute top-3 right-3 bg-indigo-600 text-white text-[10px] font-bold px-2 py-1 rounded shadow-sm">{product.category}</div>
            </div>
            <div className="p-2 bg-slate-50 border-b flex space-x-2 overflow-x-auto no-scrollbar" onClick={e => e.stopPropagation()}>
                {gallery.map((img, idx) => (
                    <button key={idx} onMouseEnter={() => setActiveImg(img)} onClick={() => setActiveImg(img)} className={`w-10 h-10 rounded border-2 flex-shrink-0 transition-all ${activeImg === img ? 'border-indigo-600 ring-2 ring-indigo-100' : 'border-transparent opacity-60'}`}>
                        <img src={img} className="w-full h-full object-cover rounded-[1px]" />
                    </button>
                ))}
            </div>
            <div className="p-5 flex-1 flex flex-col">
                <h3 className="font-bold text-slate-900 mb-1">{product.name}</h3>
                <p className="text-slate-500 text-xs mb-4 line-clamp-2 h-8 leading-relaxed font-medium">{product.description}</p>

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
