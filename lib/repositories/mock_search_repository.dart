import '../data/mock/mock_guides_data.dart';
import '../data/mock/mock_tours_data.dart';
import '../models/guide_model.dart';
import '../models/search_filter_model.dart';
import '../models/search_results_model.dart';
import '../models/tour_model.dart';
import 'search_repository.dart';

class MockSearchRepository implements SearchRepository {
  const MockSearchRepository();

  @override
  Future<SearchResultsModel> search({
    required String destination,
    SearchFilterModel? filter,
  }) {
    final query = destination.trim().toLowerCase();
    final guideResults = _filterGuides(query, filter);
    final tourResults = _filterTours(query);
    return Future.value(
      SearchResultsModel(guides: guideResults, tours: tourResults),
    );
  }

  List<GuideModel> _filterGuides(String query, SearchFilterModel? filter) {
    var items = mockGuides.where((guide) {
      if (query.isEmpty) {
        return true;
      }
      return guide.location.toLowerCase().contains(query) ||
          guide.city.toLowerCase().contains(query) ||
          guide.name.toLowerCase().contains(query);
    }).toList();

    if (filter != null && filter.languages.isNotEmpty) {
      items = items
          .where(
            (guide) => filter.languages.any(
              (language) => guide.languages.contains(language),
            ),
          )
          .toList();
    }

    return items;
  }

  List<TourModel> _filterTours(String query) {
    return mockTours.where((tour) {
      if (query.isEmpty) {
        return true;
      }
      return tour.title.toLowerCase().contains(query) ||
          tour.itinerary.toLowerCase().contains(query) ||
          tour.departurePlace.toLowerCase().contains(query);
    }).toList();
  }
}
