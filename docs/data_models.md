# Fellow4U Data Models

## Muc tieu

Tai lieu nay chot cac entity chinh truoc khi thiet ke repository, API contract va database.

## Nguyen tac modeling

- Uu tien model phuc vu man hinh hien co trong `lib/`
- Tach `Trip` cua nguoi dung khoi `Tour` du lich san co
- `Guide` va `User` co quan he nhung khong bat buoc gop chung o ban MVP
- Dung `status` de tai su dung API cho `current`, `next`, `past`

## 1. User

Dung cho dang nhap, dang ky, thong tin tai khoan hien tai.

### Fields toi thieu

- `id`: string
- `fullName`: string
- `email`: string
- `role`: enum `traveler | guide | admin`
- `avatarUrl`: string?
- `country`: string?
- `phoneNumber`: string?
- `createdAt`: datetime
- `updatedAt`: datetime

### Ghi chu

- UI hien tai dang cho chon role o `SignUpScreen`
- MVP co the uu tien `traveler`, nhung van nen giu field `role`

## 2. AuthSession

Dung cho luong dang nhap va luu token.

### Fields toi thieu

- `accessToken`: string
- `refreshToken`: string?
- `expiresAt`: datetime?
- `user`: `User`

## 3. Guide

Dung cho `ExploreScreen`, `GuideMoreScreen`, `GuideDetailScreen`, `SearchResultsScreen`.

### Fields toi thieu

- `id`: string
- `name`: string
- `avatarUrl`: string
- `coverImageUrl`: string?
- `location`: string
- `city`: string
- `country`: string
- `languages`: list of string
- `rating`: double
- `reviewsCount`: int
- `bio`: string
- `isAvailable`: bool

### Fields mo rong neu can

- `yearsOfExperience`: int?
- `priceFrom`: number?
- `specialties`: list of string
- `gallery`: list of string

## 4. GuideExperience

Dung cho phan `My Experiences` trong `GuideDetailScreen`.

### Fields toi thieu

- `id`: string
- `guideId`: string
- `title`: string
- `location`: string
- `imageUrl`: string
- `shortDescription`: string?

## 5. GuideReview

Dung cho phan reviews cua guide.

### Fields toi thieu

- `id`: string
- `guideId`: string
- `userName`: string
- `userAvatarUrl`: string?
- `rating`: int
- `comment`: string
- `createdAt`: datetime

## 6. Tour

Dung cho `ExploreScreen`, `TourMoreScreen`, `SearchResultsScreen`, `TourDetailScreen`, `Wishlist`.

### Fields toi thieu

- `id`: string
- `title`: string
- `coverImageUrl`: string
- `description`: string?
- `price`: number
- `oldPrice`: number?
- `durationLabel`: string
- `departureDateLabel`: string
- `departurePlace`: string
- `provider`: string
- `itinerary`: string
- `likesCount`: int
- `rating`: double
- `reviewsCount`: int
- `isBookmarked`: bool
- `isLiked`: bool

### Fields mo rong neu can

- `gallery`: list of string
- `scheduleDays`: list of `TourScheduleDay`

## 7. TourScheduleDay

Dung cho lich trinh chi tiet trong `TourDetailScreen`.

### Fields toi thieu

- `dayNumber`: int
- `title`: string
- `activities`: list of `TourScheduleItem`

## 8. TourScheduleItem

### Fields toi thieu

- `timeLabel`: string
- `content`: string

## 9. Attraction

Dung cho `CreateNewTripScreen`, `TripInformationScreen`, `NewAttractionsScreen`.

### Fields toi thieu

- `id`: string
- `name`: string
- `city`: string
- `imageUrl`: string?
- `description`: string?
- `isSuggested`: bool

## 10. Trip

Dung cho tao chuyen di va danh sach `My Trips`.

### Fields toi thieu

- `id`: string
- `userId`: string
- `title`: string?
- `city`: string
- `date`: date
- `fromTime`: string
- `toTime`: string
- `travelerCount`: int
- `guideLanguagePreferences`: list of string
- `attractions`: list of `Attraction`
- `status`: enum `current | next | past | cancelled`
- `guideId`: string?
- `guideName`: string?
- `price`: number?
- `createdAt`: datetime
- `updatedAt`: datetime

### Ghi chu

- `wishlist` khong nen la `Trip`
- `current`, `next`, `past` la nhieu trang thai cua cung mot entity `Trip`

## 11. TripOffer

Can neu giu logic guide gui offer cho trip cua traveler.

### Fields toi thieu

- `id`: string
- `tripId`: string
- `guideId`: string
- `guideName`: string
- `message`: string?
- `price`: number?
- `status`: enum `pending | accepted | rejected`
- `createdAt`: datetime

## 12. WishlistItem

Dung cho tab `Wish List` trong `MyTripsCurrentScreen`.

### Fields toi thieu

- `id`: string
- `userId`: string
- `tourId`: string
- `createdAt`: datetime

## 13. SearchFilter

Dung cho `SearchResultsScreen` va bottom sheet filter.

### Fields toi thieu

- `keyword`: string?
- `city`: string?
- `startDate`: date?
- `endDate`: date?
- `minPrice`: number?
- `maxPrice`: number?
- `category`: enum `guide | tour | all`

## 14. TravelNews

Chi can neu muon giu phan `Travel News` bang du lieu that.

### Fields toi thieu

- `id`: string
- `title`: string
- `imageUrl`: string
- `publishedAt`: datetime
- `summary`: string?

## Quan he chinh giua cac model

- `User` 1-n `Trip`
- `User` 1-n `WishlistItem`
- `Guide` 1-n `GuideExperience`
- `Guide` 1-n `GuideReview`
- `Guide` 0-n `Trip`
- `Trip` n-n `Attraction`
- `Trip` 1-n `TripOffer`
- `Tour` co the duoc luu boi `WishlistItem`

## Mapping nhanh voi code hien tai

- `Guide`: `ExploreScreen`, `GuideMoreScreen`, `GuideDetailScreen`, `SearchResultsScreen`
- `Tour`: `ExploreScreen`, `TourMoreScreen`, `TourDetailScreen`, `SearchResultsScreen`, `MyTripsCurrentScreen`
- `Trip`: `CreateNewTripScreen`, `TripInformationScreen`, `MyTripsCurrentScreen`
- `Attraction`: `NewAttractionsScreen`, `CreateNewTripScreen`, `TripInformationScreen`
- `SearchFilter`: `SearchResultsScreen`

## Model nen tao truoc trong Flutter

De frontend tach khoi hard-code, nen tao truoc cac model Dart sau:

- `user_model.dart`
- `guide_model.dart`
- `tour_model.dart`
- `trip_model.dart`
- `attraction_model.dart`
- `wishlist_item_model.dart`
- `search_filter_model.dart`
