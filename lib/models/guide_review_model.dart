class GuideReviewModel {
  const GuideReviewModel({
    required this.avatarPath,
    required this.name,
    required this.dateLabel,
    required this.review,
    this.rating = 5,
  });

  final String avatarPath;
  final String name;
  final String dateLabel;
  final String review;
  final int rating;
}
