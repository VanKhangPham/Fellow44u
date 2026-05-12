import 'package:flutter/material.dart';

import '../MyTrips/my_trips_current_screen.dart';
import '../Tour_Detail/tour_detail_screen.dart';
import '../models/explore_home_data.dart';
import '../models/experience_model.dart';
import '../models/guide_model.dart';
import '../models/journey_model.dart';
import '../models/tour_model.dart';
import '../models/travel_news_model.dart';
import '../repositories/api_explore_repository.dart';
import '../repositories/explore_repository.dart';
import 'guide_more_screen.dart';
import 'guide_detail_screen.dart';
import '../search/search.dart';
import 'tour_more_screen.dart';
import '../widgets/main_bottom_nav.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    super.key,
    this.repository = const ApiExploreRepository(),
  });

  final ExploreRepository repository;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _background = Color(0xFFF7F7F7);

  static const String _headerImage =
      'assets/images/explore/2a4028cfda3cda6d2d71eef70a4cdc292c82b02c.png';

  late Future<ExploreHomeData> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = widget.repository.fetchHomeData();
  }

  void _reloadHomeData() {
    setState(() {
      _homeDataFuture = widget.repository.fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ExploreHomeData>(
                future: _homeDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return _buildLoadingState();
                  }

                  if (snapshot.hasError) {
                    return _buildErrorState();
                  }

                  final homeData = snapshot.data;
                  if (homeData == null) {
                    return _buildErrorState();
                  }

                  return _buildContent(context, homeData);
                },
              ),
            ),
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ExploreHomeData homeData) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(context),
        const SizedBox(height: 22),
        _buildSectionTitle('Top Journeys'),
        const SizedBox(height: 12),
        _buildTopJourneys(homeData.journeys),
        const SizedBox(height: 24),
        _buildSectionTitleWithAction(
          'Best Guides',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const GuideMoreScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildBestGuides(context, homeData.guides),
        const SizedBox(height: 24),
        _buildSectionTitle('Top Experiences'),
        const SizedBox(height: 12),
        _buildTopExperiences(homeData.experiences),
        const SizedBox(height: 24),
        _buildSectionTitleWithAction(
          'Featured Tours',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TourMoreScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildFeaturedTours(context, homeData.featuredTours),
        const SizedBox(height: 24),
        _buildSectionTitleWithAction('Travel News'),
        const SizedBox(height: 8),
        _buildTravelNews(homeData.news),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator(color: _primary));
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Unable to load explore data.',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Please try again.',
              style: TextStyle(color: _textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _reloadHomeData,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('RETRY'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const ExploreSearchModal(),
                );
              },
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
          ),
        ],
      ),
    );
  }

  Widget _buildTopJourneys(List<JourneyModel> journeys) {
    return SizedBox(
      height: 285,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: journeys.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = journeys[index];
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
                        item.isBookmarked
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
                            item.likesLabel,
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
                            item.dateLabel,
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
                            item.durationLabel,
                            style: const TextStyle(
                              color: _textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.priceLabel,
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

  Widget _buildBestGuides(BuildContext context, List<GuideModel> guides) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: guides.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.67,
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
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(
                      guide.avatarPath,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 6,
                      bottom: 6,
                      child: Row(
                        children: [
                          ...List.generate(
                            5,
                            (_) => const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${guide.reviewsCount} Reviews',
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

  Widget _buildTopExperiences(List<ExperienceModel> experiences) {
    return SizedBox(
      height: 285,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: experiences.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = experiences[index];
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
                          backgroundImage: AssetImage(item.guideAvatarPath),
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

  Widget _buildFeaturedTours(BuildContext context, List<TourModel> tours) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(tours.length, (index) {
          final item = tours[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == tours.length - 1 ? 0 : 12,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TourDetailScreen(tourId: item.id),
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
                            item.coverImagePath,
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
                                item.likesLabel,
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
                                item.isLiked
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
                                item.dateLabel,
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
                                item.durationLabel,
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
                              item.priceLabel,
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

  Widget _buildTravelNews(List<TravelNewsModel> news) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(news.length, (index) {
          final item = news[index];
          return Padding(
            padding: EdgeInsets.only(bottom: index == news.length - 1 ? 0 : 12),
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
                  item.dateLabel,
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

  Widget _buildSectionTitleWithAction(String title, {VoidCallback? onTap}) {
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
          GestureDetector(
            onTap: onTap,
            child: Text(
              'SEE MORE',
              style: TextStyle(
                color: onTap == null ? _textSecondary : _primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return MainBottomNav(
      currentIndex: 0,
      onTripsTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MyTripsCurrentScreen()),
        );
      },
    );
  }
}
