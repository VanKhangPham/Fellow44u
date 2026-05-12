import '../data/mock/mock_attractions_data.dart';
import '../models/attraction_model.dart';
import 'attraction_repository.dart';

class MockAttractionRepository implements AttractionRepository {
  const MockAttractionRepository();

  @override
  Future<List<AttractionModel>> fetchSuggestedAttractions() {
    return Future.value(
      mockAttractions.where((item) => item.isSuggested).toList(),
    );
  }

  @override
  Future<List<AttractionModel>> searchAttractions(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return fetchSuggestedAttractions();
    }
    return Future.value(
      mockAttractions
          .where((item) => item.name.toLowerCase().contains(normalized))
          .toList(),
    );
  }
}
