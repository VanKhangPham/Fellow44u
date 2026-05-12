import '../models/guide_detail_model.dart';
import '../models/guide_model.dart';
import '../services/api_services.dart';
import 'api_repository_mappers.dart';
import 'guide_repository.dart';

class ApiGuideRepository implements GuideRepository {
  const ApiGuideRepository();

  @override
  Future<List<GuideModel>> fetchAllGuides() async {
    final response = await ApiService.get('/guides');
    return asList(response['data']).map(mapGuide).toList();
  }

  @override
  Future<List<GuideModel>> fetchFeaturedGuides() async {
    final response = await ApiService.get('/guides?featured=true&limit=4');
    return asList(response['data']).map(mapGuide).toList();
  }

  @override
  Future<GuideDetailModel?> fetchGuideDetail(String guideId) async {
    final response = await ApiService.get('/guides/$guideId');
    final data = response['data'];
    if (data == null) {
      return null;
    }
    return mapGuideDetail(data);
  }
}
