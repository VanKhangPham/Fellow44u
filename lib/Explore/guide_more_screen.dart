import 'package:flutter/material.dart';

import '../models/guide_model.dart';
import '../repositories/guide_repository.dart';
import '../repositories/mock_guide_repository.dart';
import '../search/search.dart';
import 'explore_more_header.dart';
import 'guide_detail_screen.dart';

class GuideMoreScreen extends StatefulWidget {
  const GuideMoreScreen({
    super.key,
    this.repository = const MockGuideRepository(),
  });

  final GuideRepository repository;

  @override
  State<GuideMoreScreen> createState() => _GuideMoreScreenState();
}

class _GuideMoreScreenState extends State<GuideMoreScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _background = Color(0xFFFDFDFD);
  static const String _heroAsset =
      'assets/images/home_guide_more/536d2c710563ff68867dc5f6481dcfafe2bfeb33.png';

  late Future<List<GuideModel>> _guidesFuture;

  @override
  void initState() {
    super.initState();
    _guidesFuture = widget.repository.fetchAllGuides();
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
        child: FutureBuilder<List<GuideModel>>(
          future: _guidesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(color: _primary),
              );
            }

            final guides = snapshot.data ?? const <GuideModel>[];
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                ExploreMoreHeader(
                  heroAsset: _heroAsset,
                  title: 'Book your own private local Guide and explore the city',
                  onBack: () => Navigator.of(context).pop(),
                  onSearchTap: () => _openSearch(context),
                ),
                const SizedBox(height: 10),
                _buildGuidesGrid(context, guides),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildGuidesGrid(BuildContext context, List<GuideModel> guides) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: guides.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 20,
          mainAxisExtent: 242,
        ),
        itemBuilder: (context, index) {
          final guide = guides[index];
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
                                '${guide.reviewsCount} Reviews',
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
