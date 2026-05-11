
import React, { useState, useRef } from 'react';
import { Product } from '../types';
import { BackIcon, EditIcon, CartIcon } from './Icons';
import { supabase } from '../services/supabase';

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
        customImage?: string,
        isCustom?: boolean,
        quantity?: number
    }) => void;
    initialValues?: any;
    /** Called after a permanent image URL has been saved to Supabase so the parent can refresh its product list */
    onImageSaved?: (productId: string, newImageUrl: string) => void;
}

    export default function ProductModal({ product, onClose, onAdd, initialValues, onImageSaved }: ProductModalProps) {
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
        // customImage stores either a local blob URL (during upload) or the final Supabase public URL
        const [customImage, setCustomImage] = useState<string>(initialValues?.customImage || product.image || '');
        const [isUploading, setIsUploading] = useState(false);
        const [uploadError, setUploadError] = useState('');
        const [uploadSuccess, setUploadSuccess] = useState(false);
        const fileInputRef = useRef<HTMLInputElement>(null);

        const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
            const file = e.target.files?.[0];
            if (!file) return;

            // Show local preview immediately
            const localUrl = URL.createObjectURL(file);
            setCustomImage(localUrl);
            setIsUploading(true);
            setUploadError('');
            setUploadSuccess(false);

            try {
                // 1. Upload file to Supabase Storage
                const ext = file.name.split('.').pop() || 'jpg';
                const storagePath = `products/${product.id}.${ext}`;

                const { error: uploadErr } = await supabase.storage
                    .from('product-images')
                    .upload(storagePath, file, { upsert: true, contentType: file.type });

                if (uploadErr) throw new Error(uploadErr.message);

                // 2. Get the public URL
                const { data: urlData } = supabase.storage
                    .from('product-images')
                    .getPublicUrl(storagePath);

                const publicUrl = urlData.publicUrl;

                // 3. Update product_variants attributes.media.primaryImage in DB
                // First fetch existing attributes
                const { data: variantData, error: fetchErr } = await supabase
                    .from('product_variants')
                    .select('attributes')
                    .eq('variantId', product.id)
                    .single();

                if (!fetchErr && variantData) {
                    const existingAttrs = variantData.attributes || {};
                    const updatedAttrs = {
                        ...existingAttrs,
                        media: {
                            ...(existingAttrs.media || {}),
                            primaryImage: publicUrl,
                            images: [publicUrl, ...(existingAttrs.media?.images || []).filter((img: string) => img !== publicUrl)]
                        }
                    };

                    await supabase
                        .from('product_variants')
                        .update({ attributes: updatedAttrs })
                        .eq('variantId', product.id);
                }

                // 4. Swap local blob URL for permanent public URL
                setCustomImage(publicUrl);
                setUploadSuccess(true);
                // Notify parent to refresh product list
                onImageSaved?.(product.id, publicUrl);

            } catch (err: any) {
                setUploadError(err.message || 'Upload failed');
                // Keep local preview so user can still add to quote
            } finally {
                setIsUploading(false);
            }
        };

        const displayImage = customImage || product.image;
        const isMissingImage = !product.image && !customImage;

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
            if (customImage) {
                addOptions.customImage = customImage;
            }
            onAdd(addOptions);
        };

        return (
            <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
                <div className="bg-white rounded-2xl shadow-2xl w-full max-w-4xl overflow-hidden flex flex-col md:flex-row animate-in zoom-in-95 duration-200">
                    {/* Left Side: Images */}
                    <div className="md:w-1/2 bg-slate-100 flex flex-col">
                        <div className="relative flex-1 min-h-[300px]">
                            {displayImage ? (
                                <img src={displayImage} alt={product.name} className="absolute inset-0 w-full h-full object-cover" />
                            ) : (
                                <div className="absolute inset-0 flex flex-col items-center justify-center bg-slate-100 text-slate-400">
                                    <svg className="w-16 h-16 mb-2 text-slate-300" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                    <span className="text-xs font-bold text-slate-400">No Image Available</span>
                                </div>
                            )}
                            <button onClick={onClose} className="absolute top-4 left-4 md:hidden bg-white/80 p-2 rounded-full shadow-md text-slate-800">
                                <BackIcon />
                            </button>
                            {/* Upload / Change Image Button */}
                            <button
                                type="button"
                                onClick={() => !isUploading && fileInputRef.current?.click()}
                                disabled={isUploading}
                                className={`absolute bottom-3 right-3 flex items-center space-x-1.5 px-3 py-2 rounded-xl text-xs font-bold shadow-lg transition-all disabled:cursor-not-allowed ${
                                    isUploading
                                        ? 'bg-indigo-500 text-white'
                                        : isMissingImage
                                        ? 'bg-amber-500 hover:bg-amber-600 text-white animate-pulse'
                                        : 'bg-white/90 hover:bg-white text-slate-700 border border-slate-200'
                                }`}
                                title={isMissingImage ? 'This product has no image — upload one' : 'Change product image (saves to database)'}
                            >
                                {isUploading ? (
                                    <>
                                        <svg className="w-3.5 h-3.5 animate-spin" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"/><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/></svg>
                                        <span>Saving...</span>
                                    </>
                                ) : (
                                    <>
                                        <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12" /></svg>
                                        <span>{isMissingImage ? 'Upload Image' : 'Change Image'}</span>
                                    </>
                                )}
                            </button>
                            <input
                                ref={fileInputRef}
                                type="file"
                                accept="image/*"
                                className="hidden"
                                onChange={handleImageUpload}
                            />
                        </div>
                        {/* Status bar below image */}
                        {uploadError && (
                            <div className="px-3 py-2 bg-red-50 border-t border-red-100 flex items-center space-x-2">
                                <svg className="w-3.5 h-3.5 text-red-500 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                                <span className="text-[10px] font-bold text-red-700 flex-1">Upload failed: {uploadError}</span>
                                <span className="text-[10px] text-slate-500">(image kept locally for this quote)</span>
                            </div>
                        )}
                        {uploadSuccess && (
                            <div className="px-3 py-2 bg-green-50 border-t border-green-100 flex items-center space-x-2">
                                <svg className="w-3.5 h-3.5 text-green-600 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" /></svg>
                                <span className="text-[10px] font-bold text-green-700">✓ Image saved to database permanently!</span>
                            </div>
                        )}
                        {isUploading && (
                            <div className="px-3 py-2 bg-indigo-50 border-t border-indigo-100 flex items-center space-x-2">
                                <svg className="w-3.5 h-3.5 animate-spin text-indigo-500 flex-shrink-0" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"/><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/></svg>
                                <span className="text-[10px] font-bold text-indigo-700">Uploading & saving to database...</span>
                            </div>
                        )}
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
