import '../data/mock/mock_destinations_data.dart';
import '../models/destination_model.dart';
import 'destination_repository.dart';

class MockDestinationRepository implements DestinationRepository {
  const MockDestinationRepository();

  @override
  Future<List<DestinationModel>> fetchPopularDestinations() {
    return Future.value(mockDestinations.take(3).toList());
  }

  @override
  Future<List<DestinationModel>> searchDestinations(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return fetchPopularDestinations();
    }
    return Future.value(
      mockDestinations
          .where((item) => item.name.toLowerCase().contains(normalized))
          .toList(),
    );
  }
}
