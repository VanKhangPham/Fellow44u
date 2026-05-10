class GuideModel {
  const GuideModel({
    required this.id,
    required this.name,
    required this.avatarPath,
    required this.location,
    required this.city,
    required this.country,
    required this.languages,
    required this.rating,
    required this.reviewsCount,
    required this.bio,
    this.coverImagePath,
    this.isAvailable = true,
  });

  final String id;
  final String name;
  final String avatarPath;
  final String location;
  final String city;
  final String country;
  final List<String> languages;
  final double rating;
  final int reviewsCount;
  final String bio;
  final String? coverImagePath;
  final bool isAvailable;
}
