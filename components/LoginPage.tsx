import React, { useState } from 'react';

// User credentials - passwords can be updated later
const USERS: { name: string; password: string; role: string }[] = [
    { name: 'Admin', password: 'admin@magnific', role: 'admin' },
    { name: 'Alifiya', password: 'alifiya@123', role: 'sales' },
    { name: 'Sharmila', password: 'sharmila@123', role: 'sales' },

];

interface LoginPageProps {
    onLogin: (user: { name: string; role: string }) => void;
}

export default function LoginPage({ onLogin }: LoginPageProps) {
    const [selectedUser, setSelectedUser] = useState<string>('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setError('');

        if (!selectedUser) {
            setError('Please select your name');
            return;
        }

        if (!password) {
            setError('Please enter your password');
            return;
        }

        setIsLoading(true);

        // Simulate a brief delay for UX
        setTimeout(() => {
            const user = USERS.find(
                u => u.name === selectedUser && u.password === password
            );

            if (user) {
                onLogin({ name: user.name, role: user.role });
            } else {
                setError('Invalid password. Please try again.');
                setPassword('');
            }
            setIsLoading(false);
        }, 500);
    };

    return (
        <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-900 relative overflow-hidden">
            {/* Background decorative elements */}
            <div className="absolute inset-0 overflow-hidden pointer-events-none">
                <div className="absolute -top-40 -right-40 w-80 h-80 bg-indigo-500/10 rounded-full blur-3xl animate-pulse" />
                <div className="absolute -bottom-40 -left-40 w-80 h-80 bg-blue-500/10 rounded-full blur-3xl animate-pulse" style={{ animationDelay: '1s' }} />
                <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-violet-500/5 rounded-full blur-3xl" />
            </div>

            <div className="relative z-10 w-full max-w-md mx-4">
                {/* Logo */}
                <div className="text-center mb-8">
                    <div className="inline-block mb-4">
                        <img
                            src="/images/magnific-web.png"
                            alt="Magnific"
                            className="h-16 w-auto mx-auto brightness-0 invert opacity-90"
                        />
                    </div>
                    <p className="text-indigo-300/70 text-sm font-medium tracking-wide">
                        Quotation Management System
                    </p>
                </div>

                {/* Login Card */}
                <div className="bg-white/10 backdrop-blur-xl border border-white/20 rounded-2xl shadow-2xl p-8">
                    <div className="text-center mb-6">
                        <h2 className="text-xl font-bold text-white">Welcome Back</h2>
                        <p className="text-sm text-slate-400 mt-1">Sign in to continue</p>
                    </div>

                    <form onSubmit={handleSubmit} className="space-y-5">
                        {/* User Selection */}
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-indigo-300 uppercase tracking-widest">
                                Select Your Name
                            </label>
                            <div className="relative">
                                <select
                                    value={selectedUser}
                                    onChange={(e) => {
                                        setSelectedUser(e.target.value);
                                        setError('');
                                    }}
                                    className="w-full p-3.5 bg-white/5 border border-white/15 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-white font-medium transition-all appearance-none cursor-pointer"
                                    style={{ colorScheme: 'dark' }}
                                >
                                    <option value="" disabled className="bg-slate-800 text-slate-400">— Choose your name —</option>
                                    {USERS.map(user => (
                                        <option key={user.name} value={user.name} className="bg-slate-800 text-white">
                                            {user.name} ({user.role})
                                        </option>
                                    ))}
                                </select>
                                <div className="absolute right-3 top-1/2 transform -translate-y-1/2 pointer-events-none text-slate-400">
                                    <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        {/* Password Input */}
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-indigo-300 uppercase tracking-widest">
                                Password
                            </label>
                            <div className="relative">
                                <input
                                    type={showPassword ? 'text' : 'password'}
                                    value={password}
                                    onChange={e => {
                                        setPassword(e.target.value);
                                        setError('');
                                    }}
                                    placeholder="Enter your password"
                                    className="w-full p-3.5 pr-12 bg-white/5 border border-white/15 rounded-xl outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent text-white placeholder-slate-500 font-medium transition-all"
                                />
                                <button
                                    type="button"
                                    onClick={() => setShowPassword(!showPassword)}
                                    className="absolute right-3 top-1/2 transform -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors"
                                >
                                    {showPassword ? (
                                        <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21" />
                                        </svg>
                                    ) : (
                                        <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    )}
                                </button>
                            </div>
                        </div>

                        {/* Error Message */}
                        {error && (
                            <div className="flex items-center space-x-2 bg-red-500/10 border border-red-500/30 text-red-300 text-sm px-4 py-3 rounded-xl animate-pulse">
                                <svg className="w-4 h-4 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.07 16.5c-.77.833.192 2.5 1.732 2.5z" />
                                </svg>
                                <span>{error}</span>
                            </div>
                        )}

                        {/* Submit Button */}
                        <button
                            type="submit"
                            disabled={isLoading || !selectedUser}
                            className={`
                                w-full py-4 rounded-xl font-bold text-sm transition-all duration-200 flex items-center justify-center space-x-2
                                ${!selectedUser
                                    ? 'bg-slate-700 text-slate-500 cursor-not-allowed'
                                    : isLoading
                                        ? 'bg-indigo-600 text-white cursor-wait'
                                        : 'bg-indigo-600 hover:bg-indigo-500 text-white shadow-lg shadow-indigo-500/30 active:scale-[0.98]'
                                }
                            `}
                        >
                            {isLoading ? (
                                <>
                                    <svg className="animate-spin h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                                    </svg>
                                    <span>Verifying...</span>
                                </>
                            ) : (
                                <>
                                    <span>Sign In</span>
                                    <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" />
                                    </svg>
                                </>
                            )}
                        </button>
                    </form>
                </div>

                {/* Footer */}
                <p className="text-center text-slate-600 text-xs mt-6 font-medium">
                    © {new Date().getFullYear()} Magnific Designer Fans & Lights
                </p>
            </div>
        </div>
    );
}
