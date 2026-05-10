# Fellow4U MVP Scope

## Muc tieu

Ban MVP cua `fellow4u` can chuyen app tu bo UI demo sang app co du lieu that o nhung luong chinh:

- Dang nhap / dang ky
- Kham pha guide va tour
- Tim kiem theo diem den
- Xem chi tiet guide / tour
- Tao chuyen di
- Quan ly danh sach chuyen di cua nguoi dung
- Luu danh sach yeu thich

## Man hinh hien co trong codebase

### Nhom Splash / Onboarding / Auth

- `SplashScreen`
- `OnboardingScreen`
- `OnboardingToursScreen`
- `OnboardingOffersScreen`
- `SignInScreen`
- `SignUpScreen`
- `ForgotPasswordScreen`
- `CheckEmailScreen`

### Nhom Explore / Search

- `ExploreScreen`
- `GuideMoreScreen`
- `TourMoreScreen`
- `GuideDetailScreen`
- `SearchResultsScreen`
- `ExploreSearchModal`
- `FilterBottomSheet`

### Nhom Trip / My Trips

- `CreateNewTripScreen`
- `TripInformationScreen`
- `NewAttractionsScreen`
- `MyTripsCurrentScreen`

### Nhom Tour / Shared UI

- `TourDetailScreen`
- `ShareBottomSheet`

## Pham vi MVP de lam that

### Lam trong MVP

- `SignInScreen`
- `SignUpScreen`
- `ForgotPasswordScreen`
- `ExploreScreen`
- `GuideMoreScreen`
- `TourMoreScreen`
- `GuideDetailScreen`
- `SearchResultsScreen`
- `ExploreSearchModal`
- `CreateNewTripScreen`
- `TripInformationScreen`
- `NewAttractionsScreen`
- `MyTripsCurrentScreen`
- `TourDetailScreen`

### Giu lai nhung tam thoi chi la UI / demo

- `SplashScreen`
- `OnboardingScreen`
- `OnboardingToursScreen`
- `OnboardingOffersScreen`
- `CheckEmailScreen`
- `ShareBottomSheet`

## Tinh nang nen hoan thanh trong MVP

### Auth

- Dang nhap bang email + password
- Dang ky tai khoan traveler
- Dang ky tai khoan guide neu can giu theo UI hien tai
- Quen mat khau o muc co ban
- Lay thong tin nguoi dung hien tai sau khi dang nhap

### Explore / Search

- Lay danh sach guide noi bat
- Lay danh sach tour noi bat
- Xem danh sach guide mo rong
- Xem danh sach tour mo rong
- Tim kiem guide / tour theo tu khoa va diem den
- Loc ket qua tim kiem co ban

### Guide / Tour Detail

- Lay chi tiet guide
- Lay chi tiet tour
- Hien thi danh sach language, rating, reviews, mo ta
- Hien thi thong tin lich trinh, gia, noi khoi hanh

### Trips

- Tao chuyen di moi
- Chon attraction
- Xem danh sach trip theo trang thai
- Quan ly `current`, `next`, `past`
- Quan ly `wishlist`

## Tinh nang chua can lam that trong MVP

- Chat that
- Notification that
- Share that ra ngoai app
- Thanh toan that
- Reviews / comments that
- Social login
- CMS / quan tri noi dung
- News du lieu that neu backend chua co

## Gia dinh nghiep vu de giu scope gon

- MVP uu tien role `traveler`
- Guide co the duoc luu va hien thi nhu du lieu da ton tai
- `My Trips` co the dung mot endpoint voi filter theo `status`
- `Wishlist` tach rieng voi `Trips`
- `Travel News` co the tam an hoac dung mock data

## Thu tu uu tien sau MVP scope

1. Chot data models
2. Map man hinh voi du lieu
3. Tach mock data khoi UI
4. Tao repository interface / mock repository
5. Viet API contract
6. Moi bat dau code backend API
