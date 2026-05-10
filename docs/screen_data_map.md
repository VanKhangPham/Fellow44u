# Fellow4U Screen Data Map

## Muc tieu

Tai lieu nay map tung man hinh voi du lieu can doc / ghi de lam co so cho:

- Tach mock data khoi UI
- Tao repository
- Thiet ke API contract
- Tinh toan loading / error / empty state

## 1. SplashScreen

### Muc dich

- Hien splash
- Dieu huong vao onboarding

### Du lieu can doc

- Khong bat buoc o MVP UI demo
- Neu lam that: trang thai dang nhap, token hop le hay khong

### Du lieu can ghi

- Khong

## 2. OnboardingScreen / OnboardingToursScreen / OnboardingOffersScreen

### Muc dich

- Gioi thieu app

### Du lieu can doc

- Khong bat buoc

### Du lieu can ghi

- Co the luu `hasSeenOnboarding`

## 3. SignInScreen

### Muc dich

- Dang nhap vao he thong

### Input

- `email`
- `password`

### Output can doc

- `AuthSession`
- `User`

### Xu ly can co

- Validation form
- Loading state
- Error state khi sai thong tin dang nhap

## 4. SignUpScreen

### Muc dich

- Tao tai khoan moi

### Input

- `role`
- `firstName`
- `lastName`
- `country`
- `email`
- `password`
- `confirmPassword`

### Output can doc

- Ket qua dang ky
- Co the tra ve `AuthSession` neu app auto login

## 5. ForgotPasswordScreen

### Muc dich

- Gui yeu cau quen mat khau

### Input

- `email`

### Output can doc

- Trang thai gui email thanh cong / that bai

## 6. CheckEmailScreen

### Muc dich

- Xac nhan da gui email reset

### Du lieu can doc

- Khong bat buoc

### Du lieu can ghi

- Khong

## 7. ExploreScreen

### Muc dich

- Trang chu kham pha

### Du lieu can doc

- `featuredGuides`
- `featuredTours`
- `topJourneys`
- `topExperiences`
- `travelNews` neu con giu section nay

### Du lieu can ghi

- Hanh dong bookmark / like neu bat dau ho tro tu backend

### Repository de xai sau

- `GuideRepository`
- `TourRepository`
- `NewsRepository` neu can

## 8. ExploreSearchModal

### Muc dich

- Tim kiem nhanh theo diem den

### Du lieu can doc

- `popularDestinations`
- ket qua search destination

### Du lieu can ghi

- `keyword`

## 9. SearchResultsScreen

### Muc dich

- Hien ket qua guides va tours theo diem den / tu khoa

### Input

- `destination`

### Du lieu can doc

- danh sach `Guide`
- danh sach `Tour`
- `SearchFilter`

### Du lieu can ghi

- `keyword`
- filter date
- filter fee
- tab dang chon `guide` / `tour`

### Ghi chu

- Hien tai file nay vua giu UI vua giu mock data va filter state
- Nen tach ra thanh model filter + repository search

## 10. GuideMoreScreen

### Muc dich

- Hien nhieu guide hon tu `Explore`

### Du lieu can doc

- danh sach `Guide`

### Du lieu can ghi

- Khong bat buoc

## 11. GuideDetailScreen

### Muc dich

- Hien chi tiet 1 guide

### Input

- `guideId`

### Du lieu can doc

- `Guide`
- `GuideExperience[]`
- `GuideReview[]`

### Du lieu can ghi

- Co the tao request dat guide / chuyen sang `TripInformationScreen`

### Ghi chu

- Hien tai man nay truyen `name`, `imagePath`, `location` truc tiep
- Ban that nen chuyen sang nhan `guideId`

## 12. TourMoreScreen

### Muc dich

- Hien danh sach tour mo rong

### Du lieu can doc

- danh sach `Tour`

### Du lieu can ghi

- bookmark / like neu co

## 13. TourDetailScreen

### Muc dich

- Hien chi tiet 1 tour

### Input

- `tourId`

### Du lieu can doc

- `Tour`
- `TourScheduleDay[]`

### Du lieu can ghi

- bookmark / like
- action book tour

### Ghi chu

- Hien tai man nay truyen nhieu field truc tiep tu man truoc
- Ban that nen chuyen sang nhan `tourId`

## 14. ShareBottomSheet

### Muc dich

- Chia se tour

### Du lieu can doc

- link / metadata cua tour neu sau nay can

### Du lieu can ghi

- Khong bat buoc backend trong MVP

## 15. CreateNewTripScreen

### Muc dich

- Tao trip moi

### Input

- `date`
- `fromTime`
- `toTime`
- `travelerCount`
- `fee`
- `selectedLanguages`
- `selectedAttractions`

### Du lieu can doc

- `Attraction[]`
- `Guide languages`

### Du lieu can ghi

- `Trip`

### Ghi chu

- `fee` hien co trong UI, can quyet dinh day la:
- `budget` cua traveler
- hoac `expected fee`

## 16. TripInformationScreen

### Muc dich

- Nhap thong tin trip de dat guide

### Input

- `date`
- `fromTime`
- `toTime`
- `city`
- `travelerCount`
- `selectedAttractions`

### Du lieu can doc

- `Attraction[]`

### Du lieu can ghi

- `Trip`
- co the tao `TripOfferRequest`

## 17. NewAttractionsScreen

### Muc dich

- Tim va chon attractions

### Input

- `initialSelection`

### Du lieu can doc

- `Attraction[]`
- ket qua search attraction

### Du lieu can ghi

- `selectedAttractions`

## 18. MyTripsCurrentScreen

### Muc dich

- Quan ly `current`, `next`, `past`, `wishList`

### Du lieu can doc

- `Trip[]` voi filter `current`
- `Trip[]` voi filter `next`
- `Trip[]` voi filter `past`
- `WishlistItem[]` + thong tin `Tour`

### Du lieu can ghi

- bookmark / wishlist
- accept offer / pay / chat neu sau nay lam that

### Ghi chu

- Man nay dang gom rat nhieu du lieu demo cung mot file
- Nen tach thanh `TripRepository` + `WishlistRepository`

## Bang tong hop repository can co truoc API

### Auth

- `AuthRepository`

### Explore / Search

- `GuideRepository`
- `TourRepository`
- `SearchRepository`
- `DestinationRepository`

### Trips

- `TripRepository`
- `AttractionRepository`
- `WishlistRepository`

### Optional

- `NewsRepository`

## Bang tong hop model can tao truoc

- `User`
- `AuthSession`
- `Guide`
- `GuideExperience`
- `GuideReview`
- `Tour`
- `TourScheduleDay`
- `TourScheduleItem`
- `Trip`
- `TripOffer`
- `Attraction`
- `WishlistItem`
- `SearchFilter`

## Uu tien thuc hien tiep theo

1. Tao `lib/models/` cho `Guide`, `Tour`, `Trip`, `Attraction`
2. Tao `lib/data/mock/` de chuyen du lieu mau ra khoi UI
3. Tao interface repository
4. Refactor `ExploreScreen`
5. Refactor `SearchResultsScreen`
6. Refactor `MyTripsCurrentScreen`
7. Sau do moi viet `docs/api_contract.md`
