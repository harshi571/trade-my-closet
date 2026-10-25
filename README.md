# Trade My Closet — Independent Full-Stack Starter

A premium, mobile-responsive, multi-category exchange marketplace. This is a **working starter implementation**, not a production-ready or published Play Store app. It is an original implementation inspired by the user's reference website screenshots; no proprietary Lovable source code is included.

## Included
- React + Vite storefront with premium ivory/charcoal/champagne styling
- Responsive mobile navigation, categories, search and item detail pages
- PostgreSQL + Express REST API
- Registration/login with bcrypt password hashes and signed JWTs
- Item listings with single-image upload (JPG/PNG/WebP, 5 MB maximum)
- Wishlist, swap/points requests, user dashboard, notifications, swap history
- Basic English, Telugu and Hindi UI translation of key homepage/navigation strings; other interface strings remain English
- Capacitor configuration for Android packaging

## Run locally
1. Install Node.js 20+ and PostgreSQL 15+.
2. Create a PostgreSQL database named `trade_my_closet`.
3. Run `psql -d trade_my_closet -f server/sql/schema.sql` (supply your local PostgreSQL user as needed).
4. Copy `server/.env.example` to `server/.env`. Set `DATABASE_URL` and a **long random** `JWT_SECRET`.
5. At the project root, run `npm install`, then `npm run install:all`, then `npm run dev`.
6. Open http://localhost:5173 . The backend is at http://localhost:4000.

The app starts with an **empty database**. Create accounts and upload your own items to populate the shop.

## API endpoints
- POST `/api/auth/register`, `/api/auth/login`
- GET `/api/me`, PATCH `/api/me/language`
- GET `/api/items`, GET `/api/items/mine`, POST `/api/items`, DELETE `/api/items/:id`
- GET `/api/wishlist`, POST/DELETE `/api/wishlist/:id`
- GET/POST `/api/swaps`, PATCH `/api/swaps/:id`
- GET `/api/notifications`, PATCH `/api/notifications/:id/read`
- GET `/api/points`

## Android / Play Store path
1. Deploy backend to a secure HTTPS domain and PostgreSQL to a managed host. Configure `CLIENT_ORIGIN` correctly.
2. Set the frontend's API URL to the HTTPS backend. Current Vite `/api` proxy is **development-only**; an Android WebView does not use the Vite dev proxy. Change `const API='/api'` in `client/src/main.jsx` to the production API origin, e.g. `https://api.example.com/api`, or supply a build-time environment variable. Images uploaded to the server likewise need absolute production URLs or a frontend URL resolver.
3. From `client/`: `npm install`, `npm run build`, `npx cap add android`, `npx cap sync android`, `npx cap open android`.
4. Use Android Studio to test on devices, set a unique package ID, add real adaptive app icons and splash screen, configure permissions, and generate a signed Android App Bundle (.aab).
5. Before publishing, implement privacy policy, terms, account deletion, reporting/moderation, user safety workflows, age-appropriate access controls, secure object storage, email verification, recovery, robust anti-abuse protections, testing and compliance with current Play policies.
6. Register for an eligible Google Play developer account, complete required testing and disclosures, and submit for review. Approval is not guaranteed.

## Important starter limitations
- No payment gateway or shipping integration. Cash purchases are not supported.
- Single-image upload, not multi-image upload.
- Swaps and points are a **prototype workflow**. A request is accepted by the owner, and the owner can mark it complete. A real marketplace needs both parties' confirmation, disputes, anti-fraud protections, and administrative review. No starting points are granted; points can be earned from completed swaps (10 points each).
- Points and item reservations should be audited and strengthened before public release.
- Images currently use local server storage; use managed object storage for deployment.
- Unsplash images are used for category/decorative fallback; they are not real listings.
- App is not yet published, and no signed APK/AAB is included.

## Future improvements
Multilingual coverage throughout the interface, translation of listings, email verification, user reporting, moderation dashboard, escrow-like exchange confirmations, item editing, image galleries, push notifications, and verified deployment.
