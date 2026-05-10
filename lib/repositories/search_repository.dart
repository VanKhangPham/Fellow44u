import '../models/search_filter_model.dart';
import '../models/search_results_model.dart';

abstract class SearchRepository {
  const SearchRepository();

  Future<SearchResultsModel> search({
    required String destination,
    SearchFilterModel? filter,
  });
}
