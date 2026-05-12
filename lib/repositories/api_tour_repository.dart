import '../models/tour_detail_model.dart';
import '../models/tour_model.dart';
import '../services/api_services.dart';
import 'api_repository_mappers.dart';
import 'tour_repository.dart';

class ApiTourRepository implements TourRepository {
  const ApiTourRepository();

  @override
  Future<List<TourModel>> fetchAllTours() async {
    final response = await ApiService.get('/tours');
    return asList(response['data']).map(mapTour).toList();
  }

  @override
  Future<List<TourModel>> fetchFeaturedTours() async {
    final response = await ApiService.get('/tours?featured=true&limit=4');
    return asList(response['data']).map(mapTour).toList();
  }

  @override
  Future<TourDetailModel?> fetchTourDetail(String tourId) async {
    final response = await ApiService.get('/tours/$tourId');
    final data = response['data'];
    if (data == null) {
      return null;
    }
    return mapTourDetail(data);
  }
}
