import 'tour_model.dart';
import 'tour_schedule_day_model.dart';

class TourDetailModel {
  const TourDetailModel({
    required this.tour,
    required this.headerImagePath,
    required this.reviewsCount,
    required this.scheduleDays,
  });

  final TourModel tour;
  final String headerImagePath;
  final int reviewsCount;
  final List<TourScheduleDayModel> scheduleDays;
}
