import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Explore/guide_detail_screen.dart';
import '../Tour_Detail/tour_detail_screen.dart';
import '../models/guide_model.dart';
import '../models/search_filter_model.dart';
import '../models/search_results_model.dart';
import '../models/tour_model.dart';
import '../repositories/api_search_repository.dart';
import '../repositories/search_repository.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({
    super.key,
    required this.destination,
    this.searchRepository = const ApiSearchRepository(),
  });

  final String destination;
  final SearchRepository searchRepository;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF8A8A8A);
  static const Color _background = Color(0xFFF9F9F9);
  static const Color _cardShadow = Color.fromRGBO(0, 0, 0, 0.08);

  late final TextEditingController _searchController;
  late Future<SearchResultsModel> _resultsFuture;
  SearchFilterModel _activeFilter = const SearchFilterModel();
  final Set<String> _likedTourIds = <String>{};
  final Set<String> _bookmarkedTourIds = <String>{};

  String get _displayDestination {
    final query = _searchController.text.trim();
    return query.isEmpty ? widget.destination : query;
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.destination);
    _resultsFuture = _loadResults();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<SearchResultsModel> _loadResults() {
    return widget.searchRepository.search(
      destination: _displayDestination,
      filter: _activeFilter,
    );
  }

  void _reloadResults() {
    setState(() {
      _resultsFuture = _loadResults();
    });
  }

  Future<void> _showFilterDialog() async {
    final filter = await showModalBottomSheet<SearchFilterModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FilterBottomSheet(initialFilter: _activeFilter),
    );
    if (filter == null) {
      return;
    }
    _activeFilter = filter;
    _reloadResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: FutureBuilder<SearchResultsModel>(
          future: _resultsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(color: _primary),
              );
            }

            if (snapshot.hasError) {
              return _buildErrorState();
            }

            final results =
                snapshot.data ??
                const SearchResultsModel(guides: [], tours: []);

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
              children: [
                _buildTopBar(),
                const SizedBox(height: 24),
                _buildSearchBarRow(),
                const SizedBox(height: 28),
                _buildSectionTitle('Guides in $_displayDestination'),
                const SizedBox(height: 18),
                _buildGuidesGrid(results.guides),
                const SizedBox(height: 28),
                _buildSectionTitle('Tours in $_displayDestination'),
                const SizedBox(height: 18),
                _buildToursList(results.tours),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Unable to load search results.',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _reloadResults,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        splashRadius: 22,
        icon: const Icon(Icons.close, size: 28, color: _textPrimary),
      ),
    );
  }

  Widget _buildSearchBarRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: _cardShadow,
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    cursorColor: _primary,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Where you want to explore',
                      hintStyle: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    onSubmitted: (_) => _reloadResults(),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      _reloadResults();
                    },
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB8B8B8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        GestureDetector(
          onTap: _showFilterDialog,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              'assets/images/search/Vector.svg',
              width: 22,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuidesGrid(List<GuideModel> guides) {
    if (guides.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text('No guides found', style: TextStyle(color: _textSecondary)),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: guides.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,
        mainAxisExtent: 238,
      ),
      itemBuilder: (context, index) => _buildGuideCard(guides[index]),
    );
  }

  Widget _buildGuideCard(GuideModel guide) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GuideDetailScreen(guideId: guide.id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                Image.asset(
                  guide.avatarPath,
                  width: double.infinity,
                  height: 165,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0),
                          Colors.black.withValues(alpha: 0.18),
                          Colors.black.withValues(alpha: 0.36),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Row(
                    children: [
                      ..._buildStars(size: 15),
                      const SizedBox(width: 6),
                      Text(
                        '${guide.reviewsCount} Reviews',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            guide.name,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: _primary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  guide.location,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToursList(List<TourModel> tours) {
    if (tours.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text('No tours found', style: TextStyle(color: _textSecondary)),
      );
    }

    return Column(
      children: List.generate(tours.length, (index) {
        final tour = tours[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index == tours.length - 1 ? 0 : 18),
          child: _buildTourCard(tour),
        );
      }),
    );
  }

  Widget _buildTourCard(TourModel tour) {
    final isBookmarked =
        _bookmarkedTourIds.contains(tour.id) || tour.isBookmarked;
    final isLiked = _likedTourIds.contains(tour.id) || tour.isLiked;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TourDetailScreen(tourId: tour.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: _cardShadow, blurRadius: 16, offset: Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    tour.coverImagePath,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.06),
                            Colors.black.withValues(alpha: 0),
                            Colors.black.withValues(alpha: 0.35),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isBookmarked) {
                            _bookmarkedTourIds.remove(tour.id);
                          } else {
                            _bookmarkedTourIds.add(tour.id);
                          }
                        });
                      },
                      child: Icon(
                        isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_rounded,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 10,
                    child: Row(
                      children: [
                        ..._buildStars(),
                        const SizedBox(width: 8),
                        Text(
                          tour.likesLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          tour.title,
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isLiked) {
                              _likedTourIds.remove(tour.id);
                            } else {
                              _likedTourIds.add(tour.id);
                            }
                          });
                        },
                        child: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: _primary,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTourMetaRow(
                    icon: Icons.calendar_today_outlined,
                    label: tour.dateLabel,
                  ),
                  const SizedBox(height: 7),
                  _buildTourMetaRow(
                    icon: Icons.access_time,
                    label: tour.durationLabel,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      tour.priceLabel,
                      style: const TextStyle(
                        color: _primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTourMetaRow({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFFB1B1B1)),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildStars({double size = 14}) {
    return List<Widget>.generate(
      5,
      (_) => Icon(Icons.star, size: size, color: const Color(0xFFFFC107)),
    );
  }
}

class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet({required this.initialFilter});

  final SearchFilterModel initialFilter;

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  static const _languages = ['English', 'Vietnamese', 'Korean', 'Japanese'];

  late int _selectedTab;
  late TextEditingController _dateController;
  late TextEditingController _feeController;
  late Set<String> _selectedLanguages;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialFilter.selectedTab;
    _dateController = TextEditingController(text: widget.initialFilter.date);
    _feeController = TextEditingController(text: widget.initialFilter.fee);
    _selectedLanguages = {...widget.initialFilter.languages};
  }

  @override
  void dispose() {
    _dateController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _apply() {
    Navigator.of(context).pop(
      SearchFilterModel(
        selectedTab: _selectedTab,
        date: _dateController.text.trim(),
        fee: _feeController.text.trim(),
        languages: _selectedLanguages.toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Filter Search',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xFF212121),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0
                              ? const Color(0xFF00C7A7)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedTab == 1
                              ? Border.all(color: const Color(0xFFE0E0E0))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Guides',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _selectedTab == 0
                                  ? Colors.white
                                  : const Color(0xFF212121),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1
                              ? const Color(0xFF00C7A7)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedTab == 0
                              ? Border.all(color: const Color(0xFFE0E0E0))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Tours',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _selectedTab == 1
                                  ? Colors.white
                                  : const Color(0xFF212121),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: 'mm/dd/yy',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Guide's Language",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _languages.map((lang) {
                  final isSelected = _selectedLanguages.contains(lang);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedLanguages.remove(lang);
                        } else {
                          _selectedLanguages.add(lang);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF00C7A7)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF00C7A7)
                              : const Color(0xFFE0E0E0),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        lang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF212121),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Fee',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _feeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Fee',
                  prefixIcon: Icon(
                    Icons.attach_money,
                    size: 18,
                    color: Color(0xFF9E9E9E),
                  ),
                  suffixText: '(\$/hour)',
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _apply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C7A7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'APPLY FILTERS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
