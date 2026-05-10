import 'guide_model.dart';
import 'tour_model.dart';

class SearchResultsModel {
  const SearchResultsModel({
    required this.guides,
    required this.tours,
  });

  final List<GuideModel> guides;
  final List<TourModel> tours;
}
