import 'package:flutter/material.dart';

import '../search/search.dart';
import 'explore_more_header.dart';
import 'guide_detail_screen.dart';

class GuideMoreScreen extends StatelessWidget {
  const GuideMoreScreen({super.key});

  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _background = Color(0xFFFDFDFD);

  static const String _heroAsset =
      'assets/images/home_guide_more/536d2c710563ff68867dc5f6481dcfafe2bfeb33.png';

  static const List<_GuideMoreItem> _guides = [
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      name: 'Tuan Tran',
      location: 'Danang, Vietnam',
      reviews: '127 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
      name: 'Emmy',
      location: 'Hanoi, Vietnam',
      reviews: '129 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      name: 'Linh Hana',
      location: 'Danang, Vietnam',
      reviews: '127 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
      name: 'Khai Ho',
      location: 'Ho Chi Minh, Vietnam',
      reviews: '127 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      name: 'Tuan Tran',
      location: 'Danang, Vietnam',
      reviews: '127 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
      name: 'Emmy',
      location: 'Hanoi, Vietnam',
      reviews: '129 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      name: 'Linh Hana',
      location: 'Danang, Vietnam',
      reviews: '127 Reviews',
    ),
    _GuideMoreItem(
      imagePath:
          'assets/images/home_guide_more/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
      name: 'Khai Ho',
      location: 'Ho Chi Minh, Vietnam',
      reviews: '127 Reviews',
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
              title: 'Book your own private local Guide and explore the city',
              onBack: () => Navigator.of(context).pop(),
              onSearchTap: () => _openSearch(context),
            ),
            const SizedBox(height: 10),
            _buildGuidesGrid(context),
            Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                6,
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

  Widget _buildGuidesGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _guides.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 20,
          mainAxisExtent: 242,
        ),
        itemBuilder: (context, index) {
          final guide = _guides[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GuideDetailScreen(
                    name: guide.name,
                    imagePath: guide.imagePath,
                    location: guide.location,
                  ),
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
                        guide.imagePath,
                        width: double.infinity,
                        height: 164,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [
                                Color.fromRGBO(0, 0, 0, 0),
                                Color.fromRGBO(0, 0, 0, 0.1),
                                Color.fromRGBO(0, 0, 0, 0.42),
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
                            ...List.generate(
                              5,
                              (_) => const Icon(
                                Icons.star,
                                color: Color(0xFFFFC107),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                guide.reviews,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  guide.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: _primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        guide.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _primary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GuideMoreItem {
  const _GuideMoreItem({
    required this.imagePath,
    required this.name,
    required this.location,
    required this.reviews,
  });

  final String imagePath;
  final String name;
  final String location;
  final String reviews;
}
