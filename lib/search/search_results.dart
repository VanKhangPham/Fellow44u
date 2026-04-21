import 'package:flutter/material.dart';

class SearchResultsScreen extends StatefulWidget {
  final String destination;

  const SearchResultsScreen({super.key, required this.destination});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _background = Color(0xFFF7F7F7);

  // Mock data cho Guides
  static const List<_GuideResultItem> _guidesResults = [
    _GuideResultItem(
      imagePath: 'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      name: 'Tuan Tran',
      reviews: '127 Reviews',
    ),
    _GuideResultItem(
      imagePath: 'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      name: 'Linh Hana',
      reviews: '105 Reviews',
    ),
    _GuideResultItem(
      imagePath: 'assets/images/explore/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
      name: 'Tuan Tran',
      reviews: '98 Reviews',
    ),
    _GuideResultItem(
      imagePath: 'assets/images/explore/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
      name: 'Linh Hana',
      reviews: '145 Reviews',
    ),
    _GuideResultItem(
      imagePath: 'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
      name: 'Tuan Tran',
      reviews: '127 Reviews',
    ),
    _GuideResultItem(
      imagePath: 'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
      name: 'Linh Hana',
      reviews: '156 Reviews',
    ),
  ];

  // Mock data cho Tours
  static const List<_TourResultItem> _toursResults = [
    _TourResultItem(
      imagePath: 'assets/images/explore/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
      title: 'Da Nang - Ba Na - Hoi An',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$400.00',
      likes: '1247 likes',
      liked: false,
    ),
    _TourResultItem(
      imagePath: 'assets/images/explore/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
      title: 'Melbourne - Sydney',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$600.00',
      likes: '1247 likes',
      liked: true,
    ),
    _TourResultItem(
      imagePath: 'assets/images/explore/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
      title: 'Hanoi - HaLong Bay',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$300.00',
      likes: '1247 likes',
      liked: false,
    ),
    _TourResultItem(
      imagePath: 'assets/images/explore/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
      title: 'Da Nang - Ba Na - Hoi An',
      date: 'Jan 30, 2020',
      days: '3 days',
      price: '\$400.00',
      likes: '1247 likes',
      liked: false,
    ),
  ];

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.destination);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildSectionTitle('Guides in ${widget.destination}'),
                    const SizedBox(height: 12),
                    _buildGuidesList(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Tours in ${widget.destination}'),
                    const SizedBox(height: 12),
                    _buildToursList(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, size: 24),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Where you want to explore',
                hintStyle: const TextStyle(
                  color: Color(0xFFBDBDBD),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        child: const Icon(Icons.clear, size: 18),
                      )
                    : null,
              ),
              style: const TextStyle(fontSize: 14),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _background,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.tune, size: 20, color: _textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ),
          const Text(
            'SEE MORE',
            style: TextStyle(
              color: _primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidesList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _guidesResults.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.67,
      ),
      itemBuilder: (context, index) {
        final guide = _guidesResults[index];
        return _buildGuideCard(guide);
      },
    );
  }

  Widget _buildGuideCard(_GuideResultItem guide) {
    return Column(
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
                widget.destination,
                style: const TextStyle(fontSize: 12, color: _primary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToursList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(_toursResults.length, (index) {
          final tour = _toursResults[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == _toursResults.length - 1 ? 0 : 12,
            ),
            child: _buildTourCard(tour),
          );
        }),
      ),
    );
  }

  Widget _buildTourCard(_TourResultItem tour) {
    return Container(
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
                  tour.imagePath,
                  width: double.infinity,
                  height: 140,
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
                        size: 14,
                        color: Color(0xFFFFC107),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tour.likes,
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
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tour.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                      ),
                    ),
                    Icon(
                      tour.liked ? Icons.favorite : Icons.favorite_border_outlined,
                      color: _primary,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xFF9E9E9E),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tour.date,
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF9E9E9E),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tour.days,
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    tour.price,
                    style: const TextStyle(
                      color: _primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideResultItem {
  final String imagePath;
  final String name;
  final String reviews;

  const _GuideResultItem({
    required this.imagePath,
    required this.name,
    required this.reviews,
  });
}

class _TourResultItem {
  final String imagePath;
  final String title;
  final String date;
  final String days;
  final String price;
  final String likes;
  final bool liked;

  const _TourResultItem({
    required this.imagePath,
    required this.title,
    required this.date,
    required this.days,
    required this.price,
    required this.likes,
    required this.liked,
  });
}