import 'package:flutter/material.dart';

import '../Trip/trip_information_screen.dart';
import '../models/guide_detail_model.dart';
import '../models/guide_experience_detail_model.dart';
import '../models/guide_review_model.dart';
import '../repositories/api_guide_repository.dart';
import '../repositories/guide_repository.dart';

class GuideDetailScreen extends StatefulWidget {
  const GuideDetailScreen({
    super.key,
    required this.guideId,
    this.repository = const ApiGuideRepository(),
  });

  final String guideId;
  final GuideRepository repository;

  @override
  State<GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends State<GuideDetailScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _chipBackground = Color(0xFFF3F3F3);

  late Future<GuideDetailModel?> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = widget.repository.fetchGuideDetail(widget.guideId);
  }

  void _reload() {
    setState(() {
      _detailFuture = widget.repository.fetchGuideDetail(widget.guideId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<GuideDetailModel?>(
          future: _detailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(color: _primary),
              );
            }
            if (snapshot.hasError) {
              return _buildErrorState();
            }

            final detail = snapshot.data;
            if (detail == null) {
              return const Center(
                child: Text(
                  'Guide details unavailable',
                  style: TextStyle(color: _textPrimary),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(context, detail)),
                SliverToBoxAdapter(
                  child: _buildProfileSection(context, detail),
                ),
                SliverToBoxAdapter(child: _buildMediaPreview(detail)),
                SliverToBoxAdapter(child: _buildRateTable()),
                SliverToBoxAdapter(child: _buildSectionTitle('My Experiences')),
                SliverToBoxAdapter(
                  child: _buildExperienceCards(detail.experiences),
                ),
                SliverToBoxAdapter(child: _buildSectionTitle('Reviews')),
                SliverToBoxAdapter(child: _buildReviews(detail.reviews)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GuideDetailModel detail) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Image.asset(detail.headerImagePath, fit: BoxFit.cover),
        ),
        Positioned(
          left: 12,
          top: 12,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        ),
        Positioned(
          left: 16,
          bottom: -28,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: CircleAvatar(
              radius: 38,
              backgroundImage: AssetImage(detail.guide.avatarPath),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Unable to load guide details.',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _reload,
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

  Widget _buildProfileSection(BuildContext context, GuideDetailModel detail) {
    final guide = detail.guide;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guide.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: _textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (_) => const Icon(
                            Icons.star,
                            color: Color(0xFFFFC107),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${guide.reviewsCount} Reviews',
                          style: const TextStyle(
                            fontSize: 16,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TripInformationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'CHOOSE THIS GUIDE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: detail.languages
                .map((language) => _LanguageChip(label: language))
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: _primary, size: 20),
              const SizedBox(width: 4),
              Text(
                guide.location,
                style: const TextStyle(
                  fontSize: 16,
                  color: _primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            detail.shortIntroduction,
            style: const TextStyle(
              fontSize: 14,
              color: _textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildMediaPreview(GuideDetailModel detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.35,
              child: Image.asset(detail.mediaPreviewPath, fit: BoxFit.cover),
            ),
            Container(color: const Color.fromRGBO(0, 0, 0, 0.22)),
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.88),
              child: Icon(Icons.play_arrow, size: 30, color: _primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRateTable() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _RateRow(label: 'Response', value: '5.0'),
            _RateRow(label: 'Knowledge', value: '4.9'),
            _RateRow(label: 'Service', value: '5.0'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 14),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: _textPrimary,
        ),
      ),
    );
  }

  Widget _buildExperienceCards(List<GuideExperienceDetailModel> experiences) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: experiences
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _ExperienceDetailCard(item: item),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildReviews(List<GuideReviewModel> reviews) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: reviews
            .map(
              (review) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _ReviewTile(review: review),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _GuideDetailScreenState._chipBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: _GuideDetailScreenState._textPrimary,
        ),
      ),
    );
  }
}

class _RateRow extends StatelessWidget {
  const _RateRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _GuideDetailScreenState._primary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: _GuideDetailScreenState._textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ExperienceDetailCard extends StatelessWidget {
  const _ExperienceDetailCard({required this.item});

  final GuideExperienceDetailModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      item.leftImagePath,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            item.rightTopImagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            item.rightBottomImagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _GuideDetailScreenState._textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: _GuideDetailScreenState._primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _GuideDetailScreenState._primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      item.dateLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _GuideDetailScreenState._textSecondary,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border,
                      color: _GuideDetailScreenState._primary,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.likesLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _GuideDetailScreenState._textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final GuideReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(review.avatarPath),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _GuideDetailScreenState._textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(
                        review.rating,
                        (_) => const Icon(
                          Icons.star,
                          size: 15,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        review.dateLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          color: _GuideDetailScreenState._textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          review.review,
          style: const TextStyle(
            fontSize: 14,
            color: _GuideDetailScreenState._textPrimary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
