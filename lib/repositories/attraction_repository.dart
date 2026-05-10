import '../models/attraction_model.dart';

abstract class AttractionRepository {
  const AttractionRepository();

  Future<List<AttractionModel>> fetchSuggestedAttractions();

  Future<List<AttractionModel>> searchAttractions(String query);
}
