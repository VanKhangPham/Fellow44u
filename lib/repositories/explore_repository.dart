import '../models/explore_home_data.dart';

abstract class ExploreRepository {
  const ExploreRepository();

  Future<ExploreHomeData> fetchHomeData();
}
