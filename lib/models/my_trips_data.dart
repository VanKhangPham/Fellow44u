import 'my_current_trip_model.dart';
import 'my_next_trip_model.dart';
import 'my_past_trip_model.dart';
import 'wishlist_trip_model.dart';

class MyTripsData {
  const MyTripsData({
    required this.currentTrip,
    required this.nextTrips,
    required this.pastTrips,
    required this.wishlistTrips,
  });

  final MyCurrentTripModel currentTrip;
  final List<MyNextTripModel> nextTrips;
  final List<MyPastTripModel> pastTrips;
  final List<WishlistTripModel> wishlistTrips;
}
