class TourModel {
  const TourModel({
    required this.id,
    required this.title,
    required this.coverImagePath,
    required this.dateLabel,
    required this.durationLabel,
    required this.priceLabel,
    required this.likesLabel,
    required this.provider,
    required this.itinerary,
    required this.durationDetail,
    required this.departureDateLabel,
    required this.departurePlace,
    this.oldPriceLabel,
    this.description,
    this.rating = 5,
    this.reviewsCount = 0,
    this.isLiked = false,
    this.isBookmarked = false,
  });

  final String id;
  final String title;
  final String coverImagePath;
  final String dateLabel;
  final String durationLabel;
  final String priceLabel;
  final String? oldPriceLabel;
  final String likesLabel;
  final String provider;
  final String itinerary;
  final String durationDetail;
  final String departureDateLabel;
  final String departurePlace;
  final String? description;
  final double rating;
  final int reviewsCount;
  final bool isLiked;
  final bool isBookmarked;
}
