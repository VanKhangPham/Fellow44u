class GuideExperienceDetailModel {
  const GuideExperienceDetailModel({
    required this.leftImagePath,
    required this.rightTopImagePath,
    required this.rightBottomImagePath,
    required this.title,
    required this.location,
    required this.dateLabel,
    required this.likesLabel,
  });

  final String leftImagePath;
  final String rightTopImagePath;
  final String rightBottomImagePath;
  final String title;
  final String location;
  final String dateLabel;
  final String likesLabel;
}
