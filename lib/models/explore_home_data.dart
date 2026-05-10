import 'experience_model.dart';
import 'guide_model.dart';
import 'journey_model.dart';
import 'tour_model.dart';
import 'travel_news_model.dart';

class ExploreHomeData {
  const ExploreHomeData({
    required this.journeys,
    required this.guides,
    required this.experiences,
    required this.featuredTours,
    required this.news,
  });

  final List<JourneyModel> journeys;
  final List<GuideModel> guides;
  final List<ExperienceModel> experiences;
  final List<TourModel> featuredTours;
  final List<TravelNewsModel> news;
}
