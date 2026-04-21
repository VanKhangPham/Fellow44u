import 'package:flutter/material.dart';

import '../Tour_Detail/tour_detail_screen.dart';
import 'guide_detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _background = Color(0xFFF7F7F7);

  static const String _headerImage =
      'assets/images/explore/2a4028cfda3cda6d2d71eef70a4cdc292c82b02c.png';

  static const List<_JourneyItem> _journeys = [
    _JourneyItem(
      imagePath:
          'assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png',
      title: 'Da Nang - Ba Na - Hoi An',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$400.00',
      likes: '1247 likes',
      bookmarked: true,
    ),
    _JourneyItem(
      imagePath:
          'assets/images/explore/905442573fa7cf367c66678ad47feb95cf9517c1.jpg',
      title: 'Thailand',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$600.00',
      likes: '1247 likes',
      bookmarked: false,
    ),
  ];

  static const List<_GuideItem> _guides = [
    _GuideItem(
      imagePath:
          'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      name: 'Tuan Tran',
      location: 'Danang, Vietnam',
    ),
    _GuideItem(
      imagePath:
          'assets/images/explore/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
      name: 'Emmy',
      location: 'Hanoi, Vietnam',
    ),
    _GuideItem(
      imagePath:
          'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      name: 'Linh Hana',
      location: 'Danang, Vietnam',
    ),
    _GuideItem(
      imagePath:
          'assets/images/explore/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
      name: 'Khai Ho',
      location: 'Ho Chi Minh, Vietnam',
    ),
  ];

  static const List<_ExperienceItem> _experiences = [
    _ExperienceItem(
      imagePath:
          'assets/images/explore/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg',
      avatarPath:
          'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      title: '2 Hour Bicycle Tour\nexploring Hoian',
      location: 'Hoian, Vietnam',
      guideName: 'Tuan Tran',
    ),
    _ExperienceItem(
      imagePath:
          'assets/images/explore/744f85922de533c19555ae4c251ce3dec7041419.png',
      avatarPath:
          'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      title: '1 day at Bana Hill',
      location: 'Bana, Vietnam',
      guideName: 'Linh Hana',
    ),
  ];

  static const List<_FeaturedTourItem> _featuredTours = [
    _FeaturedTourItem(
      imagePath:
          'assets/images/explore/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
      title: 'Da Nang - Ba Na - Hoi An',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$400.00',
      oldPrice: '\$450.00',
      likes: '1247 likes',
      liked: false,
      provider: 'dulichviet',
      itinerary: 'Da Nang - Ba Na - Hoi An',
      duration: '2 days, 2 nights',
      departureDate: 'Feb 12',
      departurePlace: 'Ho Chi Minh',
    ),
    _FeaturedTourItem(
      imagePath:
          'assets/images/explore/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
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
    _FeaturedTourItem(
      imagePath:
          'assets/images/explore/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
      title: 'Hanoi - HaLong Bay',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$300.00',
      oldPrice: '\$350.00',
      likes: '1247 likes',
      liked: false,
      provider: 'vietravel',
      itinerary: 'Hanoi - HaLong Bay',
      duration: '2 days, 1 night',
      departureDate: 'Apr 20',
      departurePlace: 'Hanoi',
    ),
  ];

  static const List<_NewsItem> _news = [
    _NewsItem(
      title: 'New Destination in Danang City',
      date: 'Feb 5, 2020',
      imagePath:
          'assets/images/explore/42751d9e220fe7ee14bf95a97b59825a368e47d5.jpg',
    ),
    _NewsItem(
      title: '\$1 Flight Ticket',
      date: 'Feb 5, 2020',
      imagePath:
          'assets/images/explore/36be4ecb191058ba8705bba356eae55efd52bf66.png',
    ),
    _NewsItem(
      title: 'Visit Korea in this Tet Holiday',
      date: 'Jan 26, 2020',
      imagePath:
          'assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 22),
                  _buildSectionTitle('Top Journeys'),
                  const SizedBox(height: 12),
                  _buildTopJourneys(),
                  const SizedBox(height: 24),
                  _buildSectionTitleWithAction('Best Guides'),
                  const SizedBox(height: 12),
                  _buildBestGuides(context),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Top Experiences'),
                  const SizedBox(height: 12),
                  _buildTopExperiences(),
                  const SizedBox(height: 24),
                  _buildSectionTitleWithAction('Featured Tours'),
                  const SizedBox(height: 12),
                  _buildFeaturedTours(context),
                  const SizedBox(height: 24),
                  _buildSectionTitleWithAction('Travel News'),
                  const SizedBox(height: 8),
                  _buildTravelNews(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            _buildBottomNav(bottomInset),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 188,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 152,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(_headerImage, fit: BoxFit.cover),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.12),
                        Color.fromRGBO(0, 0, 0, 0.38),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 16,
            top: 34,
            child: Text(
              'Explore',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          const Positioned(
            right: 16,
            top: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 13, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      'Da Nang',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  '26°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                    height: 0.9,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 8,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Color(0xFF9E9E9E), size: 20),
                  SizedBox(width: 6),
                  Text(
                    'Hi, where do you want to explore?',
                    style: TextStyle(color: Color(0xFF757575), fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopJourneys() {
    return SizedBox(
      height: 285,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _journeys.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _journeys[index];
          return Container(
            width: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.asset(
                        item.imagePath,
                        width: 220,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Icon(
                        item.bookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Row(
                        children: [
                          ...List.generate(
                            5,
                            (_) => const Icon(
                              Icons.star,
                              size: 14,
                              color: Color(0xFFFFC107),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.likes,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: _textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.date,
                            style: const TextStyle(
                              color: _textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.days,
                            style: const TextStyle(
                              color: _textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.price,
                        style: const TextStyle(
                          color: _primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBestGuides(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _guides.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.67,
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
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(
                      guide.imagePath,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 6,
                      bottom: 6,
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                          SizedBox(width: 4),
                          Text(
                            '127 Reviews',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                guide.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 15, color: _primary),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      guide.location,
                      style: const TextStyle(fontSize: 12, color: _primary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopExperiences() {
    return SizedBox(
      height: 285,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _experiences.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _experiences[index];
          return SizedBox(
            width: 235,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item.imagePath,
                        width: 235,
                        height: 165,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: -20,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: _primary, width: 4),
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage: AssetImage(item.avatarPath),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item.guideName,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 15, color: _primary),
                    const SizedBox(width: 2),
                    Text(
                      item.location,
                      style: const TextStyle(fontSize: 13, color: _primary),
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

  Widget _buildFeaturedTours(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(_featuredTours.length, (index) {
          final item = _featuredTours[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == _featuredTours.length - 1 ? 0 : 12,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TourDetailScreen(
                      title: item.title,
                      price: item.price,
                      oldPrice: item.oldPrice,
                      provider: item.provider,
                      itinerary: item.itinerary,
                      duration: item.duration,
                      departureDate: item.departureDate,
                      departurePlace: item.departurePlace,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            item.imagePath,
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Row(
                            children: [
                              ...List.generate(
                                5,
                                (_) => const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFFFFC107),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.likes,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                              ),
                              Icon(
                                item.liked
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: _primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: Color(0xFF9E9E9E),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.date,
                                style: const TextStyle(
                                  color: _textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 14,
                                color: Color(0xFF9E9E9E),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.days,
                                style: const TextStyle(
                                  color: _textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              item.price,
                              style: const TextStyle(
                                color: _primary,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTravelNews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(_news.length, (index) {
          final item = _news[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == _news.length - 1 ? 0 : 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.date,
                  style: const TextStyle(color: _textSecondary, fontSize: 12),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.imagePath,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: _textPrimary,
          height: 1.1,
        ),
      ),
    );
  }

  Widget _buildSectionTitleWithAction(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                height: 1.1,
              ),
            ),
          ),
          const Text(
            'SEE MORE',
            style: TextStyle(
              color: _primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(double bottomInset) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 8, 6, bottomInset > 0 ? bottomInset : 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.explore_outlined,
            label: 'Explore',
            selected: true,
          ),
          _BottomNavItem(icon: Icons.location_on_outlined, label: ''),
          _BottomNavItem(icon: Icons.chat_bubble_outline, label: ''),
          _BottomNavItem(icon: Icons.notifications_none, label: ''),
          _BottomNavItem(icon: Icons.person_outline, label: ''),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF00C7A7) : const Color(0xFF9E9E9E);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: color),
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}

class _JourneyItem {
  const _JourneyItem({
    required this.imagePath,
    required this.title,
    required this.date,
    required this.days,
    required this.price,
    required this.likes,
    required this.bookmarked,
  });

  final String imagePath;
  final String title;
  final String date;
  final String days;
  final String price;
  final String likes;
  final bool bookmarked;
}

class _GuideItem {
  const _GuideItem({
    required this.imagePath,
    required this.name,
    required this.location,
  });

  final String imagePath;
  final String name;
  final String location;
}

class _ExperienceItem {
  const _ExperienceItem({
    required this.imagePath,
    required this.avatarPath,
    required this.title,
    required this.location,
    required this.guideName,
  });

  final String imagePath;
  final String avatarPath;
  final String title;
  final String location;
  final String guideName;
}

class _FeaturedTourItem {
  const _FeaturedTourItem({
    required this.imagePath,
    required this.title,
    required this.date,
    required this.days,
    required this.price,
    required this.oldPrice,
    required this.likes,
    required this.liked,
    required this.provider,
    required this.itinerary,
    required this.duration,
    required this.departureDate,
    required this.departurePlace,
  });

  final String imagePath;
  final String title;
  final String date;
  final String days;
  final String price;
  final String oldPrice;
  final String likes;
  final bool liked;
  final String provider;
  final String itinerary;
  final String duration;
  final String departureDate;
  final String departurePlace;
}

class _NewsItem {
  const _NewsItem({
    required this.title,
    required this.date,
    required this.imagePath,
  });

  final String title;
  final String date;
  final String imagePath;
}
