import 'package:flutter/material.dart';
import 'search_results.dart';

class ExploreSearchModal extends StatefulWidget {
  const ExploreSearchModal({super.key});

  @override
  State<ExploreSearchModal> createState() => _ExploreSearchModalState();
}

class _ExploreSearchModalState extends State<ExploreSearchModal> {
  final TextEditingController _searchController = TextEditingController();

  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);

  // Danh sách địa điểm phổ biến
  static const List<String> _popularDestinations = [
    'Danang, Vietnam',
    'Ho Chi Minh, Vietnam',
    'Venice, Italy',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header với nút Close
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Where you want to explore',
                        hintStyle: const TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(fontSize: 16, color: _textPrimary),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            // Danh sách địa điểm
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildPopularDestinations()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDestinations() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 24),
        const Text(
          'Popular destinations',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ..._popularDestinations.map((destination) {
          return _DestinationTile(
            destination: destination,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchResultsScreen(
                    destination: destination,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSearchResults() {
    final results = _popularDestinations
        .where((destination) => destination
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_off_outlined,
              size: 48,
              color: Color(0xFFBDBDBD),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 16,
                color: _textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 16),
        ...results.map((destination) {
          return _DestinationTile(
            destination: destination,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchResultsScreen(
                    destination: destination,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }
}

class _DestinationTile extends StatelessWidget {
  final String destination;
  final VoidCallback onTap;

  const _DestinationTile({
    required this.destination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
              color: Color(0xFF9E9E9E),
            ),
            const SizedBox(width: 12),
            Text(
              destination,
              style: const TextStyle(fontSize: 16, color: Color(0xFF212121)),
            ),
          ],
        ),
      ),
    );
  }
}