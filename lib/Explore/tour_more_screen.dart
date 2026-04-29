import 'package:flutter/material.dart';

import '../Tour_Detail/tour_detail_screen.dart';
import '../search/search.dart';
import 'explore_more_header.dart';

class TourMoreScreen extends StatefulWidget {
  const TourMoreScreen({super.key});

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

  late final List<_TourMoreItem> _tours = [
    _TourMoreItem(
      imagePath:
          'assets/images/home_tour_more/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
      title: 'Da Nang - Ba Na - Hoi An',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$400.00',
      oldPrice: '\$450.00',
      likes: '1247 likes',
      provider: 'dulichviet',
      itinerary: 'Da Nang - Ba Na - Hoi An',
      duration: '2 days, 2 nights',
      departureDate: 'Feb 12',
      departurePlace: 'Ho Chi Minh',
    ),
    _TourMoreItem(
      imagePath:
          'assets/images/home_tour_more/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
      title: 'Melbourne - Sydney',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$600.00',
      oldPrice: '\$680.00',
      likes: '1247 likes',
      liked: true,
      provider: 'southerntour',
      itinerary: 'Melbourne - Sydney',
      duration: '4 days, 3 nights',
      departureDate: 'Mar 05',
      departurePlace: 'Melbourne',
    ),
    _TourMoreItem(
      imagePath:
          'assets/images/home_tour_more/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
      title: 'Hanoi - Ha Long Bay',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$300.00',
      oldPrice: '\$350.00',
      likes: '1247 likes',
      bookmarked: true,
      provider: 'vietravel',
      itinerary: 'Hanoi - Ha Long Bay',
      duration: '2 days, 1 night',
      departureDate: 'Apr 20',
      departurePlace: 'Hanoi',
    ),
    _TourMoreItem(
      imagePath:
          'assets/images/home_tour_more/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
      title: 'Da Nang - Ba Na - Hoi An',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$400.00',
      oldPrice: '\$450.00',
      likes: '1247 likes',
      provider: 'dulichviet',
      itinerary: 'Da Nang - Ba Na - Hoi An',
      duration: '2 days, 2 nights',
      departureDate: 'Feb 12',
      departurePlace: 'Ho Chi Minh',
    ),
    _TourMoreItem(
      imagePath:
          'assets/images/home_tour_more/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
      title: 'Melbourne - Sydney',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$600.00',
      oldPrice: '\$680.00',
      likes: '1247 likes',
      liked: true,
      provider: 'southerntour',
      itinerary: 'Melbourne - Sydney',
      duration: '4 days, 3 nights',
      departureDate: 'Mar 05',
      departurePlace: 'Melbourne',
    ),
    _TourMoreItem(
      imagePath:
          'assets/images/home_tour_more/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
      title: 'Hanoi - Ha Long Bay',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$300.00',
      oldPrice: '\$350.00',
      likes: '1247 likes',
      bookmarked: true,
      provider: 'vietravel',
      itinerary: 'Hanoi - Ha Long Bay',
      duration: '2 days, 1 night',
      departureDate: 'Apr 20',
      departurePlace: 'Hanoi',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: ListView(
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
                children: List.generate(_tours.length, (index) {
                  final tour = _tours[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == _tours.length - 1 ? 0 : 18,
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
        ),
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ExploreSearchModal(),
    );
  }

  Widget _buildTourCard(BuildContext context, _TourMoreItem tour) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TourDetailScreen(
              title: tour.title,
              price: tour.price,
              oldPrice: tour.oldPrice,
              provider: tour.provider,
              itinerary: tour.itinerary,
              duration: tour.duration,
              departureDate: tour.departureDate,
              departurePlace: tour.departurePlace,
            ),
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
                    tour.imagePath,
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
                      onTap: () => setState(() {
                        tour.bookmarked = !tour.bookmarked;
                      }),
                      child: Icon(
                        tour.bookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_rounded,
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
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tour.likes,
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
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
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
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => setState(() {
                          tour.liked = !tour.liked;
                        }),
                        child: Icon(
                          tour.liked
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: _primary,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  _buildMetaRow(
                    icon: Icons.calendar_today_outlined,
                    label: tour.date,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetaRow(
                          icon: Icons.access_time,
                          label: tour.days,
                        ),
                      ),
                      Text(
                        tour.price,
                        style: const TextStyle(
                          color: _primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
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

  Widget _buildMetaRow({
    required IconData icon,
    required String label,
  }) {
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
}

class _TourMoreItem {
  _TourMoreItem({
    required this.imagePath,
    required this.title,
    required this.date,
    required this.days,
    required this.price,
    required this.likes,
    required this.provider,
    required this.itinerary,
    required this.duration,
    required this.departureDate,
    required this.departurePlace,
    this.oldPrice = '',
    this.liked = false,
    this.bookmarked = false,
  });

  final String imagePath;
  final String title;
  final String date;
  final String days;
  final String price;
  final String likes;
  final String oldPrice;
  final String provider;
  final String itinerary;
  final String duration;
  final String departureDate;
  final String departurePlace;
  bool liked;
  bool bookmarked;
}
