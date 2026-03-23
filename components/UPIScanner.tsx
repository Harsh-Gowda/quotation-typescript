import React, { useState, useEffect } from 'react';
import { QRCodeSVG } from 'qrcode.react';

interface UPIScannerProps {
    amount: number;
    quotationId: string;
    customerName: string;
}

const UPIScanner: React.FC<UPIScannerProps> = ({ amount, quotationId, customerName }) => {
    const [isMobile, setIsMobile] = useState(false);

    useEffect(() => {
        const checkMobile = () => {
            setIsMobile(/iPhone|iPad|iPod|Android/i.test(navigator.userAgent));
        };
        checkMobile();
        window.addEventListener('resize', checkMobile);
        return () => window.removeEventListener('resize', checkMobile);
    }, []);

    // UPI Details
    const upiId = "magnific@axisbank"; // Placeholder - please verify
    const businessName = "Magnific Home Appliances";
    const transactionNote = `Quotation ${quotationId} - ${customerName}`;
    
    // upi://pay?pa=[YourUPI]&pn=[Name]&am=[Amount]&cu=INR&tn=[Note]
    const upiUrl = `upi://pay?pa=${upiId}&pn=${encodeURIComponent(businessName)}&am=${amount}&cu=INR&tn=${encodeURIComponent(transactionNote)}`;

    const handleMobilePay = () => {
        window.location.href = upiUrl;
    };

    return (
        <div className="flex flex-col items-center p-4 bg-white rounded-xl border border-slate-200 shadow-sm no-print-break">
            <div className="text-center mb-3">
                <h4 className="text-[10px] font-black text-slate-800 uppercase tracking-widest mb-1">Secure UPI Payment</h4>
                <p className="text-[8px] text-slate-500 font-bold uppercase">Scan to pay balance: <span className="text-indigo-600">₹{amount.toLocaleString('en-IN')}</span></p>
            </div>

            {isMobile ? (
                <button 
                    onClick={handleMobilePay}
                    className="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-3 px-6 rounded-lg font-bold text-sm flex items-center justify-center space-x-2 transition-all shadow-md active:scale-95 border-b-4 border-indigo-800"
                >
                    <svg className="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"/>
                    </svg>
                    <span>Pay via UPI App</span>
                </button>
            ) : (
                <div className="p-2 bg-white border-2 border-slate-100 rounded-lg shadow-inner">
                    <QRCodeSVG 
                        value={upiUrl} 
                        size={100} 
                        level="H"
                        includeMargin={true}
                    />
                </div>
            )}
            
            <div className="mt-3 flex items-center space-x-2 opacity-50 grayscale transition-all hover:grayscale-0">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/UPI-Logo.png/1200px-UPI-Logo.png" alt="UPI" className="h-3" />
                <span className="text-[7px] font-black text-slate-400 uppercase tracking-tighter">Powered by BHIM UPI</span>
            </div>
        </div>
    );
};

export default UPIScanner;
