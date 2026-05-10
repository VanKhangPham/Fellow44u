import '../models/tour_detail_model.dart';
import '../models/tour_model.dart';

abstract class TourRepository {
  const TourRepository();

  Future<List<TourModel>> fetchFeaturedTours();

  Future<List<TourModel>> fetchAllTours();

  Future<TourDetailModel?> fetchTourDetail(String tourId);
}
