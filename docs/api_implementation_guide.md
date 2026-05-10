# API Implementation Guide

Tai lieu nay huong dan ban viet backend API cho project `fellow4u` va ghi ro moi phan can dat o dau.

## 1. Muc tieu

Ban da tach frontend thanh `models -> mock data -> repositories`.
Buoc tiep theo la thay `MockRepository` bang backend API that.

De lam viec nay an toan, hay di theo thu tu:

1. Tao backend skeleton
2. Tao database schema
3. Viet `Auth API`
4. Viet `Guides / Tours / Destinations API`
5. Viet `Search API`
6. Viet `Trips API`
7. Viet `Wishlist API`
8. Tich hop Flutter voi API

## 2. Dat backend o dau

Vi repo hien tai chua co backend, hay tao backend trong:

- `backend/`

Goi y cau truc:

```text
backend/
  package.json
  .env
  prisma/
    schema.prisma
    seed.ts
  src/
    app.ts
    server.ts
    config/
      env.ts
      db.ts
    common/
      middleware/
        auth.middleware.ts
        error.middleware.ts
      utils/
        response.ts
        jwt.ts
        hash.ts
    modules/
      auth/
        auth.controller.ts
        auth.service.ts
        auth.repository.ts
        auth.routes.ts
        auth.validation.ts
      destinations/
        destination.controller.ts
        destination.service.ts
        destination.repository.ts
        destination.routes.ts
      guides/
        guide.controller.ts
        guide.service.ts
        guide.repository.ts
        guide.routes.ts
      tours/
        tour.controller.ts
        tour.service.ts
        tour.repository.ts
        tour.routes.ts
      search/
        search.controller.ts
        search.service.ts
        search.routes.ts
      attractions/
        attraction.controller.ts
        attraction.service.ts
        attraction.repository.ts
        attraction.routes.ts
      trips/
        trip.controller.ts
        trip.service.ts
        trip.repository.ts
        trip.routes.ts
        trip.validation.ts
      wishlist/
        wishlist.controller.ts
        wishlist.service.ts
        wishlist.repository.ts
        wishlist.routes.ts
```

## 3. Moi file de lam gi

### `backend/src/server.ts`

Dat o:
- `backend/src/server.ts`

Dung de:
- start server
- listen port

### `backend/src/app.ts`

Dat o:
- `backend/src/app.ts`

Dung de:
- tao `express app`
- dang ky middleware
- dang ky routes

### `backend/src/common/middleware/auth.middleware.ts`

Dat o:
- `backend/src/common/middleware/auth.middleware.ts`

Dung de:
- doc `Authorization: Bearer <token>`
- verify JWT
- gan `req.user`

### `backend/src/common/middleware/error.middleware.ts`

Dat o:
- `backend/src/common/middleware/error.middleware.ts`

Dung de:
- bat loi toan cuc
- tra response loi theo format chung

### `backend/src/common/utils/response.ts`

Dat o:
- `backend/src/common/utils/response.ts`

Dung de:
- tra response thanh cong dung format chung

### `backend/src/common/utils/jwt.ts`

Dat o:
- `backend/src/common/utils/jwt.ts`

Dung de:
- sign token
- verify token

### `backend/src/common/utils/hash.ts`

Dat o:
- `backend/src/common/utils/hash.ts`

Dung de:
- hash password
- compare password

## 4. Database dat o dau

### `backend/prisma/schema.prisma`

Dat o:
- `backend/prisma/schema.prisma`

Dung de:
- khai bao tat ca bang
- dinh nghia quan he

### `backend/prisma/seed.ts`

Dat o:
- `backend/prisma/seed.ts`

Dung de:
- seed guides
- seed tours
- seed destinations
- seed attractions

## 5. Cac bang can tao

Dat trong:
- `backend/prisma/schema.prisma`

Ban MVP nen co:

1. `User`
2. `Destination`
3. `Guide`
4. `GuideExperience`
5. `GuideReview`
6. `Tour`
7. `TourScheduleDay`
8. `TourScheduleEntry`
9. `Attraction`
10. `Trip`
11. `TripAttraction`
12. `Wishlist`

### Quan he chinh

- `User` 1-n `Trip`
- `User` 1-n `Wishlist`
- `Guide` 1-n `GuideExperience`
- `Guide` 1-n `GuideReview`
- `Tour` 1-n `TourScheduleDay`
- `TourScheduleDay` 1-n `TourScheduleEntry`
- `Trip` n-n `Attraction` qua `TripAttraction`

## 6. Thu tu viet API

Hay viet theo thu tu nay:

1. `Auth`
2. `Destinations`
3. `Guides`
4. `Tours`
5. `Search`
6. `Attractions`
7. `Trips`
8. `Wishlist`

Ly do:
- `Auth` can cho bao mat
- `Explore/Search` can du lieu de frontend hien thi
- `Trips/Wishlist` phu thuoc vao user dang nhap

## 7. Cach viet tung module

Moi module nen di theo 5 file chinh.

Vi du voi `guides`:

- `backend/src/modules/guides/guide.routes.ts`
- `backend/src/modules/guides/guide.controller.ts`
- `backend/src/modules/guides/guide.service.ts`
- `backend/src/modules/guides/guide.repository.ts`
- `backend/src/modules/guides/guide.validation.ts` neu can

### 7.1 `routes`

Dat o:
- `backend/src/modules/<module>/<module>.routes.ts`

Dung de:
- khai bao endpoint URL
- map sang controller

Vi du:
- `GET /api/v1/guides`
- `GET /api/v1/guides/:id`

### 7.2 `controller`

Dat o:
- `backend/src/modules/<module>/<module>.controller.ts`

Dung de:
- nhan `req`
- lay `params`, `query`, `body`
- goi service
- tra response

Khong nen:
- viet query database o day
- viet logic nghiep vu day dac o day

### 7.3 `service`

Dat o:
- `backend/src/modules/<module>/<module>.service.ts`

Dung de:
- xu ly nghiep vu
- goi repository
- validate logic
- map du lieu ve format API

### 7.4 `repository`

Dat o:
- `backend/src/modules/<module>/<module>.repository.ts`

Dung de:
- query database
- gom cac ham CRUD

### 7.5 `validation`

Dat o:
- `backend/src/modules/<module>/<module>.validation.ts`

Dung de:
- validate request body
- validate query string

## 8. Auth API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/auth/`

### File can co

- `backend/src/modules/auth/auth.routes.ts`
- `backend/src/modules/auth/auth.controller.ts`
- `backend/src/modules/auth/auth.service.ts`
- `backend/src/modules/auth/auth.repository.ts`
- `backend/src/modules/auth/auth.validation.ts`

### Endpoint can lam

1. `POST /api/v1/auth/sign-up`
2. `POST /api/v1/auth/sign-in`
3. `GET /api/v1/auth/me`
4. `POST /api/v1/auth/forgot-password`

### Logic chinh

#### `sign-up`

Can lam:
1. validate `fullName`, `email`, `password`
2. check email da ton tai chua
3. hash password
4. tao user
5. tao JWT
6. tra token + user

Database query dat o:
- `backend/src/modules/auth/auth.repository.ts`

Hash password dat o:
- `backend/src/common/utils/hash.ts`

JWT dat o:
- `backend/src/common/utils/jwt.ts`

#### `sign-in`

Can lam:
1. tim user theo email
2. compare password
3. tao token
4. tra token + user

#### `me`

Can lam:
1. verify token bang middleware
2. lay `userId` tu token
3. query user
4. tra user hien tai

Middleware dat o:
- `backend/src/common/middleware/auth.middleware.ts`

## 9. Destinations API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/destinations/`

### File can co

- `backend/src/modules/destinations/destination.routes.ts`
- `backend/src/modules/destinations/destination.controller.ts`
- `backend/src/modules/destinations/destination.service.ts`
- `backend/src/modules/destinations/destination.repository.ts`

### Endpoint

1. `GET /api/v1/destinations`

### Logic

Can lam:
1. query tat ca destinations
2. sort neu can
3. tra list

Map voi Flutter:
- thay `MockDestinationRepository` bang `ApiDestinationRepository`

## 10. Guides API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/guides/`

### File can co

- `backend/src/modules/guides/guide.routes.ts`
- `backend/src/modules/guides/guide.controller.ts`
- `backend/src/modules/guides/guide.service.ts`
- `backend/src/modules/guides/guide.repository.ts`

### Endpoint

1. `GET /api/v1/guides`
2. `GET /api/v1/guides/:id`

### Logic `GET /guides`

Can lam:
1. nhan query `featured`, `limit`, `search`, `city`, `language`
2. query bang `Guide`
3. tra danh sach guide

### Logic `GET /guides/:id`

Can lam:
1. query guide theo `id`
2. query `GuideExperience`
3. query `GuideReview`
4. gop ve response detail

Database phan nay dat o:
- `backend/prisma/schema.prisma`

Code query dat o:
- `backend/src/modules/guides/guide.repository.ts`

Map voi Flutter:
- `GuideRepository.fetchFeaturedGuides()` -> `GET /api/v1/guides?featured=true&limit=4`
- `GuideRepository.fetchAllGuides()` -> `GET /api/v1/guides`
- `GuideRepository.fetchGuideDetail(id)` -> `GET /api/v1/guides/:id`

## 11. Tours API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/tours/`

### File can co

- `backend/src/modules/tours/tour.routes.ts`
- `backend/src/modules/tours/tour.controller.ts`
- `backend/src/modules/tours/tour.service.ts`
- `backend/src/modules/tours/tour.repository.ts`

### Endpoint

1. `GET /api/v1/tours`
2. `GET /api/v1/tours/:id`

### Logic `GET /tours`

Can lam:
1. nhan query `featured`, `limit`, `search`, `city`, `minPrice`, `maxPrice`
2. query bang `Tour`
3. tra danh sach tour

### Logic `GET /tours/:id`

Can lam:
1. query tour theo `id`
2. query `TourScheduleDay`
3. query `TourScheduleEntry`
4. gop thanh detail response

Map voi Flutter:
- `TourRepository.fetchFeaturedTours()` -> `GET /api/v1/tours?featured=true&limit=4`
- `TourRepository.fetchAllTours()` -> `GET /api/v1/tours`
- `TourRepository.fetchTourDetail(id)` -> `GET /api/v1/tours/:id`

## 12. Search API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/search/`

### File can co

- `backend/src/modules/search/search.routes.ts`
- `backend/src/modules/search/search.controller.ts`
- `backend/src/modules/search/search.service.ts`

### Endpoint

1. `GET /api/v1/search`

### Logic

Can lam:
1. nhan `query`
2. nhan `city`
3. nhan `category`
4. query tu `Guide` va `Tour`
5. tra ve:
   - `guides`
   - `tours`

Map voi Flutter:
- `SearchRepository.search(...)` -> `GET /api/v1/search`

## 13. Attractions API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/attractions/`

### File can co

- `backend/src/modules/attractions/attraction.routes.ts`
- `backend/src/modules/attractions/attraction.controller.ts`
- `backend/src/modules/attractions/attraction.service.ts`
- `backend/src/modules/attractions/attraction.repository.ts`

### Endpoint

1. `GET /api/v1/attractions`

### Logic

Can lam:
1. query attractions
2. cho phep search theo ten
3. cho phep filter theo `city`

Map voi Flutter:
- `AttractionRepository.fetchAttractions(...)` -> `GET /api/v1/attractions`

## 14. Trips API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/trips/`

### File can co

- `backend/src/modules/trips/trip.routes.ts`
- `backend/src/modules/trips/trip.controller.ts`
- `backend/src/modules/trips/trip.service.ts`
- `backend/src/modules/trips/trip.repository.ts`
- `backend/src/modules/trips/trip.validation.ts`

### Endpoint

1. `POST /api/v1/trips`
2. `GET /api/v1/trips`
3. `GET /api/v1/trips/:id`
4. `PUT /api/v1/trips/:id`

### Logic `POST /trips`

Can lam:
1. verify token
2. validate body
3. tao record `Trip`
4. tao cac record `TripAttraction`
5. tra trip vua tao

### Logic `GET /trips`

Can lam:
1. verify token
2. lay danh sach theo `userId`
3. filter theo `status=current|next|past`

### Logic `GET /trips/:id`

Can lam:
1. verify token
2. check trip co thuoc user hien tai khong
3. lay trip detail + attractions

### Logic `PUT /trips/:id`

Can lam:
1. verify token
2. check ownership
3. update trip
4. cap nhat danh sach attractions

Map voi Flutter:
- `MyTripsRepository.fetchMyTrips()` se tach thanh nhieu API calls hoac 1 API tong hop
- goi y de don gian: dung `GET /api/v1/trips?status=...`

## 15. Wishlist API can viet nhu the nao

### Thu muc

Dat o:
- `backend/src/modules/wishlist/`

### File can co

- `backend/src/modules/wishlist/wishlist.routes.ts`
- `backend/src/modules/wishlist/wishlist.controller.ts`
- `backend/src/modules/wishlist/wishlist.service.ts`
- `backend/src/modules/wishlist/wishlist.repository.ts`

### Endpoint

1. `GET /api/v1/wishlist`
2. `POST /api/v1/wishlist`
3. `DELETE /api/v1/wishlist/:tourId`

### Logic

#### `GET /wishlist`

Can lam:
1. verify token
2. query wishlist theo user
3. include thong tin `Tour`

#### `POST /wishlist`

Can lam:
1. verify token
2. nhan `tourId`
3. check tour co ton tai khong
4. check da ton tai trong wishlist chua
5. them moi

#### `DELETE /wishlist/:tourId`

Can lam:
1. verify token
2. xoa theo `userId + tourId`

Map voi Flutter:
- `GET /wishlist` phuc vu tab `Wish List`

## 16. Register routes o dau

Dang ky route module trong:
- `backend/src/app.ts`

Vi du can noi:
- `/api/v1/auth`
- `/api/v1/destinations`
- `/api/v1/guides`
- `/api/v1/tours`
- `/api/v1/search`
- `/api/v1/attractions`
- `/api/v1/trips`
- `/api/v1/wishlist`

## 17. Thu tu code thuc te

Lam dung thu tu nay:

1. Tao `backend/`
2. Tao `backend/prisma/schema.prisma`
3. Tao `backend/src/app.ts`
4. Tao `backend/src/server.ts`
5. Tao `backend/src/common/utils/response.ts`
6. Tao `backend/src/common/utils/hash.ts`
7. Tao `backend/src/common/utils/jwt.ts`
8. Tao `backend/src/common/middleware/auth.middleware.ts`
9. Tao module `auth`
10. Tao module `destinations`
11. Tao module `guides`
12. Tao module `tours`
13. Tao module `search`
14. Tao module `attractions`
15. Tao module `trips`
16. Tao module `wishlist`
17. Seed du lieu mau
18. Test bang Postman
19. Tao `ApiRepository` ben Flutter de thay `MockRepository`

## 18. Cac file Flutter se doi sau khi co API

Sau khi backend xong, ban se them:

- `lib/services/api_client.dart`
- `lib/repositories/api_guide_repository.dart`
- `lib/repositories/api_tour_repository.dart`
- `lib/repositories/api_search_repository.dart`
- `lib/repositories/api_destination_repository.dart`
- `lib/repositories/api_attraction_repository.dart`
- `lib/repositories/api_my_trips_repository.dart`
- `lib/repositories/api_auth_repository.dart`

Va thay:
- `MockGuideRepository` -> `ApiGuideRepository`
- `MockTourRepository` -> `ApiTourRepository`
- `MockSearchRepository` -> `ApiSearchRepository`
- `MockDestinationRepository` -> `ApiDestinationRepository`
- `MockAttractionRepository` -> `ApiAttractionRepository`
- `MockMyTripsRepository` -> `ApiMyTripsRepository`

## 19. Ban nen bat dau tu dau

Neu muon bat tay vao code ngay, hay bat dau tu day:

1. `backend/prisma/schema.prisma`
2. `backend/src/modules/auth/`
3. `backend/src/modules/guides/`
4. `backend/src/modules/tours/`

Do la bo nho nhat de frontend co the bat dau noi API that.
