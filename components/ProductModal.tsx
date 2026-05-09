
import React, { useState } from 'react';
import { Product } from '../types';
import { BackIcon, EditIcon, CartIcon } from './Icons';

interface ProductModalProps {
    product: Product;
    onClose: () => void;
    onAdd: (options: { 
        placeName?: string, 
        size?: string, 
        color?: string, 
        lamp?: string, 
        discount?: number, 
        customDescription?: string, 
        extraNote?: string,
        customPrice?: number,
        customName?: string,
        customModelNumber?: string,
        isCustom?: boolean,
        quantity?: number
    }) => void;
    initialValues?: any;
}

    export default function ProductModal({ product, onClose, onAdd, initialValues }: ProductModalProps) {
        const isCustom = product.id === 'custom-item' || product.id === 'fan-installation' || initialValues?.isCustom;
        const [name, setName] = useState(initialValues?.customName || product.name);
        const [modelNumber, setModelNumber] = useState(initialValues?.customModelNumber || product.modelNumber);
        const [place, setPlace] = useState(initialValues?.placeName || '');
        const defaultDescription = initialValues?.customDescription || product.description || [
            product.size && `Size: ${product.size}`,
            product.lamp && `Lamp: ${product.lamp}`,
            product.finishing && `Finish: ${product.finishing}`,
            product.bodyColor && `Color: ${product.bodyColor}`,
            product.bladeType && `Blade Type: ${product.bladeType}`,
            product.sweep && `Sweep: ${product.sweep}`,
            product.heightOfFan && `Height: ${product.heightOfFan}`,
            product.motorSpec && `Motor: ${product.motorSpec}`,
            product.airflow && `Airflow: ${product.airflow}`,
            product.suitableFor && `Suitable For: ${product.suitableFor}`,
            product.lightOption && `Light: ${product.lightOption}`
        ].filter(Boolean).join('\n');

        const [description, setDescription] = useState(defaultDescription);
        const [extraNote, setExtraNote] = useState(initialValues?.extraNote || '');
        const [customPrice, setCustomPrice] = useState<string>(initialValues?.customPrice !== undefined ? String(initialValues.customPrice) : '');
        const [quantity, setQuantity] = useState<number>(initialValues?.quantity || 1);

        const activeImg = product.image;
        const gallery = [product.image, ...(product.gallery || [])];

        const handleAdd = () => {
            const addOptions: any = {
                placeName: place,
                customDescription: description,
                extraNote: extraNote,
                isCustom: isCustom,
                quantity: quantity
            };
            if (isCustom) {
                addOptions.customName = name;
                addOptions.customModelNumber = modelNumber;
            }
            if ((product.category === 'Services' || isCustom) && customPrice !== '') {
                addOptions.customPrice = Number(customPrice);
            }
            onAdd(addOptions);
        };

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
                   </div>

                    {/* Right Side: Configuration */}
                    <div className="md:w-1/2 p-8 flex flex-col">
                        <div className="flex justify-between items-start mb-6">
                            <div>
                                <div className="flex items-center space-x-2">
                                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">{isCustom ? 'Custom Item' : product.category}</span>
                                    {!isCustom && <span className="text-[10px] bg-slate-100 text-slate-500 px-2 py-0.5 rounded font-mono font-bold">{product.modelNumber}</span>}
                                </div>
                                {isCustom ? (
                                    <input 
                                        type="text"
                                        className="text-2xl font-bold text-slate-900 mt-1 border-b border-dashed border-slate-300 outline-none focus:border-indigo-500 w-full"
                                        value={name}
                                        onChange={e => setName(e.target.value)}
                                        placeholder="Item Name..."
                                    />
                                ) : (
                                    <h2 className="text-2xl font-bold text-slate-900 mt-1">{product.name}</h2>
                                )}
                            </div>
                            <button onClick={onClose} className="hidden md:block text-slate-400 hover:text-slate-600 transition-colors">
                                <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                            </button>
                        </div>

                        <div className="space-y-5 flex-1 overflow-y-auto no-scrollbar pr-1">
                            {isCustom && (
                                <div className="space-y-1.5">
                                    <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Model / Reference Number</label>
                                    <input
                                        type="text"
                                        className="w-full p-3 border border-slate-200 rounded-xl bg-white text-slate-700 font-medium text-sm outline-none focus:ring-2 focus:ring-indigo-500 transition-all"
                                        value={modelNumber}
                                        onChange={e => setModelNumber(e.target.value)}
                                        placeholder="Ex: GEN-001..."
                                    />
                                </div>
                            )}

                            {product.id !== 'fan-installation' && (
                                <div className="space-y-1.5">
                                    <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">{isCustom ? 'Description' : 'Technical Details / Description'}</label>
                                    <textarea
                                        rows={3}
                                        className="w-full p-3 border border-slate-200 rounded-xl bg-slate-50 text-slate-700 font-medium text-sm whitespace-pre-wrap outline-none resize-none focus:ring-2 focus:ring-indigo-500 transition-all"
                                        value={description}
                                        onChange={e => setDescription(e.target.value)}
                                        placeholder="Add details for this custom item..."
                                    />
                                </div>
                            )}

                            {/* Price Override for Services or Custom Items */}
                            {(product.category === 'Services' || isCustom) && (
                                <div className="space-y-1.5">
                                    <label className="text-[10px] font-bold text-green-600 uppercase tracking-wider">{isCustom ? 'Item Price (₹)' : 'Service Charge (₹)'}</label>
                                    <div className="flex items-center space-x-2 bg-white px-3 py-2 border border-green-200 rounded-xl focus-within:ring-2 ring-green-500/20 ring-offset-1">
                                         <span className="text-slate-400 font-bold">₹</span>
                                         <input
                                             type="number"
                                             className="w-full bg-transparent outline-none font-bold text-slate-900 placeholder-slate-300"
                                             placeholder="Enter amount..."
                                             value={customPrice}
                                             onChange={(e) => setCustomPrice(e.target.value)}
                                         />
                                     </div>
                                </div>
                            )}

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold text-blue-600 uppercase tracking-wider">Extra Note (Blue Highlight)</label>
                                <textarea
                                    rows={2}
                                    placeholder="Add a highlighted note for this item..."
                                    className="w-full p-3 border border-slate-200 rounded-xl outline-none font-medium text-sm transition-all resize-none leading-relaxed text-blue-700 bg-white"
                                    value={extraNote}
                                    onChange={e => setExtraNote(e.target.value)}
                                />
                            </div>

                            {product.category !== 'Services' && !isCustom && (
                                <div className="space-y-1.5">
                                    <label className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Installation Room / Place</label>
                                    <input
                                        type="text"
                                        placeholder="Ex: Master Bedroom, Living Area..."
                                        className="w-full p-3 border border-slate-200 outline-none rounded-xl font-medium text-sm transition-all"
                                        value={place}
                                        onChange={e => setPlace(e.target.value)}
                                    />
                                </div>
                            )}
                            
                            <div className="space-y-1.5 mt-4 pt-4 border-t">
                                <label className="text-[10px] font-bold text-indigo-600 uppercase tracking-wider">Quantity to Add</label>
                                <div className="flex items-center space-x-4">
                                    <button 
                                        type="button"
                                        onClick={(e) => { e.stopPropagation(); setQuantity(Math.max(1, quantity - 1)); }}
                                        className="w-10 h-10 rounded-xl border border-slate-200 flex items-center justify-center text-slate-600 hover:bg-slate-50 transition-colors"
                                    >
                                        -
                                    </button>
                                    <input 
                                        type="number" 
                                        className="w-20 text-center font-bold text-lg outline-none bg-slate-50 rounded-xl py-2"
                                        value={quantity}
                                        onChange={e => setQuantity(Math.max(1, parseInt(e.target.value) || 1))}
                                        onClick={e => e.stopPropagation()}
                                    />
                                    <button 
                                        type="button"
                                        onClick={(e) => { e.stopPropagation(); setQuantity(quantity + 1); }}
                                        className="w-10 h-10 rounded-xl border border-slate-200 flex items-center justify-center text-slate-600 hover:bg-slate-50 transition-colors"
                                    >
                                        +
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div className="pt-8 border-t mt-8 flex items-center justify-between">
                            <div className="flex flex-col">
                                <span className="text-[10px] font-bold text-slate-400 uppercase">{(product.category === 'Services' || isCustom) ? 'Charge' : 'Price per unit'}</span>
                                <span className="text-2xl font-bold text-indigo-700">₹{((product.category === 'Services' || isCustom) && customPrice !== '' ? Number(customPrice) : product.price).toLocaleString('en-IN')}</span>
                            </div>
                            <button
                                onClick={handleAdd}
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
