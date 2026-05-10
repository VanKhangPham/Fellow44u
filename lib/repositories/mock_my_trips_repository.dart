import '../data/mock/mock_my_trips_data.dart';
import '../models/my_trips_data.dart';
import 'my_trips_repository.dart';

class MockMyTripsRepository implements MyTripsRepository {
  const MockMyTripsRepository();

  @override
  Future<MyTripsData> fetchMyTrips() {
    return Future.value(mockMyTripsData);
  }
}
