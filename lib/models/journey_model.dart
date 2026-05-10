class JourneyModel {
  const JourneyModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.dateLabel,
    required this.durationLabel,
    required this.priceLabel,
    required this.likesLabel,
    this.isBookmarked = false,
  });

  final String id;
  final String imagePath;
  final String title;
  final String dateLabel;
  final String durationLabel;
  final String priceLabel;
  final String likesLabel;
  final bool isBookmarked;
}
