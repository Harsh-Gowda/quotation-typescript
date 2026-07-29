# RareWorks — Full Build Guide
## Next.js Ecommerce Platform + Admin Dashboard

> **Brand Name:** `RareWorks`
> *Rare products. Real craftsmanship. Nothing you've seen before.*
>
> Other strong options: `Unshelf` · `Oddmark` · `Vaulté` · `Oneism` · `Quelm`
> — All suggest "things you won't find in any retail shop"

---

## What You're Building

| Platform | URL | Purpose |
|---|---|---|
| **Storefront** | `rareworks.in` | Public-facing shop — browse, search, buy |
| **Admin Panel** | `admin.rareworks.in` | Private dashboard — upload products, manage orders, view analytics |

Both are **Next.js 14 (App Router)** — best for SEO, fast, and share the same codebase (monorepo).

---

## Tech Stack — Every Tool Chosen for a Reason

```
Frontend & Framework
├── Next.js 14          App Router, SSR/SSG for SEO
├── TypeScript          Catch bugs before they happen
├── Tailwind CSS        Fast styling, no bloat
└── Framer Motion       Smooth animations that don't feel AI-generated

Backend & Database
├── Next.js API Routes  Built-in — no separate server needed
├── Prisma ORM          Type-safe database access
├── PostgreSQL          Production database (use Supabase free tier)
└── Redis               Cart sessions, rate limiting (Upstash free tier)

Auth & Security
├── NextAuth.js         Customer login (Google, Email)
└── JWT + bcrypt        Admin panel separate secure auth

Payments
└── Razorpay            INR payments, UPI, cards, netbanking, wallets

Storage
└── Cloudinary          Product image upload + auto-resize + CDN

Search
└── Fuse.js             Fast local search (upgrade to Algolia later)

Email
└── Resend              Order confirmations, shipping updates

Deployment
├── Vercel              Storefront (free tier works great)
└── Vercel              Admin (same project, different subdomain)
```

---

## Brand Identity Guidelines

```
Brand Name:    RareWorks
Tagline:       "Things you won't find anywhere else."
Tone:          Confident, minimal, slightly mysterious
NOT:           Loud, salesy, generic marketplace feel

Color Palette
─────────────
Background:    #0A0A0A  (near-black — premium feel)
Surface:       #111111  (cards, panels)
Border:        #1E1E1E  (subtle separators)
Primary:       #E8FF47  (electric lime — unexpected, memorable)
Primary Dark:  #C8E030  (hover states)
Text Primary:  #F5F5F5  (headings)
Text Muted:    #888888  (descriptions, labels)
Accent:        #FF4747  (sale, urgent, new badge)
White:         #FFFFFF

Typography
──────────
Headings:  Geist (Variable) — clean, modern, not overused
Body:      Inter — readable at all sizes
Mono:      JetBrains Mono — prices, SKUs, codes

Design Rules
────────────
• Lots of whitespace — let products breathe
• Full-bleed product images — no tiny thumbnails
• No stock-photo lifestyle shots — raw product beauty
• Hover states on everything interactive
• No carousels on homepage — grid layouts only
• Mobile-first — most buyers browse on phone
```

---

## Project Structure (Monorepo)

```
rareworks/
├── apps/
│   ├── store/                    ← Public storefront (rareworks.in)
│   │   ├── app/
│   │   │   ├── layout.tsx        Root layout — fonts, metadata, providers
│   │   │   ├── page.tsx          Homepage
│   │   │   ├── products/
│   │   │   │   ├── page.tsx      All products grid
│   │   │   │   └── [slug]/
│   │   │   │       └── page.tsx  Single product page (SSG for SEO)
│   │   │   ├── category/
│   │   │   │   └── [slug]/
│   │   │   │       └── page.tsx  Category page
│   │   │   ├── cart/
│   │   │   │   └── page.tsx      Cart page
│   │   │   ├── checkout/
│   │   │   │   └── page.tsx      Checkout + Razorpay
│   │   │   ├── order/
│   │   │   │   └── [id]/
│   │   │   │       └── page.tsx  Order confirmation
│   │   │   ├── account/
│   │   │   │   ├── page.tsx      Profile
│   │   │   │   └── orders/
│   │   │   │       └── page.tsx  Order history
│   │   │   ├── search/
│   │   │   │   └── page.tsx      Search results
│   │   │   └── api/
│   │   │       ├── auth/         NextAuth endpoints
│   │   │       ├── cart/         Cart CRUD
│   │   │       ├── orders/       Create / fetch orders
│   │   │       ├── razorpay/     Payment create + verify webhook
│   │   │       └── products/     Public product API
│   │   └── components/
│   │       ├── layout/           Navbar, Footer, MobileMenu
│   │       ├── product/          ProductCard, ProductGrid, ProductDetail
│   │       ├── cart/             CartDrawer, CartItem, CartSummary
│   │       ├── checkout/         CheckoutForm, RazorpayButton
│   │       ├── ui/               Button, Badge, Input, Modal, Toast
│   │       └── home/             Hero, FeaturedGrid, CategoryStrip
│   │
│   └── admin/                    ← Admin dashboard (admin.rareworks.in)
│       ├── app/
│       │   ├── layout.tsx        Admin layout — sidebar, topbar
│       │   ├── login/
│       │   │   └── page.tsx      Admin login (separate from customer auth)
│       │   ├── dashboard/
│       │   │   └── page.tsx      Stats overview
│       │   ├── products/
│       │   │   ├── page.tsx      Products table — list all
│       │   │   ├── new/
│       │   │   │   └── page.tsx  Upload new product form
│       │   │   └── [id]/
│       │   │       └── page.tsx  Edit existing product
│       │   ├── orders/
│       │   │   ├── page.tsx      All orders table
│       │   │   └── [id]/
│       │   │       └── page.tsx  Order detail + status update
│       │   ├── customers/
│       │   │   └── page.tsx      Customer list
│       │   ├── categories/
│       │   │   └── page.tsx      Manage categories
│       │   ├── inventory/
│       │   │   └── page.tsx      Stock levels
│       │   └── api/              Admin-only API routes
│       │       ├── products/     CRUD products
│       │       ├── orders/       Update order status
│       │       ├── upload/       Cloudinary image upload
│       │       └── analytics/    Dashboard data
│       └── components/
│           ├── layout/           Sidebar, Topbar, Breadcrumb
│           ├── forms/            ProductForm, CategoryForm
│           ├── tables/           DataTable, OrdersTable
│           └── ui/               AdminButton, StatCard, Chart
│
├── packages/
│   ├── database/                 Prisma schema + client (shared)
│   │   ├── schema.prisma
│   │   └── index.ts
│   ├── types/                    Shared TypeScript types
│   │   └── index.ts
│   └── utils/                    Shared utilities
│       └── index.ts
│
├── package.json                  Turborepo workspace root
├── turbo.json                    Build pipeline config
└── .env.example                  All environment variables
```

---

## Database Schema (Prisma)

```prisma
// packages/database/schema.prisma

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// ── PRODUCTS ─────────────────────────────────────
model Product {
  id            String    @id @default(cuid())
  slug          String    @unique          // URL: /products/titanium-pocket-tool
  name          String
  tagline       String                     // "One line that sells it"
  description   String                     // Full rich text (markdown)
  story         String?                    // Why this product exists — your USP
  price         Int                        // In paise (₹499 = 49900)
  comparePrice  Int?                       // Strike-through price
  sku           String    @unique
  stock         Int       @default(0)
  lowStockAt    Int       @default(5)      // Trigger low stock badge
  weight        Float?                     // grams — for shipping calc
  dimensions    Json?                      // {l, w, h} in cm

  categoryId    String
  category      Category  @relation(fields: [categoryId], references: [id])

  images        ProductImage[]
  variants      ProductVariant[]
  orderItems    OrderItem[]
  reviews       Review[]
  tags          Tag[]

  status        ProductStatus @default(DRAFT)
  isFeatured    Boolean   @default(false)
  isRare        Boolean   @default(true)   // Your badge: "Rare Find"

  metaTitle     String?
  metaDesc      String?

  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt
}

model ProductImage {
  id         String   @id @default(cuid())
  productId  String
  product    Product  @relation(fields: [productId], references: [id], onDelete: Cascade)
  url        String                         // Cloudinary URL
  altText    String?
  position   Int      @default(0)           // Display order
  isDefault  Boolean  @default(false)
}

model ProductVariant {
  id         String   @id @default(cuid())
  productId  String
  product    Product  @relation(fields: [productId], references: [id], onDelete: Cascade)
  name       String                         // "Color", "Size", "Material"
  value      String                         // "Midnight Black", "Large"
  price      Int?                           // Override if different price
  stock      Int      @default(0)
  sku        String?  @unique
}

model Category {
  id          String    @id @default(cuid())
  slug        String    @unique
  name        String
  description String?
  image       String?
  parentId    String?
  parent      Category? @relation("CategoryTree", fields: [parentId], references: [id])
  children    Category[] @relation("CategoryTree")
  products    Product[]
  createdAt   DateTime  @default(now())
}

model Tag {
  id       String    @id @default(cuid())
  name     String    @unique
  products Product[]
}

// ── CUSTOMERS ────────────────────────────────────
model Customer {
  id            String   @id @default(cuid())
  email         String   @unique
  name          String?
  phone         String?
  passwordHash  String?
  googleId      String?  @unique
  avatar        String?

  addresses     Address[]
  orders        Order[]
  reviews       Review[]
  wishlist      WishlistItem[]

  emailVerified Boolean  @default(false)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
}

model Address {
  id         String   @id @default(cuid())
  customerId String
  customer   Customer @relation(fields: [customerId], references: [id])
  name       String
  line1      String
  line2      String?
  city       String
  state      String
  pincode    String
  phone      String
  isDefault  Boolean  @default(false)
}

// ── ORDERS ───────────────────────────────────────
model Order {
  id              String      @id @default(cuid())
  orderNumber     String      @unique  // RW-2025-0001
  customerId      String
  customer        Customer    @relation(fields: [customerId], references: [id])

  items           OrderItem[]

  subtotal        Int                  // paise
  shippingCost    Int         @default(0)
  discount        Int         @default(0)
  total           Int

  shippingAddress Json                 // snapshot at time of order
  billingAddress  Json?

  status          OrderStatus @default(PENDING)
  paymentStatus   PaymentStatus @default(PENDING)

  razorpayOrderId   String?   @unique
  razorpayPaymentId String?   @unique
  razorpaySignature String?

  notes           String?
  trackingNumber  String?
  shippingCarrier String?

  couponCode      String?
  couponDiscount  Int?

  createdAt       DateTime    @default(now())
  updatedAt       DateTime    @updatedAt
}

model OrderItem {
  id          String   @id @default(cuid())
  orderId     String
  order       Order    @relation(fields: [orderId], references: [id])
  productId   String
  product     Product  @relation(fields: [productId], references: [id])
  variantId   String?
  name        String                  // Snapshot product name
  image       String                  // Snapshot image URL
  price       Int                     // Snapshot price in paise
  quantity    Int
}

// ── ADMIN USERS ──────────────────────────────────
model AdminUser {
  id           String   @id @default(cuid())
  email        String   @unique
  name         String
  passwordHash String
  role         AdminRole @default(STAFF)
  lastLoginAt  DateTime?
  createdAt    DateTime @default(now())
}

// ── MISC ─────────────────────────────────────────
model Review {
  id         String   @id @default(cuid())
  productId  String
  product    Product  @relation(fields: [productId], references: [id])
  customerId String
  customer   Customer @relation(fields: [customerId], references: [id])
  rating     Int      // 1-5
  title      String?
  body       String
  isVerified Boolean  @default(false)
  createdAt  DateTime @default(now())
}

model WishlistItem {
  id         String   @id @default(cuid())
  customerId String
  customer   Customer @relation(fields: [customerId], references: [id])
  productId  String
  createdAt  DateTime @default(now())
  @@unique([customerId, productId])
}

model Coupon {
  id          String     @id @default(cuid())
  code        String     @unique
  type        CouponType // PERCENTAGE | FIXED
  value       Int        // 20 = 20% or ₹20
  minOrder    Int?       // Minimum order in paise
  maxUses     Int?
  usedCount   Int        @default(0)
  expiresAt   DateTime?
  isActive    Boolean    @default(true)
}

// ── ENUMS ────────────────────────────────────────
enum ProductStatus {
  DRAFT
  ACTIVE
  ARCHIVED
}

enum OrderStatus {
  PENDING
  CONFIRMED
  PROCESSING
  SHIPPED
  DELIVERED
  CANCELLED
  REFUNDED
}

enum PaymentStatus {
  PENDING
  PAID
  FAILED
  REFUNDED
}

enum AdminRole {
  SUPER_ADMIN
  ADMIN
  STAFF
}

enum CouponType {
  PERCENTAGE
  FIXED
}
```

---

## Platform 1 — Storefront (rareworks.in)

### Homepage — `app/page.tsx`

```tsx
// What goes on the homepage, in order:

// 1. HERO — Full viewport, product-first
//    - Big headline: "Things that don't exist in stores."
//    - Subline: short, punchy
//    - Background: dark, moody — one hero product image fills the frame
//    - Two CTAs: "Shop Now" and "See What's Rare"
//    - NO slider/carousel — single strong image

// 2. MARQUEE STRIP — Thin scrolling belt
//    - "Free shipping above ₹999" · "Handpicked products" · "10-day returns" ...

// 3. FEATURED PRODUCTS — 3-column asymmetric grid
//    - Large card on left (featured), two smaller on right
//    - Each card: full-bleed image, product name, price, "Add to Cart" on hover
//    - Badge: "RARE FIND" / "NEW" / "LAST 3 LEFT"

// 4. CATEGORY STRIP — Horizontal scroll on mobile, 4-col on desktop
//    - Icon + name for each category
//    - Dark pill buttons, hover = lime accent

// 5. STORY SECTION — Your brand difference
//    - Headline: "Why RareWorks?"
//    - 3 points: Unique products, Direct from makers, No middleman

// 6. NEW ARRIVALS — 4-column grid, most recent 8 products

// 7. TESTIMONIALS — Minimal text reviews, no star graphics

// 8. FOOTER
```

### Product Page — `app/products/[slug]/page.tsx`

```tsx
// generateStaticParams() — pre-render all products at build time
// This is what makes Next.js SEO gold

export async function generateStaticParams() {
  const products = await prisma.product.findMany({
    where: { status: 'ACTIVE' },
    select: { slug: true },
  })
  return products.map(p => ({ slug: p.slug }))
}

export async function generateMetadata({ params }) {
  const product = await getProduct(params.slug)
  return {
    title: `${product.name} — RareWorks`,
    description: product.metaDesc || product.tagline,
    openGraph: {
      title: product.name,
      description: product.tagline,
      images: [{ url: product.images[0].url }],
    },
  }
}

// PAGE LAYOUT — Split: Image left, Info right
//
// LEFT (sticky on desktop, top on mobile):
//   - Image gallery: large main image + thumbnail row
//   - Click thumbnail = swap main image (no lightbox needed)
//
// RIGHT (scrollable):
//   - Category breadcrumb
//   - Product name (H1 — important for SEO)
//   - Price (with comparePrice strike-through if set)
//   - "In Stock" / "Low Stock — X left" / "Out of Stock" badge
//   - Variant selector (if product has variants)
//   - Quantity picker
//   - "Add to Cart" button (primary, full-width)
//   - "Add to Wishlist" (icon button)
//   - Product tagline — one bold sentence
//   - Description (rich text / markdown rendered)
//   - Story section — "Why this product exists"
//   - Shipping info accordion
//   - Returns policy accordion
//   - Reviews section
//   - "You might also like" — 4 related products
```

### Cart — How It Works

```
Cart is stored in:
  - localStorage (guest users) — survives page refresh
  - Database CartItem table (logged-in users) — survives device switch
  - Merge happens on login

Cart Drawer (slide-in from right):
  - Triggered by cart icon in navbar
  - Shows all items with image, name, variant, qty, price
  - Qty increment/decrement buttons
  - Remove item (×)
  - Subtotal
  - "Checkout" button — goes to /checkout
  - "Continue Shopping" link
  - Free shipping progress bar: "Add ₹X more for free shipping!"
```

### Checkout + Razorpay — `app/checkout/page.tsx`

```tsx
// CHECKOUT FLOW — 3 steps

// STEP 1 — Address
//   - Login required (or continue as guest)
//   - Saved addresses shown (logged-in)
//   - Add new address form
//   - Fields: Name, Phone, Address Line 1 & 2, City, State, Pincode

// STEP 2 — Review Order
//   - Order summary (items, subtotal, shipping, total)
//   - Coupon code input
//   - "Place Order" button

// STEP 3 — Payment (Razorpay)

// ── API: Create Razorpay Order ────────────────────────
// app/api/razorpay/create/route.ts
import Razorpay from 'razorpay'

const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID!,
  key_secret: process.env.RAZORPAY_KEY_SECRET!,
})

export async function POST(req: Request) {
  const { amount, orderId } = await req.json()
  // amount is in paise

  const rpOrder = await razorpay.orders.create({
    amount,                             // ₹499 = 49900 paise
    currency: 'INR',
    receipt: orderId,
    notes: { orderId },
  })

  return Response.json({ orderId: rpOrder.id })
}

// ── CLIENT: Open Razorpay Checkout ────────────────────
// In your checkout component:
const openRazorpay = (rpOrderId: string, amount: number) => {
  const options = {
    key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
    amount,
    currency: 'INR',
    name: 'RareWorks',
    description: 'Your rare finds await.',
    image: '/logo.png',
    order_id: rpOrderId,
    prefill: {
      name: customer.name,
      email: customer.email,
      contact: customer.phone,
    },
    theme: {
      color: '#E8FF47',                 // Your brand lime color
    },
    handler: async (response) => {
      // Verify payment on server
      await verifyPayment(response)
      router.push('/order/success')
    },
  }
  const rzp = new window.Razorpay(options)
  rzp.open()
}

// ── API: Verify Payment ───────────────────────────────
// app/api/razorpay/verify/route.ts
import crypto from 'crypto'

export async function POST(req: Request) {
  const { razorpay_order_id, razorpay_payment_id, razorpay_signature } = await req.json()

  const body = razorpay_order_id + '|' + razorpay_payment_id
  const expectedSignature = crypto
    .createHmac('sha256', process.env.RAZORPAY_KEY_SECRET!)
    .update(body)
    .digest('hex')

  if (expectedSignature !== razorpay_signature) {
    return Response.json({ success: false }, { status: 400 })
  }

  // Update order status in DB to CONFIRMED + PAID
  await prisma.order.update({
    where: { razorpayOrderId: razorpay_order_id },
    data: {
      status: 'CONFIRMED',
      paymentStatus: 'PAID',
      razorpayPaymentId: razorpay_payment_id,
      razorpaySignature: razorpay_signature,
    },
  })

  // Send confirmation email via Resend
  await sendOrderConfirmationEmail(order)

  return Response.json({ success: true })
}
```

---

## Platform 2 — Admin Dashboard (admin.rareworks.in)

### Login — `app/login/page.tsx`

```
Separate from customer login.
JWT stored in httpOnly cookie.
Only allow access if role = ADMIN or SUPER_ADMIN.

Login form:
  - Email + Password
  - "Remember me" checkbox
  - No "Sign up" link — admin accounts created via CLI or SUPER_ADMIN only
```

### Dashboard Overview — `app/dashboard/page.tsx`

```
TOP ROW — 4 stat cards:
┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ Total Sales │ │   Orders    │ │  Products   │ │  Customers  │
│  ₹1,24,500  │ │     48      │ │     32      │ │     215     │
│  +12% week  │ │ 6 pending   │ │ 4 low stock │ │ 8 new today │
└─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘

MIDDLE ROW:
┌─────────────────────────────┐  ┌──────────────────────┐
│    Revenue Chart (30 days)  │  │   Recent Orders      │
│    Line chart, daily sales  │  │   Order # | Status   │
│                             │  │   Customer | Amount  │
└─────────────────────────────┘  └──────────────────────┘

BOTTOM ROW:
┌─────────────────────────┐  ┌──────────────────────────┐
│   Low Stock Alerts      │  │   Top Products This Week │
│   Product | Stock | SKU │  │   Name | Units | Revenue │
└─────────────────────────┘  └──────────────────────────┘
```

### Upload New Product — `app/products/new/page.tsx`

```
This is the core of your admin — make it clean and fast to use.

FORM SECTIONS (with tabs or accordion):

── BASIC INFO ──────────────────────────────────────────────
  Product Name*          [text input]
  Tagline*               [text input — "One sentence that sells it"]
  Slug*                  [auto-generated from name, editable]
                         Preview: rareworks.in/products/{slug}
  Category*              [dropdown — select existing or create]
  Status                 [Draft / Active / Archived]
  Is Featured?           [toggle]
  Is Rare Find?          [toggle — adds badge to product card]

── IMAGES ─────────────────────────────────────────────────
  Drag & Drop Upload     [Cloudinary direct upload]
  Supports:              JPEG, PNG, WebP — up to 10 images
  Auto-resized to:       1200×1200 (main), 400×400 (thumb)
  Reorder by drag        [position = display order]
  Set default image      [radio button on each image]
  Alt text field         [per image — important for SEO]

── DESCRIPTION ─────────────────────────────────────────────
  Description*           [Rich text editor — Bold/Italic/Lists/Links]
  Product Story          [Text area — "Why we sourced this"]

── PRICING & STOCK ─────────────────────────────────────────
  Price (₹)*             [number — stored as paise internally]
  Compare Price (₹)      [optional strike-through price]
  SKU*                   [unique product code]
  Stock Quantity*        [number]
  Low Stock Warning At   [number — default 5]
  Weight (grams)         [for shipping]
  Dimensions             [L × W × H in cm]

── VARIANTS (optional) ─────────────────────────────────────
  [+ Add Variant Type]   e.g. "Color", "Size", "Material"
  For each variant:      Name, Value, Price Override, Stock, SKU

── SEO ─────────────────────────────────────────────────────
  Meta Title             [defaults to product name]
  Meta Description       [defaults to tagline]
  Preview:               Shows Google search snippet preview

── TAGS ────────────────────────────────────────────────────
  Tags                   [multi-select + create new inline]

[Save as Draft]          [Preview]          [Publish Product]
```

### Manage Orders — `app/orders/page.tsx`

```
FILTERS BAR:
  Status: All | Pending | Confirmed | Shipped | Delivered | Cancelled
  Date range picker
  Search by order # or customer name

TABLE COLUMNS:
  Order #     Customer     Date          Items     Total      Status       Action
  RW-0048     Arjun S.     24 Jul 2025   3 items   ₹2,499    ● Pending    [View]
  RW-0047     Priya K.     23 Jul 2025   1 item    ₹999      ● Shipped    [View]

ORDER DETAIL PAGE:
  ┌─ Customer Info ─────────────────────────────────────┐
  │ Name, Email, Phone                                  │
  │ Shipping address                                    │
  └────────────────────────────────────────────────────┘
  ┌─ Items Ordered ─────────────────────────────────────┐
  │ [img] Product Name × qty     ₹price                 │
  └────────────────────────────────────────────────────┘
  ┌─ Payment Info ──────────────────────────────────────┐
  │ Razorpay Payment ID                                 │
  │ Subtotal / Shipping / Discount / Total              │
  └────────────────────────────────────────────────────┘
  ┌─ Update Status ─────────────────────────────────────┐
  │ [Confirm Order] → [Mark Shipped + Tracking #] →     │
  │ [Mark Delivered]                                    │
  │ Or: [Cancel] [Initiate Refund]                      │
  └────────────────────────────────────────────────────┘
  Sends automatic email to customer on each status change.
```

---

## SEO Strategy for Next.js

```tsx
// app/layout.tsx — site-level SEO defaults
export const metadata = {
  metadataBase: new URL('https://rareworks.in'),
  title: {
    default: 'RareWorks — Things You Won\'t Find Anywhere Else',
    template: '%s — RareWorks',
  },
  description: 'Unique, handpicked products that don\'t exist in retail stores. Shop rare finds at RareWorks.',
  openGraph: {
    type: 'website',
    locale: 'en_IN',
    url: 'https://rareworks.in',
    siteName: 'RareWorks',
  },
  twitter: { card: 'summary_large_image' },
  robots: { index: true, follow: true },
}

// Product pages: generateStaticParams() → build-time HTML → Google loves this
// Category pages: ISR with revalidate: 3600 (rebuild every hour)
// Homepage: revalidate: 300 (rebuild every 5 min — keeps "new arrivals" fresh)

// JSON-LD Structured Data on product pages (Google Rich Results)
const jsonLd = {
  '@context': 'https://schema.org',
  '@type': 'Product',
  name: product.name,
  description: product.description,
  image: product.images.map(i => i.url),
  sku: product.sku,
  offers: {
    '@type': 'Offer',
    price: (product.price / 100).toFixed(2),
    priceCurrency: 'INR',
    availability: product.stock > 0
      ? 'https://schema.org/InStock'
      : 'https://schema.org/OutOfStock',
    url: `https://rareworks.in/products/${product.slug}`,
  },
}
```

---

## Environment Variables

```bash
# .env.local (never commit this file)

# Database
DATABASE_URL="postgresql://user:password@host:5432/rareworks"

# Auth (NextAuth)
NEXTAUTH_URL="https://rareworks.in"
NEXTAUTH_SECRET="your-random-32-char-secret"
GOOGLE_CLIENT_ID="from-google-console"
GOOGLE_CLIENT_SECRET="from-google-console"

# Razorpay
RAZORPAY_KEY_ID="rzp_live_xxxxxxxxxxxx"
RAZORPAY_KEY_SECRET="your-razorpay-secret"
NEXT_PUBLIC_RAZORPAY_KEY_ID="rzp_live_xxxxxxxxxxxx"  # Safe to expose

# Cloudinary (image uploads)
CLOUDINARY_CLOUD_NAME="rareworks"
CLOUDINARY_API_KEY="your-api-key"
CLOUDINARY_API_SECRET="your-api-secret"
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME="rareworks"

# Redis (cart sessions)
UPSTASH_REDIS_URL="https://xxx.upstash.io"
UPSTASH_REDIS_TOKEN="your-token"

# Email
RESEND_API_KEY="re_xxxxxxxxxxxx"
EMAIL_FROM="orders@rareworks.in"

# Admin
ADMIN_JWT_SECRET="your-admin-jwt-secret"

# URLs
NEXT_PUBLIC_STORE_URL="https://rareworks.in"
NEXT_PUBLIC_ADMIN_URL="https://admin.rareworks.in"
```

---

## Setup & Run — Step by Step

```bash
# 1. Create project
npx create-turbo@latest rareworks
cd rareworks

# 2. Install dependencies
pnpm install

# 3. Add packages to store app
cd apps/store
pnpm add next@14 react react-dom
pnpm add @prisma/client razorpay next-auth
pnpm add @tanstack/react-query zustand
pnpm add framer-motion clsx tailwind-merge
pnpm add cloudinary resend

# 4. Add packages to admin app
cd ../admin
pnpm add recharts react-hook-form @hookform/resolvers zod
pnpm add react-dropzone react-quill  # Rich text + image upload

# 5. Setup database
cd ../../packages/database
npx prisma init
# Paste schema from above into schema.prisma
npx prisma db push          # Creates tables
npx prisma generate         # Generates TypeScript types

# 6. Create first admin user
npx ts-node scripts/create-admin.ts

# 7. Run both apps
pnpm dev
# Store runs on: localhost:3000
# Admin runs on: localhost:3001
```

---

## Deployment

```
STOREFRONT (rareworks.in)
─────────────────────────
Platform:    Vercel (free tier is enough to start)
Steps:
  1. Push to GitHub
  2. Import repo in Vercel
  3. Set root directory: apps/store
  4. Add all env variables in Vercel dashboard
  5. Connect custom domain: rareworks.in

ADMIN PANEL (admin.rareworks.in)
─────────────────────────────────
Platform:    Vercel (same GitHub repo, second Vercel project)
Steps:
  1. Create new Vercel project from same repo
  2. Set root directory: apps/admin
  3. Add env variables
  4. Connect subdomain: admin.rareworks.in

DATABASE
────────
  Supabase free tier — PostgreSQL
  Free: 500MB storage, enough for 10,000+ products
  Connection string goes in DATABASE_URL

IMAGES
──────
  Cloudinary free tier
  Free: 25GB storage + 25GB bandwidth/month
  More than enough to start
```

---

## Pages Checklist — Don't Miss Any

### Storefront
- [ ] `/` — Homepage
- [ ] `/products` — All products grid
- [ ] `/products/[slug]` — Product detail (SSG)
- [ ] `/category/[slug]` — Category page
- [ ] `/search` — Search results
- [ ] `/cart` — Cart page
- [ ] `/checkout` — Checkout flow
- [ ] `/order/success` — Post-payment confirmation
- [ ] `/order/[id]` — Order detail
- [ ] `/account` — Profile page
- [ ] `/account/orders` — Order history
- [ ] `/account/wishlist` — Saved products
- [ ] `/about` — Brand story (important for unique products)
- [ ] `/contact` — Support
- [ ] `/shipping-policy` — Legal
- [ ] `/return-policy` — Legal
- [ ] `/privacy-policy` — Legal
- [ ] `sitemap.xml` — Auto-generated (Next.js built-in)
- [ ] `robots.txt` — Allow all, block /admin

### Admin
- [ ] `/login` — Admin login
- [ ] `/dashboard` — Overview stats
- [ ] `/products` — Products table
- [ ] `/products/new` — Upload product
- [ ] `/products/[id]` — Edit product
- [ ] `/orders` — All orders
- [ ] `/orders/[id]` — Order detail + status update
- [ ] `/customers` — Customer list
- [ ] `/categories` — Manage categories
- [ ] `/inventory` — Stock management
- [ ] `/coupons` — Discount codes
- [ ] `/settings` — Store settings, admin users

---

## What Makes RareWorks Look Premium (Not AI-generated)

```
✓ DARK THEME — Most unique product stores use dark backgrounds
  because it makes colors and images pop. Avoid bright white.

✓ FULL-BLEED IMAGES — No white padding around product images.
  Image fills the card completely. Hover = slight zoom.

✓ MICRO-INTERACTIONS — Every button has a hover state.
  Cart updates animate. Page transitions are smooth.
  Use Framer Motion for enter animations (not CSS).

✓ TYPOGRAPHY CONTRAST — Mix font weights dramatically.
  ₹1,299 in large, heavy type. Description in light weight.

✓ PRODUCT CARDS — Only show price + name on default.
  On hover: reveal "Add to Cart" + quick-view icon.
  No ratings stars cluttering the card.

✓ CONSISTENT SPACING — Everything on an 8px grid.
  Never eyeball spacing. Use Tailwind's scale.

✓ CUSTOM CURSOR on desktop (CSS only — follows pointer)

✓ LOADING STATES — Skeleton loaders (not spinners).
  Cart drawer has a loading skeleton while fetching.

✓ ERROR STATES — Custom 404 page that's on-brand.
  Payment failure page with clear retry instructions.

✓ "LAST 3 LEFT" badge — Creates urgency authentically.
  Auto-shows when stock ≤ lowStockAt value.

✓ PRODUCT STORY SECTION — This is your biggest differentiator.
  Every product has a "Why this exists" paragraph.
  No other retail shop does this. It's your brand voice.
```

---

## Estimated Timeline

```
Week 1    Database + Auth + basic API routes
Week 2    Product pages (list + detail) — SEO foundation
Week 3    Cart + Checkout + Razorpay integration
Week 4    Admin dashboard — upload + orders management
Week 5    Polish, mobile testing, email flows
Week 6    Deploy + domain setup + go live

Solo developer: 6-8 weeks
With help:      3-4 weeks
```

---

## Cost to Run (Monthly)

```
Vercel (Hobby)       Free       2 projects, generous limits
Supabase (Free)      Free       500MB DB, enough for years
Cloudinary (Free)    Free       25GB images + CDN
Upstash Redis        Free       10,000 req/day
Resend               Free       3,000 emails/month
Razorpay             2% + ₹3   Per transaction (no monthly fee)
Domain (.in)         ₹800/yr    ~₹67/month
─────────────────────────────────────────────
TOTAL                ~₹67/mo   Until you scale up
```

---

## Brand Name Final Recommendation

**`RareWorks`** is the best fit for you because:
- Rare = signals your products aren't available anywhere else
- Works = suggests craft, function, something made with intention
- Available as rareworks.in (check GoDaddy)
- Short, memorable, works as @rareworks on Instagram

**Runner-up alternatives:**
| Name | Domain | Vibe |
|---|---|---|
| `Unshelf` | unshelf.in | Products that never made it to shelves |
| `Oddmark` | oddmark.in | Oddly good, stands out |
| `Quelm` | quelm.in | Made-up, memorable, mysterious |
| `Vaulté` | vaulte.in | Curated, locked-away finds |
| `Oneism` | oneism.in | One of a kind |

---

*Build guide version 1.0 — RareWorks Platform*
*Stack: Next.js 14 · TypeScript · Prisma · PostgreSQL · Razorpay · Cloudinary*
