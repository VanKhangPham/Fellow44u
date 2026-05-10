import '../data/mock/mock_guides_data.dart';
import '../models/guide_detail_model.dart';
import '../models/guide_model.dart';
import 'guide_repository.dart';

class MockGuideRepository implements GuideRepository {
  const MockGuideRepository();

  @override
  Future<List<GuideModel>> fetchAllGuides() {
    return Future.value(mockGuides);
  }

  @override
  Future<GuideDetailModel?> fetchGuideDetail(String guideId) {
    return Future.value(mockGuideDetails[guideId]);
  }

  @override
  Future<List<GuideModel>> fetchFeaturedGuides() {
    return Future.value(mockGuides.take(4).toList());
  }
}
