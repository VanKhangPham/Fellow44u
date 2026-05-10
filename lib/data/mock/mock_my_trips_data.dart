import '../../models/my_current_trip_model.dart';
import '../../models/my_next_trip_model.dart';
import '../../models/my_past_trip_model.dart';
import '../../models/my_trips_data.dart';
import '../../models/wishlist_trip_model.dart';

const myTripsCurrentHeaderAsset =
    'assets/images/my_trips_current/2a4028cfda3cda6d2d71eef70a4cdc292c82b02c.png';
const myTripsCurrentCheckAsset = 'assets/images/my_trips_current/Vector.png';
const myTripsCurrentCalendarAsset =
    'assets/images/my_trips_current/Frame 26.png';
const myTripsCurrentClockAsset = 'assets/images/my_trips_current/Frame 37.png';
const myTripsCurrentPersonAsset = 'assets/images/my_trips_current/Group.png';

const mockMyTripsData = MyTripsData(
  currentTrip: MyCurrentTripModel(
    coverAsset:
        'assets/images/my_trips_current/51414a035e8038967a7f919ee4da7a5fcf080c96.jpg',
    title: 'Dragon Bridge Trip',
    location: 'Da Nang, Vietnam',
    dateLabel: 'Jan 30, 2020',
    timeLabel: '13:00 - 15:00',
    guideName: 'Tuan Tran',
    guideAvatarAsset:
        'assets/images/my_trips_current/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
  ),
  nextTrips: [
    MyNextTripModel(
      id: 'next-ho-guom',
      coverAsset:
          'assets/images/my_trips_next/960a939280f3f36fc0c105ffe4ad31d968ac6451.png',
      title: 'Ho Guom Trip',
      location: 'Hanoi, Vietnam',
      dateLabel: 'Feb 2, 2020',
      timeLabel: '8:00 - 10:00',
      guideLabel: 'Emmy',
      avatars: [
        'assets/images/my_trips_next/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
      ],
      canChooseAnotherGuide: true,
      showChat: true,
      showPay: true,
    ),
    MyNextTripModel(
      id: 'next-mausoleum',
      coverAsset:
          'assets/images/my_trips_next/accb51ccbb0a22aae14c9e1af900ffe62bc5f983.png',
      title: 'Ho Chi Minh Mausoleum',
      location: 'Hanoi, Vietnam',
      dateLabel: 'Feb 2, 2020',
      timeLabel: '8:00 - 10:00',
      guideLabel: 'Emmy',
      avatars: [
        'assets/images/my_trips_next/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
      ],
      canChooseAnotherGuide: true,
      statusLabel: 'Waiting',
    ),
    MyNextTripModel(
      id: 'next-duc-ba',
      coverAsset:
          'assets/images/my_trips_next/a4ac4c80eecaa270b09aca98f13878ecf0eaca85.jpg',
      title: 'Duc Ba Church',
      location: 'Ho Chi Minh, Vietnam',
      dateLabel: 'Feb 2, 2020',
      timeLabel: '8:00 - 10:00',
      guideLabel: 'Waiting for offers',
      avatars: [
        'assets/images/my_trips_next/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
        'assets/images/my_trips_next/f70235434dd80443d892bdaed7f8c67bdf755753.jpg',
      ],
      statusLabel: 'Bidding',
      extraCount: 3,
      showChat: true,
    ),
  ],
  pastTrips: [
    MyPastTripModel(
      id: 'past-temple',
      coverAsset:
          'assets/images/my_trips_past/0270b73aa10450750a134687fa6ecfa0700ef0ef.jpg',
      title: 'Quoc Tu Giam Temple',
      location: 'Hanoi, Vietnam',
      dateLabel: 'Feb 2, 2020',
      timeLabel: '8:00 - 10:00',
      guideLabel: 'Emmy',
      avatarAsset:
          'assets/images/my_trips_past/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
    ),
    MyPastTripModel(
      id: 'past-palace',
      coverAsset:
          'assets/images/my_trips_past/b529f8c33726fe420d25c7305deae6b5c3852207.jpg',
      title: 'Dinh Doc Lap',
      location: 'Ho Chi Minh, Vietnam',
      dateLabel: 'Feb 2, 2020',
      timeLabel: '8:00 - 10:00',
      guideLabel: 'Khai Ho',
      avatarAsset:
          'assets/images/my_trips_past/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
    ),
  ],
  wishlistTrips: [
    WishlistTripModel(
      id: 'wish-melbourne',
      coverAsset:
          'assets/images/my_trips_wishlist/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
      title: 'Melbourne - Sydney',
      dateLabel: 'Jan 30, 2020',
      daysLabel: '3 days',
      priceLabel: '\$600.00',
      likesLabel: '1247 likes',
      isLiked: true,
      isBookmarked: true,
    ),
    WishlistTripModel(
      id: 'wish-halong',
      coverAsset:
          'assets/images/my_trips_wishlist/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
      title: 'Hanoi - Ha Long Bay',
      dateLabel: 'Jan 30, 2020',
      daysLabel: '3 days',
      priceLabel: '\$300.00',
      likesLabel: '1247 likes',
      isLiked: false,
      isBookmarked: true,
    ),
  ],
);
