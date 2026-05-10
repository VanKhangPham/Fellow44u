import '../../models/guide_detail_model.dart';
import '../../models/guide_experience_detail_model.dart';
import '../../models/guide_model.dart';
import '../../models/guide_review_model.dart';

const mockGuides = [
  GuideModel(
    id: 'guide-tuan-tran',
    name: 'Tuan Tran',
    avatarPath:
        'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
    location: 'Danang, Vietnam',
    city: 'Danang',
    country: 'Vietnam',
    languages: ['Vietnamese', 'English', 'Korean'],
    rating: 5,
    reviewsCount: 127,
    bio: 'Local guide in Danang.',
  ),
  GuideModel(
    id: 'guide-emmy',
    name: 'Emmy',
    avatarPath:
        'assets/images/explore/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
    location: 'Hanoi, Vietnam',
    city: 'Hanoi',
    country: 'Vietnam',
    languages: ['Vietnamese', 'English'],
    rating: 5,
    reviewsCount: 129,
    bio: 'Local guide in Hanoi.',
  ),
  GuideModel(
    id: 'guide-linh-hana',
    name: 'Linh Hana',
    avatarPath:
        'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
    location: 'Danang, Vietnam',
    city: 'Danang',
    country: 'Vietnam',
    languages: ['Vietnamese', 'English'],
    rating: 5,
    reviewsCount: 127,
    bio: 'Local guide in Danang.',
  ),
  GuideModel(
    id: 'guide-khai-ho',
    name: 'Khai Ho',
    avatarPath:
        'assets/images/explore/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
    location: 'Ho Chi Minh, Vietnam',
    city: 'Ho Chi Minh',
    country: 'Vietnam',
    languages: ['Vietnamese', 'English'],
    rating: 5,
    reviewsCount: 127,
    bio: 'Local guide in Ho Chi Minh City.',
  ),
];

final mockGuideDetails = {
  'guide-tuan-tran': GuideDetailModel(
    guide: mockGuides[0],
    headerImagePath:
        'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
    mediaPreviewPath:
        'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
    languages: const ['Vietnamese', 'English', 'Korean'],
    shortIntroduction:
        'Short introduction: Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    experiences: const [
      GuideExperienceDetailModel(
        leftImagePath:
            'assets/images/guide_page/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg',
        rightTopImagePath:
            'assets/images/guide_page/c7a25670e7ba19408b7e776b363d6705858a5598.jpg',
        rightBottomImagePath:
            'assets/images/guide_page/8e041ef05fef946a59bcf7b4931c2de56d77b715.jpg',
        title: '2 Hour Bicycle Tour exploring Hoian',
        location: 'Hoian, Vietnam',
        dateLabel: 'Jan 30, 2020',
        likesLabel: '1247 likes',
      ),
      GuideExperienceDetailModel(
        leftImagePath:
            'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg',
        rightTopImagePath:
            'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg',
        rightBottomImagePath:
            'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg',
        title: 'Street food and city walk',
        location: 'Danang, Vietnam',
        dateLabel: 'Feb 2, 2020',
        likesLabel: '890 likes',
      ),
    ],
    reviews: const [
      GuideReviewModel(
        avatarPath:
            'assets/images/guide_page/1019aa9fca01d6bce807cf74fe90b3b71c995634.png',
        name: 'Jenny Wilson',
        dateLabel: 'Jan 30, 2020',
        review: 'Amazing guide and very friendly.',
      ),
      GuideReviewModel(
        avatarPath:
            'assets/images/guide_page/959746cd629042b29a8f93f90bd29f83e5401423.png',
        name: 'Esther Howard',
        dateLabel: 'Feb 3, 2020',
        review: 'The trip was well organized and fun.',
      ),
      GuideReviewModel(
        avatarPath:
            'assets/images/guide_page/c7b8b5b6cc0c7f882d307811b73f983fdd7235b8.png',
        name: 'Jacob Jones',
        dateLabel: 'Feb 6, 2020',
        review: 'Great local tips and smooth communication.',
      ),
    ],
  ),
  'guide-emmy': GuideDetailModel(
    guide: mockGuides[1],
    headerImagePath:
        'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
    mediaPreviewPath:
        'assets/images/explore/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
    languages: const ['Vietnamese', 'English'],
    shortIntroduction:
        'Friendly local guide with experience leading city walks in Hanoi.',
    experiences: const [
      GuideExperienceDetailModel(
        leftImagePath:
            'assets/images/guide_page/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg',
        rightTopImagePath:
            'assets/images/guide_page/c7a25670e7ba19408b7e776b363d6705858a5598.jpg',
        rightBottomImagePath:
            'assets/images/guide_page/8e041ef05fef946a59bcf7b4931c2de56d77b715.jpg',
        title: 'Old Quarter discovery',
        location: 'Hanoi, Vietnam',
        dateLabel: 'Feb 5, 2020',
        likesLabel: '760 likes',
      ),
    ],
    reviews: const [
      GuideReviewModel(
        avatarPath:
            'assets/images/guide_page/1019aa9fca01d6bce807cf74fe90b3b71c995634.png',
        name: 'Leslie Alexander',
        dateLabel: 'Feb 1, 2020',
        review: 'Helpful and punctual guide.',
      ),
    ],
  ),
  'guide-linh-hana': GuideDetailModel(
    guide: mockGuides[2],
    headerImagePath:
        'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
    mediaPreviewPath:
        'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
    languages: const ['Vietnamese', 'English'],
    shortIntroduction:
        'Experienced guide focused on mountain and nature experiences.',
    experiences: const [
      GuideExperienceDetailModel(
        leftImagePath:
            'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg',
        rightTopImagePath:
            'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg',
        rightBottomImagePath:
            'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg',
        title: 'Ba Na Hills full day',
        location: 'Danang, Vietnam',
        dateLabel: 'Mar 3, 2020',
        likesLabel: '930 likes',
      ),
    ],
    reviews: const [
      GuideReviewModel(
        avatarPath:
            'assets/images/guide_page/959746cd629042b29a8f93f90bd29f83e5401423.png',
        name: 'Courtney Henry',
        dateLabel: 'Feb 10, 2020',
        review: 'Clear communication and very professional.',
      ),
    ],
  ),
  'guide-khai-ho': GuideDetailModel(
    guide: mockGuides[3],
    headerImagePath:
        'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
    mediaPreviewPath:
        'assets/images/explore/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
    languages: const ['Vietnamese', 'English'],
    shortIntroduction:
        'Ho Chi Minh local guide with a focus on food and historical places.',
    experiences: const [
      GuideExperienceDetailModel(
        leftImagePath:
            'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg',
        rightTopImagePath:
            'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg',
        rightBottomImagePath:
            'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg',
        title: 'History and food combo',
        location: 'Ho Chi Minh, Vietnam',
        dateLabel: 'Mar 14, 2020',
        likesLabel: '680 likes',
      ),
    ],
    reviews: const [
      GuideReviewModel(
        avatarPath:
            'assets/images/guide_page/c7b8b5b6cc0c7f882d307811b73f983fdd7235b8.png',
        name: 'Ralph Edwards',
        dateLabel: 'Feb 14, 2020',
        review: 'A nice balance of local culture and sightseeing.',
      ),
    ],
  ),
};
