# Fellow4U Backend

## Setup

Dat backend tai:
- `backend/`

Tao file `.env` tu:
- [backend/.env.example](D:/Hoctap/3.%20Nam3/KI2/1.%20LapTrinhMobile/Project/fellow4u/backend/.env.example:1)

## Cai package

```powershell
cd backend
npm install
```

## Tao database va Prisma client

Backend dang dung:
- `SQLite`

File database se duoc tao tai:
- `backend/prisma/dev.db`

```powershell
npm run prisma:generate
npm run prisma:migrate -- --name init
npm run prisma:seed
```

## Chay server

```powershell
npm run dev
```

Mac dinh server:
- `http://localhost:3000`

## API prefix

- `/api/v1`

## Endpoint da co

- `POST /api/v1/auth/sign-up`
- `POST /api/v1/auth/sign-in`
- `GET /api/v1/auth/me`
- `POST /api/v1/auth/forgot-password`
- `GET /api/v1/destinations`
- `GET /api/v1/guides`
- `GET /api/v1/guides/:id`
- `GET /api/v1/tours`
- `GET /api/v1/tours/:id`
- `GET /api/v1/search`
- `GET /api/v1/attractions`
- `POST /api/v1/trips`
- `GET /api/v1/trips`
- `GET /api/v1/trips/:id`
- `PUT /api/v1/trips/:id`
- `GET /api/v1/wishlist`
- `POST /api/v1/wishlist`
- `DELETE /api/v1/wishlist/:tourId`
