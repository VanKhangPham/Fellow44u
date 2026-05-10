class AttractionModel {
  const AttractionModel({
    required this.id,
    required this.name,
    required this.city,
    this.imagePath,
    this.description,
    this.isSuggested = false,
  });

  final String id;
  final String name;
  final String city;
  final String? imagePath;
  final String? description;
  final bool isSuggested;
}
