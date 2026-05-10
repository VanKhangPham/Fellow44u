class MyNextTripModel {
  const MyNextTripModel({
    required this.id,
    required this.coverAsset,
    required this.title,
    required this.location,
    required this.dateLabel,
    required this.timeLabel,
    required this.guideLabel,
    required this.avatars,
    this.canChooseAnotherGuide = false,
    this.statusLabel,
    this.extraCount,
    this.showChat = false,
    this.showPay = false,
  });

  final String id;
  final String coverAsset;
  final String title;
  final String location;
  final String dateLabel;
  final String timeLabel;
  final String guideLabel;
  final List<String> avatars;
  final bool canChooseAnotherGuide;
  final String? statusLabel;
  final int? extraCount;
  final bool showChat;
  final bool showPay;
}
