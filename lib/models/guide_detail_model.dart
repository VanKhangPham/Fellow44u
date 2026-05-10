import 'guide_experience_detail_model.dart';
import 'guide_model.dart';
import 'guide_review_model.dart';

class GuideDetailModel {
  const GuideDetailModel({
    required this.guide,
    required this.headerImagePath,
    required this.mediaPreviewPath,
    required this.languages,
    required this.shortIntroduction,
    required this.experiences,
    required this.reviews,
  });

  final GuideModel guide;
  final String headerImagePath;
  final String mediaPreviewPath;
  final List<String> languages;
  final String shortIntroduction;
  final List<GuideExperienceDetailModel> experiences;
  final List<GuideReviewModel> reviews;
}
