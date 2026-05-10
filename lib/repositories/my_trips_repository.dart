import '../models/my_trips_data.dart';

abstract class MyTripsRepository {
  const MyTripsRepository();

  Future<MyTripsData> fetchMyTrips();
}
