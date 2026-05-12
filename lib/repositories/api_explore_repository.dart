import '../models/explore_home_data.dart';
import '../services/api_services.dart';
import 'api_repository_mappers.dart';
import 'explore_repository.dart';

class ApiExploreRepository implements ExploreRepository {
  const ApiExploreRepository();

  @override
  Future<ExploreHomeData> fetchHomeData() async {
    final response = await ApiService.get('/explore/home');
    final data = asMap(response['data']);
    return ExploreHomeData(
      journeys: asList(data['journeys']).map(mapJourney).toList(),
      guides: asList(data['guides']).map(mapGuide).toList(),
      experiences: asList(data['experiences']).map(mapExperience).toList(),
      featuredTours: asList(data['featuredTours']).map(mapTour).toList(),
      news: asList(data['news']).map(mapNews).toList(),
    );
  }
}
