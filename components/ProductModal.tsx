
import React, { useState } from 'react';
import { Product } from '../types';
import { BackIcon, EditIcon, CartIcon } from './Icons';

interface ProductModalProps {
    product: Product;
    onClose: () => void;
    onAdd: (options: { placeName?: string, size?: string, color?: string, lamp?: string, discount?: number, customDescription?: string, extraNote?: string }) => void;
    initialValues?: any;
}

export default function ProductModal({ product, onClose, onAdd, initialValues }: ProductModalProps) {
    const [place, setPlace] = useState(initialValues?.placeName || '');
    const [description, setDescription] = useState(initialValues?.customDescription || product.description);
    const [extraNote, setExtraNote] = useState(initialValues?.extraNote || '');
    const [activeImg, setActiveImg] = useState(product.image);
    const gallery = [product.image, ...(product.gallery || [])];

    return (
        <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
            <div className="bg-white rounded-2xl shadow-2xl w-full max-w-4xl overflow-hidden flex flex-col md:flex-row animate-in zoom-in-95 duration-200">
                {/* Left Side: Images */}
                <div className="md:w-1/2 bg-slate-100 flex flex-col">
                    <div className="relative flex-1 min-h-[300px]">
                        <img src={activeImg} alt={product.name} className="absolute inset-0 w-full h-full object-cover" />
                        <button onClick={onClose} className="absolute top-4 left-4 md:hidden bg-white/80 p-2 rounded-full shadow-md text-slate-800">
                            <BackIcon />
                        </button>
                    </div>
                    <div className="p-4 bg-white/50 backdrop-blur flex justify-center space-x-2 overflow-x-auto no-scrollbar border-t">
                        {gallery.map((img, idx) => (
                            <button
                                key={idx}
                                onClick={() => setActiveImg(img)}
                                className={`w-14 h-14 rounded-lg border-2 flex-shrink-0 transition-all ${activeImg === img ? 'border-indigo-600 ring-2 ring-indigo-100 shadow-sm' : 'border-transparent opacity-60'}`}
                            >
                                <img src={img} className="w-full h-full object-cover rounded-md" />
                            </button>
                        ))}
                    </div>
                </div>

                {/* Right Side: Configuration */}
                <div className="md:w-1/2 p-8 flex flex-col">
                    <div className="flex justify-between items-start mb-6">
                        <div>
                            <div className="flex items-center space-x-2">
                                <span className="text-xs font-bold text-indigo-600 uppercase tracking-widest">{product.category}</span>
                                <span className="text-[10px] bg-slate-100 text-slate-500 px-2 py-0.5 rounded font-mono font-bold">{product.modelNumber}</span>
                            </div>
                            <h2 className="text-2xl font-bold text-slate-900 mt-1">{product.name}</h2>
                        </div>
                        <button onClick={onClose} className="hidden md:block text-slate-400 hover:text-slate-600 transition-colors">
                            <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                        </button>
                    </div>

                    <div className="space-y-5 flex-1 overflow-y-auto no-scrollbar pr-1">
                        <div className="space-y-1.5">
                            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Technical Details</label>
                            <div className="w-full p-3 border border-slate-200 rounded-xl bg-slate-50 text-slate-700 font-medium text-sm whitespace-pre-wrap">
                                {description}
                            </div>
                        </div>

                        <div className="space-y-1.5">
                            <label className="text-[10px] font-bold text-blue-600 uppercase tracking-wider">Extra Note (Blue Highlight)</label>
                            <textarea
                                rows={2}
                                placeholder="Add a highlighted note for this item..."
                                className="w-full p-3 border border-black-100 rounded-xl outline-none 0 font-medium text-sm transition-all resize-none leading-relaxed text-blue-700"
                                value={extraNote}
                                onChange={e => setExtraNote(e.target.value)}
                            />
                        </div>

                        <div className="space-y-1.5">
                            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Installation Room / Place</label>
                            <input
                                type="text"
                                placeholder="Ex: Master Bedroom, Living Area..."
                                className="w-full p-3 border border-black-10 outline-none rounded-xl  font-medium text-sm transition-all"
                                value={place}
                                onChange={e => setPlace(e.target.value)}
                            />
                        </div>
                    </div>

                    <div className="pt-8 border-t mt-8 flex items-center justify-between">
                        <div className="flex flex-col">
                            <span className="text-[10px] font-bold text-slate-400 uppercase">Price per unit</span>
                            <span className="text-2xl font-bold text-indigo-700">₹{product.price.toLocaleString('en-IN')}</span>
                        </div>
                        <button
                            onClick={() => onAdd({ placeName: place, customDescription: description, extraNote: extraNote })}
                            className="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3.5 rounded-xl font-bold transition-all shadow-lg active:scale-95 flex items-center"
                        >
                            {initialValues ? <EditIcon /> : <CartIcon />} <span className="ml-2">{initialValues ? 'Update Item' : 'Add to Quotation'}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
