import '../models/destination_model.dart';

abstract class DestinationRepository {
  const DestinationRepository();

  Future<List<DestinationModel>> fetchPopularDestinations();

  Future<List<DestinationModel>> searchDestinations(String query);
}
