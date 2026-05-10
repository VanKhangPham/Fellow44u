class SearchFilterModel {
  const SearchFilterModel({
    this.selectedTab = 0,
    this.date,
    this.languages = const [],
    this.fee,
  });

  final int selectedTab;
  final String? date;
  final List<String> languages;
  final String? fee;
}
