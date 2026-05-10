class MyPastTripModel {
  const MyPastTripModel({
    required this.id,
    required this.coverAsset,
    required this.title,
    required this.location,
    required this.dateLabel,
    required this.timeLabel,
    required this.guideLabel,
    required this.avatarAsset,
  });

  final String id;
  final String coverAsset;
  final String title;
  final String location;
  final String dateLabel;
  final String timeLabel;
  final String guideLabel;
  final String avatarAsset;
}
