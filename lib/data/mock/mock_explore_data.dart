import '../../models/explore_home_data.dart';
import '../../models/experience_model.dart';
import '../../models/journey_model.dart';
import '../../models/travel_news_model.dart';
import 'mock_guides_data.dart';
import 'mock_tours_data.dart';

final mockExploreHomeData = ExploreHomeData(
  journeys: [
    JourneyModel(
      id: 'journey-danang',
      imagePath:
          'assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png',
      title: 'Da Nang - Ba Na - Hoi An',
      dateLabel: 'Jan 30, 2020',
      durationLabel: '3 days',
      priceLabel: '\$400.00',
      likesLabel: '1247 likes',
      isBookmarked: true,
    ),
    JourneyModel(
      id: 'journey-thailand',
      imagePath:
          'assets/images/explore/905442573fa7cf367c66678ad47feb95cf9517c1.jpg',
      title: 'Thailand',
      dateLabel: 'Jan 30, 2020',
      durationLabel: '3 days',
      priceLabel: '\$600.00',
      likesLabel: '1247 likes',
    ),
  ],
  guides: mockGuides,
  experiences: [
    ExperienceModel(
      id: 'experience-hoian-bike',
      imagePath:
          'assets/images/explore/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg',
      guideAvatarPath:
          'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      title: '2 Hour Bicycle Tour\nexploring Hoian',
      location: 'Hoian, Vietnam',
      guideName: 'Tuan Tran',
    ),
    ExperienceModel(
      id: 'experience-bana-hill',
      imagePath:
          'assets/images/explore/744f85922de533c19555ae4c251ce3dec7041419.png',
      guideAvatarPath:
          'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      title: '1 day at Bana Hill',
      location: 'Bana, Vietnam',
      guideName: 'Linh Hana',
    ),
  ],
  featuredTours: mockTours,
  news: [
    TravelNewsModel(
      id: 'news-danang-destination',
      title: 'New Destination in Danang City',
      dateLabel: 'Feb 5, 2020',
      imagePath:
          'assets/images/explore/42751d9e220fe7ee14bf95a97b59825a368e47d5.jpg',
    ),
    TravelNewsModel(
      id: 'news-one-dollar-flight',
      title: '\$1 Flight Ticket',
      dateLabel: 'Feb 5, 2020',
      imagePath:
          'assets/images/explore/36be4ecb191058ba8705bba356eae55efd52bf66.png',
    ),
    TravelNewsModel(
      id: 'news-visit-korea',
      title: 'Visit Korea in this Tet Holiday',
      dateLabel: 'Jan 26, 2020',
      imagePath:
          'assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png',
    ),
  ],
);
