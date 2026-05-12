import '../models/search_filter_model.dart';
import '../models/search_results_model.dart';
import '../services/api_services.dart';
import 'api_repository_mappers.dart';
import 'search_repository.dart';

class ApiSearchRepository implements SearchRepository {
  const ApiSearchRepository();

  @override
  Future<SearchResultsModel> search({
    required String destination,
    SearchFilterModel? filter,
  }) async {
    final params = <String, String>{
      'destination': destination,
      if ((filter?.date ?? '').isNotEmpty) 'date': filter!.date!,
      if ((filter?.fee ?? '').isNotEmpty) 'fee': filter!.fee!,
      if ((filter?.languages ?? const []).isNotEmpty)
        'languages': filter!.languages.join(','),
      if (filter != null) 'tab': filter.selectedTab == 0 ? 'guides' : 'tours',
    };
    final query = Uri(queryParameters: params).query;
    final response = await ApiService.get('/search?$query');
    final data = asMap(response['data']);
    return SearchResultsModel(
      guides: asList(data['guides']).map(mapGuide).toList(),
      tours: asList(data['tours']).map(mapTour).toList(),
    );
  }
}
