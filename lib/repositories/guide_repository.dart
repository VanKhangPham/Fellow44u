import '../models/guide_detail_model.dart';
import '../models/guide_model.dart';

abstract class GuideRepository {
  const GuideRepository();

  Future<List<GuideModel>> fetchFeaturedGuides();

  Future<List<GuideModel>> fetchAllGuides();

  Future<GuideDetailModel?> fetchGuideDetail(String guideId);
}
