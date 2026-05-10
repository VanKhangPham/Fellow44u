class WishlistTripModel {
  const WishlistTripModel({
    required this.id,
    required this.coverAsset,
    required this.title,
    required this.dateLabel,
    required this.daysLabel,
    required this.priceLabel,
    required this.likesLabel,
    this.isLiked = false,
    this.isBookmarked = true,
  });

  final String id;
  final String coverAsset;
  final String title;
  final String dateLabel;
  final String daysLabel;
  final String priceLabel;
  final String likesLabel;
  final bool isLiked;
  final bool isBookmarked;
}
