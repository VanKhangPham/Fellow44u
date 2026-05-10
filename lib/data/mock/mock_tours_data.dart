import '../../models/tour_detail_model.dart';
import '../../models/tour_model.dart';
import '../../models/tour_schedule_day_model.dart';
import '../../models/tour_schedule_entry_model.dart';

const mockTours = [
  TourModel(
    id: 'tour-danang-bana-hoian',
    coverImagePath:
        'assets/images/explore/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
    title: 'Da Nang - Ba Na - Hoi An',
    dateLabel: 'Jan 30, 2020',
    durationLabel: '3 days',
    priceLabel: '\$400.00',
    oldPriceLabel: '\$450.00',
    likesLabel: '1247 likes',
    provider: 'dulichviet',
    itinerary: 'Da Nang - Ba Na - Hoi An',
    durationDetail: '2 days, 2 nights',
    departureDateLabel: 'Feb 12',
    departurePlace: 'Ho Chi Minh',
  ),
  TourModel(
    id: 'tour-melbourne-sydney',
    coverImagePath:
        'assets/images/explore/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
    title: 'Melbourne - Sydney',
    dateLabel: 'Jan 30, 2020',
    durationLabel: '3 days',
    priceLabel: '\$600.00',
    oldPriceLabel: '\$680.00',
    likesLabel: '1247 likes',
    provider: 'southerntour',
    itinerary: 'Melbourne - Sydney',
    durationDetail: '4 days, 3 nights',
    departureDateLabel: 'Mar 05',
    departurePlace: 'Melbourne',
    isLiked: true,
  ),
  TourModel(
    id: 'tour-hanoi-halong',
    coverImagePath:
        'assets/images/explore/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
    title: 'Hanoi - Ha Long Bay',
    dateLabel: 'Jan 30, 2020',
    durationLabel: '3 days',
    priceLabel: '\$300.00',
    oldPriceLabel: '\$350.00',
    likesLabel: '1247 likes',
    provider: 'vietravel',
    itinerary: 'Hanoi - Ha Long Bay',
    durationDetail: '2 days, 1 night',
    departureDateLabel: 'Apr 20',
    departurePlace: 'Hanoi',
  ),
];

final mockTourDetails = {
  'tour-danang-bana-hoian': TourDetailModel(
    tour: mockTours[0],
    headerImagePath: 'assets/images/tour_detail/670301139 1.png',
    reviewsCount: 145,
    scheduleDays: const [
      TourScheduleDayModel(
        label: 'Day 1',
        entries: [
          TourScheduleEntryModel(
            timeLabel: '08:00',
            description: 'Meet at departure point and transfer to Da Nang.',
          ),
          TourScheduleEntryModel(
            timeLabel: '12:00',
            description: 'Lunch and check-in.',
          ),
        ],
      ),
      TourScheduleDayModel(
        label: 'Day 2',
        entries: [
          TourScheduleEntryModel(
            timeLabel: '09:00',
            description: 'Explore Ba Na Hills and Golden Bridge.',
          ),
          TourScheduleEntryModel(
            timeLabel: '15:00',
            description: 'Travel to Hoi An for evening walk.',
          ),
        ],
      ),
    ],
  ),
  'tour-melbourne-sydney': TourDetailModel(
    tour: mockTours[1],
    headerImagePath: 'assets/images/tour_detail/670301139 1.png',
    reviewsCount: 145,
    scheduleDays: const [
      TourScheduleDayModel(
        label: 'Day 1',
        entries: [
          TourScheduleEntryModel(
            timeLabel: '09:00',
            description: 'Arrive in Melbourne and city orientation.',
          ),
        ],
      ),
      TourScheduleDayModel(
        label: 'Day 2',
        entries: [
          TourScheduleEntryModel(
            timeLabel: '10:00',
            description: 'Transfer to Sydney with afternoon free time.',
          ),
        ],
      ),
    ],
  ),
  'tour-hanoi-halong': TourDetailModel(
    tour: mockTours[2],
    headerImagePath: 'assets/images/tour_detail/670301139 1.png',
    reviewsCount: 145,
    scheduleDays: const [
      TourScheduleDayModel(
        label: 'Day 1',
        entries: [
          TourScheduleEntryModel(
            timeLabel: '08:30',
            description: 'Depart from Hanoi to Ha Long Bay.',
          ),
        ],
      ),
      TourScheduleDayModel(
        label: 'Day 2',
        entries: [
          TourScheduleEntryModel(
            timeLabel: '11:00',
            description: 'Cruise activities and return to Hanoi.',
          ),
        ],
      ),
    ],
  ),
};
