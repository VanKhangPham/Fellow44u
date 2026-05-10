import '../data/mock/mock_tours_data.dart';
import '../models/tour_detail_model.dart';
import '../models/tour_model.dart';
import 'tour_repository.dart';

class MockTourRepository implements TourRepository {
  const MockTourRepository();

  @override
  Future<List<TourModel>> fetchAllTours() {
    return Future.value(mockTours);
  }

  @override
  Future<List<TourModel>> fetchFeaturedTours() {
    return Future.value(mockTours);
  }

  @override
  Future<TourDetailModel?> fetchTourDetail(String tourId) {
    return Future.value(mockTourDetails[tourId]);
  }
}
