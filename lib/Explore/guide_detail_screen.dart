import 'package:flutter/material.dart';

import '../Trip/trip_information_screen.dart';

class GuideDetailScreen extends StatelessWidget {
  const GuideDetailScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.location,
  });

  final String name;
  final String imagePath;
  final String location;

  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _chipBackground = Color(0xFFF3F3F3);
  static const Color _border = Color(0xFFE2E2E2);

  static const String _headerAsset =
      'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png';
  static const String _experienceCoverAsset =
      'assets/images/guide_page/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg';
  static const String _experienceRightTopAsset =
      'assets/images/guide_page/c7a25670e7ba19408b7e776b363d6705858a5598.jpg';
  static const String _experienceRightBottomAsset =
      'assets/images/guide_page/8e041ef05fef946a59bcf7b4931c2de56d77b715.jpg';
  static const String _foodLeftAsset =
      'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg';
  static const String _foodRightTopAsset =
      'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg';
  static const String _foodRightBottomAsset =
      'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg';
  static const String _reviewAvatarOne =
      'assets/images/guide_page/1019aa9fca01d6bce807cf74fe90b3b71c995634.png';
  static const String _reviewAvatarTwo =
      'assets/images/guide_page/959746cd629042b29a8f93f90bd29f83e5401423.png';
  static const String _reviewAvatarThree =
      'assets/images/guide_page/c7b8b5b6cc0c7f882d307811b73f983fdd7235b8.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: _buildProfileSection(context)),
                  SliverToBoxAdapter(child: _buildMediaPreview()),
                  SliverToBoxAdapter(child: _buildRateTable()),
                  SliverToBoxAdapter(
                    child: _buildSectionTitle('My Experiences'),
                  ),
                  SliverToBoxAdapter(child: _buildExperienceCards()),
                  SliverToBoxAdapter(
                    child: _buildSectionTitleWithAction('Reviews'),
                  ),
                  SliverToBoxAdapter(child: _buildReviews()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Image.asset(_headerAsset, fit: BoxFit.cover),
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
              backgroundImage: AssetImage(imagePath),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context) {
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
                      name,
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
                        const Text(
                          '127 Reviews',
                          style: TextStyle(fontSize: 16, color: _textSecondary),
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
            children: const [
              _LanguageChip(label: 'Vietnamese'),
              _LanguageChip(label: 'English'),
              _LanguageChip(label: 'Korean'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: _primary, size: 20),
              const SizedBox(width: 4),
              Text(
                location,
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
            "Short introduction: Lorem Ipsum is simply dummy text of the printing "
            "and typesetting industry. Lorem Ipsum has been the industry's "
            "standard dummy text ever since the 1500s, when an unknown printer "
            "took a galley of type and scrambled it to make a type specimen book.",
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

  Widget _buildMediaPreview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.35,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.72),
                borderRadius: BorderRadius.circular(34),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: _primary,
                size: 44,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRateTable() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: const [
            _RateRow(label: '1 - 3 Travelers', price: '\$10/ hour'),
            Divider(height: 1, color: _border),
            _RateRow(label: '4 - 6 Travelers', price: '\$14/ hour'),
            Divider(height: 1, color: _border),
            _RateRow(label: '7 - 9 Travelers', price: '\$17/ hour'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: _textPrimary,
        ),
      ),
    );
  }

  Widget _buildSectionTitleWithAction(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          const Text(
            'SEE MORE',
            style: TextStyle(
              color: _primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: const [
          _ExperienceDetailCard(
            leftImagePath: _experienceCoverAsset,
            rightTopImagePath: _experienceRightTopAsset,
            rightBottomImagePath: _experienceRightBottomAsset,
            title: '2 Hour Bicycle Tour exploring Hoian',
            location: 'Hoian, Vietnam',
            date: 'Jan 25, 2020',
            likes: '1234 Likes',
          ),
          SizedBox(height: 16),
          _ExperienceDetailCard(
            leftImagePath: _foodLeftAsset,
            rightTopImagePath: _foodRightTopAsset,
            rightBottomImagePath: _foodRightBottomAsset,
            title: 'Food tour in Danang',
            location: 'Danang, Vietnam',
            date: 'Jan 20, 2020',
            likes: '234 Likes',
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: const [
          _ReviewTile(
            avatarPath: _reviewAvatarOne,
            name: 'Pena Valdez',
            date: 'Jan 22, 2020',
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                "when an unknown printer took a galley of type and scrambled it to make a type "
                "specimen book. It has survived not only five centuries.",
          ),
          SizedBox(height: 18),
          _ReviewTile(
            avatarPath: _reviewAvatarTwo,
            name: 'Daehyun',
            date: 'Jan 22, 2020',
            review:
                "Many desktop publishing packages and web page editors now use "
                "Lorem Ipsum as their default model text, and a search for 'lorem ipsum'",
          ),
          SizedBox(height: 18),
          _ReviewTile(
            avatarPath: _reviewAvatarThree,
            name: 'Burns Marks',
            date: 'Jan 22, 2020',
            review:
                "There are many variations of passages of Lorem Ipsum available, "
                "but the majority have suffered alteration in some form, by injected "
                "humour, or randomised words which don't look even slightly believable.",
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: GuideDetailScreen._chipBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: GuideDetailScreen._textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _RateRow extends StatelessWidget {
  const _RateRow({required this.label, required this.price});

  final String label;
  final String price;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: GuideDetailScreen._textPrimary,
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1, color: GuideDetailScreen._border),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                price,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: GuideDetailScreen._textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceDetailCard extends StatelessWidget {
  const _ExperienceDetailCard({
    required this.leftImagePath,
    required this.rightTopImagePath,
    required this.rightBottomImagePath,
    required this.title,
    required this.location,
    required this.date,
    required this.likes,
  });

  final String leftImagePath;
  final String rightTopImagePath;
  final String rightBottomImagePath;
  final String title;
  final String location;
  final String date;
  final String likes;

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
                      leftImagePath,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            rightTopImagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            rightBottomImagePath,
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
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: GuideDetailScreen._textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: GuideDetailScreen._primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: GuideDetailScreen._primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        color: GuideDetailScreen._textSecondary,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border,
                      color: GuideDetailScreen._primary,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      likes,
                      style: const TextStyle(
                        fontSize: 14,
                        color: GuideDetailScreen._textSecondary,
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
  const _ReviewTile({
    required this.avatarPath,
    required this.name,
    required this.date,
    required this.review,
  });

  final String avatarPath;
  final String name;
  final String date;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 24, backgroundImage: AssetImage(avatarPath)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: GuideDetailScreen._textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (_) => const Icon(
                          Icons.star,
                          size: 15,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 14,
                          color: GuideDetailScreen._textSecondary,
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
          review,
          style: const TextStyle(
            fontSize: 14,
            color: GuideDetailScreen._textPrimary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
