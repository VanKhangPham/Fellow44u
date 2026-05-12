import 'package:flutter/material.dart';

import '../models/destination_model.dart';
import '../repositories/api_destination_repository.dart';
import '../repositories/destination_repository.dart';
import 'search_results.dart';

class ExploreSearchModal extends StatefulWidget {
  const ExploreSearchModal({
    super.key,
    this.destinationRepository = const ApiDestinationRepository(),
  });

  final DestinationRepository destinationRepository;

  @override
  State<ExploreSearchModal> createState() => _ExploreSearchModalState();
}

class _ExploreSearchModalState extends State<ExploreSearchModal> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);

  final TextEditingController _searchController = TextEditingController();
  late Future<List<DestinationModel>> _destinationsFuture;

  @override
  void initState() {
    super.initState();
    _destinationsFuture = widget.destinationRepository
        .fetchPopularDestinations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _destinationsFuture = widget.destinationRepository.searchDestinations(
        _searchController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
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
                      decoration: const InputDecoration(
                        hintText: 'Where you want to explore',
                        hintStyle: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(fontSize: 16, color: _textPrimary),
                      onChanged: (_) => _reload(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            Expanded(
              child: FutureBuilder<List<DestinationModel>>(
                future: _destinationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(color: _primary),
                    );
                  }

                  if (snapshot.hasError) {
                    return _buildErrorState();
                  }

                  final destinations =
                      snapshot.data ?? const <DestinationModel>[];
                  return _searchController.text.isEmpty
                      ? _buildPopularDestinations(destinations)
                      : _buildSearchResults(destinations);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Unable to load destinations',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 16,
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

  Widget _buildPopularDestinations(List<DestinationModel> destinations) {
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
        ...destinations.map(_buildDestinationTile),
      ],
    );
  }

  Widget _buildSearchResults(List<DestinationModel> destinations) {
    final results = destinations
        .where(
          (destination) => destination.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ),
        )
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.location_off_outlined,
              size: 48,
              color: Color(0xFFBDBDBD),
            ),
            SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(fontSize: 16, color: _textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 16),
        ...results.map(_buildDestinationTile),
      ],
    );
  }

  Widget _buildDestinationTile(DestinationModel destination) {
    return _DestinationTile(
      destination: destination.name,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                SearchResultsScreen(destination: destination.name),
          ),
        );
      },
    );
  }
}

class _DestinationTile extends StatelessWidget {
  const _DestinationTile({required this.destination, required this.onTap});

  final String destination;
  final VoidCallback onTap;

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
