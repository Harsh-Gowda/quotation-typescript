import React from 'react';
import { Customer } from '../types';
import { UserIcon } from './Icons';
import { useNavigate } from 'react-router-dom';

interface CustomerEntryProps {
    customer: Customer & { advanceAmount?: number; advanceDate?: string };
    setCustomer: (c: Customer & { advanceAmount?: number; advanceDate?: string }) => void;
}

export default function CustomerEntry({ customer, setCustomer }: CustomerEntryProps) {
    const navigate = useNavigate();
    return (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div className="lg:col-span-2 space-y-6">
                <div className="flex justify-between items-center">
                    <h2 className="text-2xl font-bold text-slate-800 flex items-center">
                        <UserIcon /> <span className="ml-2">Visitor Information</span>
                    </h2>
                    <button
                        onClick={() => {
                            setCustomer({ name: '', email: '', phone: '', address: '', company: '', advanceAmount: 0, advanceDate: '' });
                            navigate('/');
                        }}
                        className="bg-indigo-600 hover:bg-indigo-700 text-white px-5 py-2.5 rounded-xl font-bold text-sm transition-all shadow-md active:scale-95 flex items-center space-x-2"
                    >
                        <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg>
                        <span>New Quote</span>
                    </button>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-8">
                    <form onSubmit={(e) => { e.preventDefault(); navigate('/catalog'); }} className="space-y-6">
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <div className="space-y-2">
                                <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Full Name</label>
                                <input required type="text" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Ex: name" value={customer.name} onChange={e => setCustomer({ ...customer, name: e.target.value })} />
                            </div>
                            <div className="space-y-2">
                                <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Company / Firm</label>
                                <input type="text" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Optional" value={customer.company || ''} onChange={e => setCustomer({ ...customer, company: e.target.value })} />
                            </div>
                        </div>
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <div className="space-y-2">
                                <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Email Address</label>
                                <input type="email" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="name@example.com" value={customer.email} onChange={e => setCustomer({ ...customer, email: e.target.value })} />
                            </div>
                            <div className="space-y-2">
                                <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Phone Number</label>
                                <input type="tel" className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="+91 00000 00000" value={customer.phone} onChange={e => setCustomer({ ...customer, phone: e.target.value })} />
                            </div>
                        </div>

                        <div className="space-y-2">
                            <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Project Site Address</label>
                            <textarea rows={4} className="w-full p-3.5 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 bg-slate-50 text-slate-900 font-medium transition-all" placeholder="Enter complete site address for quotation..." value={customer.address} onChange={e => setCustomer({ ...customer, address: e.target.value })} />
                        </div>
                        <button type="submit" className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-xl transition-all shadow-lg shadow-indigo-200 active:scale-95 flex items-center justify-center space-x-2">
                            <span>Continue to Product Selection</span>
                            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" /></svg>
                        </button>
                    </form>
                </div>
            </div>
            <div className="lg:col-span-1">
                <div className="bg-white rounded-xl shadow-sm border border-slate-200 p-8 sticky top-24 space-y-6">
                    <div className="flex items-center space-x-3 text-indigo-600">
                        <div className="p-2 bg-indigo-50 rounded-lg">
                            <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                        </div>
                        <h3 className="text-lg font-bold text-slate-800">New Quotation</h3>
                    </div>
                    <p className="text-sm text-slate-500 leading-relaxed font-medium">
                        Welcome to the Magnific Designer Fans&Lights. Please provide the visitor information to begin generating a professional quotation.
                    </p>
                    <div className="space-y-4 pt-4 border-t">
                        <div className="flex items-start space-x-3">
                            <div className="mt-1 w-5 h-5 rounded-full bg-indigo-100 flex items-center justify-center flex-shrink-0">
                                <span className="text-[10px] font-bold text-indigo-600">1</span>
                            </div>
                            <div>
                                <h4 className="text-xs font-bold text-slate-700 uppercase tracking-wider">Registration</h4>
                                <p className="text-[11px] text-slate-400 font-medium">Capture customer and site details</p>
                            </div>
                        </div>
                        <div className="flex items-start space-x-3 opacity-50">
                            <div className="mt-1 w-5 h-5 rounded-full bg-slate-100 flex items-center justify-center flex-shrink-0">
                                <span className="text-[10px] font-bold text-slate-400">2</span>
                            </div>
                            <div>
                                <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Selection</h4>
                                <p className="text-[11px] text-slate-400 font-medium">Add fans and lights to the cart</p>
                            </div>
                        </div>
                        <div className="flex items-start space-x-3 opacity-50">
                            <div className="mt-1 w-5 h-5 rounded-full bg-slate-100 flex items-center justify-center flex-shrink-0">
                                <span className="text-[10px] font-bold text-slate-400">3</span>
                            </div>
                            <div>
                                <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Preview</h4>
                                <p className="text-[11px] text-slate-400 font-medium">Review and generate official form</p>
                            </div>
                        </div>
                    </div>
                    <div className="pt-6 border-t font-mono">
                        <div className="flex justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest mb-1">
                            <span>Office Location</span>
                        </div>
                        <p className="text-[11px] text-slate-600 font-bold">Magnific Fans & Lights • Koramangala</p>
                    </div>
                </div>
            </div>
        </div>
    );
}
