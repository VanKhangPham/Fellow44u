import '../data/mock/mock_explore_data.dart';
import '../models/explore_home_data.dart';
import 'explore_repository.dart';

class MockExploreRepository implements ExploreRepository {
  const MockExploreRepository();

  @override
  Future<ExploreHomeData> fetchHomeData() {
    return Future.value(mockExploreHomeData);
  }
}
