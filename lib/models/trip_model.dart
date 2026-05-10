class TripModel {
  const TripModel({
    required this.id,
    required this.userId,
    required this.city,
    required this.dateLabel,
    required this.fromTimeLabel,
    required this.toTimeLabel,
    required this.travelerCount,
    required this.status,
    this.title,
    this.guideId,
    this.guideName,
    this.priceLabel,
    this.guideLanguagePreferences = const [],
    this.attractionIds = const [],
  });

  final String id;
  final String userId;
  final String city;
  final String dateLabel;
  final String fromTimeLabel;
  final String toTimeLabel;
  final int travelerCount;
  final String status;
  final String? title;
  final String? guideId;
  final String? guideName;
  final String? priceLabel;
  final List<String> guideLanguagePreferences;
  final List<String> attractionIds;
}
