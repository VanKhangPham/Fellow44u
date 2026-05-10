# API Contract

Tai lieu nay chot contract cho ban MVP cua backend truoc khi code API that.

## 1. Gia dinh ky thuat

- Backend dat trong thu muc: `backend/`
- Goi y stack: `Node.js + Express + Prisma + PostgreSQL`
- Prefix API: `/api/v1`
- Response format dung chung:

```json
{
  "success": true,
  "message": "OK",
  "data": {}
}
```

- Error format dung chung:

```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {
    "email": ["Email is required"]
  }
}
```

## 2. Auth API

### POST `/api/v1/auth/sign-up`

Muc dich:
- Dang ky tai khoan moi

Request body:

```json
{
  "fullName": "Nguyen Van A",
  "email": "a@gmail.com",
  "password": "12345678"
}
```

Response:

```json
{
  "success": true,
  "message": "Sign up successful",
  "data": {
    "accessToken": "jwt-token",
    "user": {
      "id": "user-1",
      "fullName": "Nguyen Van A",
      "email": "a@gmail.com"
    }
  }
}
```

### POST `/api/v1/auth/sign-in`

Muc dich:
- Dang nhap bang email va password

Request body:

```json
{
  "email": "a@gmail.com",
  "password": "12345678"
}
```

Response:

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "accessToken": "jwt-token",
    "user": {
      "id": "user-1",
      "fullName": "Nguyen Van A",
      "email": "a@gmail.com"
    }
  }
}
```

### GET `/api/v1/auth/me`

Muc dich:
- Lay thong tin nguoi dung hien tai

Headers:
- `Authorization: Bearer <token>`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "id": "user-1",
    "fullName": "Nguyen Van A",
    "email": "a@gmail.com"
  }
}
```

### POST `/api/v1/auth/forgot-password`

Request body:

```json
{
  "email": "a@gmail.com"
}
```

Response:

```json
{
  "success": true,
  "message": "Reset password request received",
  "data": null
}
```

## 3. Destination API

### GET `/api/v1/destinations`

Muc dich:
- Lay danh sach destination de phuc vu `Search`, `Explore`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "destination-danang",
      "name": "Da Nang",
      "country": "Vietnam",
      "imageUrl": "assets/images/danang.png"
    }
  ]
}
```

## 4. Guide API

### GET `/api/v1/guides`

Query:
- `featured=true|false`
- `limit=4`
- `search=...`
- `city=...`
- `language=...`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "guide-tuan-tran",
      "name": "Tuan Tran",
      "avatarUrl": "assets/images/guide_1.png",
      "city": "Da Nang",
      "country": "Vietnam",
      "rating": 4.9,
      "reviewCount": 127,
      "priceLabel": "$20/hour",
      "languages": ["Vietnamese", "English"]
    }
  ]
}
```

### GET `/api/v1/guides/{id}`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "guide": {
      "id": "guide-tuan-tran",
      "name": "Tuan Tran",
      "avatarUrl": "assets/images/guide_1.png",
      "city": "Da Nang",
      "country": "Vietnam",
      "rating": 4.9,
      "reviewCount": 127,
      "priceLabel": "$20/hour",
      "languages": ["Vietnamese", "English"]
    },
    "about": "Local guide with deep knowledge of Da Nang.",
    "experiences": [
      {
        "id": "exp-1",
        "title": "Food tour",
        "imageUrl": "assets/images/experience_1.png",
        "description": "Street food and hidden local spots."
      }
    ],
    "reviews": [
      {
        "id": "review-1",
        "authorName": "An",
        "rating": 5,
        "comment": "Very good guide"
      }
    ]
  }
}
```

## 5. Tour API

### GET `/api/v1/tours`

Query:
- `featured=true|false`
- `limit=4`
- `search=...`
- `city=...`
- `minPrice=...`
- `maxPrice=...`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "tour-danang-bana-hoian",
      "title": "Da Nang - Ba Na - Hoi An",
      "imageUrl": "assets/images/tour_1.png",
      "city": "Da Nang",
      "country": "Vietnam",
      "durationText": "3 days",
      "price": 120,
      "oldPrice": 150,
      "rating": 4.8,
      "likeCount": 320
    }
  ]
}
```

### GET `/api/v1/tours/{id}`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "tour": {
      "id": "tour-danang-bana-hoian",
      "title": "Da Nang - Ba Na - Hoi An",
      "imageUrl": "assets/images/tour_1.png",
      "city": "Da Nang",
      "country": "Vietnam",
      "durationText": "3 days",
      "price": 120,
      "oldPrice": 150,
      "rating": 4.8,
      "likeCount": 320
    },
    "description": "Travel package around central Vietnam.",
    "scheduleDays": [
      {
        "dayLabel": "Day 1",
        "entries": [
          {
            "time": "08:00",
            "title": "Pick up",
            "description": "Pick up from hotel"
          }
        ]
      }
    ]
  }
}
```

## 6. Search API

### GET `/api/v1/search`

Query:
- `query=...`
- `city=...`
- `category=guide|tour`
- `language=...`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "guides": [],
    "tours": []
  }
}
```

## 7. Attraction API

### GET `/api/v1/attractions`

Query:
- `search=...`
- `city=...`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "attraction-1",
      "name": "Dragon Bridge",
      "city": "Da Nang",
      "imageUrl": "assets/images/attraction_1.png"
    }
  ]
}
```

## 8. Trip API

### POST `/api/v1/trips`

Headers:
- `Authorization: Bearer <token>`

Request body:

```json
{
  "city": "Da Nang",
  "date": "2026-05-20",
  "fromTime": "08:00",
  "toTime": "18:00",
  "travelerCount": 2,
  "note": "Need local food suggestions",
  "attractionIds": ["attraction-1", "attraction-2"]
}
```

Response:

```json
{
  "success": true,
  "message": "Trip created successfully",
  "data": {
    "id": "trip-1",
    "city": "Da Nang",
    "date": "2026-05-20",
    "fromTime": "08:00",
    "toTime": "18:00",
    "travelerCount": 2,
    "status": "next"
  }
}
```

### GET `/api/v1/trips`

Headers:
- `Authorization: Bearer <token>`

Query:
- `status=current|next|past`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "trip-1",
      "city": "Da Nang",
      "date": "2026-05-20",
      "fromTime": "08:00",
      "toTime": "18:00",
      "travelerCount": 2,
      "status": "next"
    }
  ]
}
```

### GET `/api/v1/trips/{id}`

Headers:
- `Authorization: Bearer <token>`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "id": "trip-1",
    "city": "Da Nang",
    "date": "2026-05-20",
    "fromTime": "08:00",
    "toTime": "18:00",
    "travelerCount": 2,
    "note": "Need local food suggestions",
    "status": "next",
    "attractions": [
      {
        "id": "attraction-1",
        "name": "Dragon Bridge",
        "city": "Da Nang",
        "imageUrl": "assets/images/attraction_1.png"
      }
    ]
  }
}
```

### PUT `/api/v1/trips/{id}`

Headers:
- `Authorization: Bearer <token>`

Request body:

```json
{
  "city": "Da Nang",
  "date": "2026-05-21",
  "fromTime": "09:00",
  "toTime": "18:30",
  "travelerCount": 3,
  "note": "Updated plan",
  "attractionIds": ["attraction-1"]
}
```

Response:

```json
{
  "success": true,
  "message": "Trip updated successfully",
  "data": {
    "id": "trip-1"
  }
}
```

## 9. Wishlist API

### GET `/api/v1/wishlist`

Headers:
- `Authorization: Bearer <token>`

Response:

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "wishlist-1",
      "tourId": "tour-danang-bana-hoian",
      "title": "Da Nang - Ba Na - Hoi An",
      "imageUrl": "assets/images/tour_1.png",
      "price": 120
    }
  ]
}
```

### POST `/api/v1/wishlist`

Headers:
- `Authorization: Bearer <token>`

Request body:

```json
{
  "tourId": "tour-danang-bana-hoian"
}
```

Response:

```json
{
  "success": true,
  "message": "Added to wishlist",
  "data": {
    "id": "wishlist-1",
    "tourId": "tour-danang-bana-hoian"
  }
}
```

### DELETE `/api/v1/wishlist/{tourId}`

Headers:
- `Authorization: Bearer <token>`

Response:

```json
{
  "success": true,
  "message": "Removed from wishlist",
  "data": null
}
```
