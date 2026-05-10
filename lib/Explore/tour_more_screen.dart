import 'package:flutter/material.dart';

import '../Tour_Detail/tour_detail_screen.dart';
import '../models/tour_model.dart';
import '../repositories/mock_tour_repository.dart';
import '../repositories/tour_repository.dart';
import '../search/search.dart';
import 'explore_more_header.dart';

class TourMoreScreen extends StatefulWidget {
  const TourMoreScreen({
    super.key,
    this.repository = const MockTourRepository(),
  });

  final TourRepository repository;

  @override
  State<TourMoreScreen> createState() => _TourMoreScreenState();
}

class _TourMoreScreenState extends State<TourMoreScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF6F6F6F);
  static const Color _background = Color(0xFFFDFDFD);
  static const String _heroAsset =
      'assets/images/home_tour_more/536d2c710563ff68867dc5f6481dcfafe2bfeb33.png';

  late Future<List<TourModel>> _toursFuture;
  final Set<String> _bookmarkedTourIds = <String>{};

  @override
  void initState() {
    super.initState();
    _toursFuture = widget.repository.fetchAllTours();
  }

  void _openSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ExploreSearchModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<List<TourModel>>(
          future: _toursFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(color: _primary),
              );
            }

            final tours = snapshot.data ?? const <TourModel>[];
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                ExploreMoreHeader(
                  heroAsset: _heroAsset,
                  title: 'Plenty of amazing tours are waiting for you',
                  onBack: () => Navigator.of(context).pop(),
                  onSearchTap: () => _openSearch(context),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: List.generate(tours.length, (index) {
                      final tour = tours[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == tours.length - 1 ? 0 : 18,
                        ),
                        child: _buildTourCard(context, tour),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    10,
                    16,
                    bottomInset > 0 ? bottomInset + 12 : 24,
                  ),
                  child: const ExploreMoreIndicator(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTourCard(BuildContext context, TourModel tour) {
    final isBookmarked =
        _bookmarkedTourIds.contains(tour.id) || tour.isBookmarked;

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
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Stack(
                children: [
                  Image.asset(
                    tour.coverImagePath,
                    width: double.infinity,
                    height: 138,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: const [
                            Color.fromRGBO(0, 0, 0, 0.04),
                            Color.fromRGBO(0, 0, 0, 0),
                            Color.fromRGBO(0, 0, 0, 0.34),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
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
                            : Icons.bookmark_border_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 10,
                    child: Row(
                      children: [
                        ...List.generate(
                          5,
                          (_) => const Icon(
                            Icons.star,
                            color: Color(0xFFFFC107),
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tour.likesLabel,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tour.title,
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        tour.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: _primary,
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildMetaRow(
                    icon: Icons.calendar_today_outlined,
                    label: tour.dateLabel,
                  ),
                  const SizedBox(height: 6),
                  _buildMetaRow(
                    icon: Icons.access_time,
                    label: tour.durationLabel,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (tour.oldPriceLabel != null)
                        Text(
                          tour.oldPriceLabel!,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: _textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      const Spacer(),
                      Text(
                        tour.priceLabel,
                        style: const TextStyle(
                          color: _primary,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF9E9E9E)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
