import '../models/destination_model.dart';
import '../services/api_services.dart';
import 'api_repository_mappers.dart';
import 'destination_repository.dart';

class ApiDestinationRepository implements DestinationRepository {
  const ApiDestinationRepository();

  @override
  Future<List<DestinationModel>> fetchPopularDestinations() async {
    final response = await ApiService.get('/destinations/popular');
    return asList(response['data']).map(mapDestination).toList();
  }

  @override
  Future<List<DestinationModel>> searchDestinations(String query) async {
    final endpoint = query.trim().isEmpty
        ? '/destinations/popular'
        : '/destinations/search?q=${Uri.encodeQueryComponent(query)}';
    final response = await ApiService.get(endpoint);
    return asList(response['data']).map(mapDestination).toList();
  }
}
