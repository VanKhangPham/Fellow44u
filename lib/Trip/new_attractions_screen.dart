import 'package:flutter/material.dart';

class NewAttractionsScreen extends StatefulWidget {
  const NewAttractionsScreen({
    super.key,
    required this.initialSelection,
  });

  final Set<String> initialSelection;

  @override
  State<NewAttractionsScreen> createState() => _NewAttractionsScreenState();
}

class _NewAttractionsScreenState extends State<NewAttractionsScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF8A8A8A);
  static const Color _surfaceBorder = Color(0xFFF0F0F0);

  static const String _congCoffeeAsset =
      'assets/images/new_attractions/d0e12956c710254dcc64c0c50ab0ac6ed6d861b3.png';

  late final TextEditingController _searchController;
  late Set<String> _selection;
  late final List<dynamic> _suggestions;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selection = {...widget.initialSelection};
    _suggestions = [
      const _AttractionSuggestion(
        name: 'Cong Coffee',
        assetPath: _congCoffeeAsset,
      ),
      const _AttractionSuggestion(name: 'Cong Hoa Market'),
      const _AttractionSuggestion(name: 'Cong Cho'),
      const _AttractionSuggestion(name: 'Cong Church'),
      const _AttractionSuggestion(name: 'Dragon Bridge'),
      const _AttractionSuggestion(name: 'Cham Museum'),
      const _AttractionSuggestion(name: 'My Khe Beach'),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _AttractionSuggestion _normalizeSuggestion(dynamic item) {
    if (item is _AttractionSuggestion) {
      return item;
    }
    if (item is String) {
      return _AttractionSuggestion(
        name: item,
        assetPath: item == 'Cong Coffee' ? _congCoffeeAsset : null,
      );
    }
    return const _AttractionSuggestion(name: '');
  }

  List<_AttractionSuggestion> get _filteredSuggestions {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return const [];
    }
    final normalizedSuggestions = _suggestions
        .map(_normalizeSuggestion)
        .where((item) => item.name.isNotEmpty)
        .toList();
    final exactMatches = normalizedSuggestions
        .where((item) => item.name.toLowerCase() == query)
        .toList();
    if (exactMatches.isNotEmpty) {
      return exactMatches;
    }
    return normalizedSuggestions
        .where((item) => item.name.toLowerCase().contains(query))
        .toList();
  }

  void _addCurrentQuery() {
    final value = _searchController.text.trim();
    if (value.isEmpty) {
      return;
    }
    setState(() {
      _selection.add(value);
      if (!_suggestions.any((item) => _normalizeSuggestion(item).name == value)) {
        _suggestions.insert(0, _AttractionSuggestion(name: value));
      }
    });
  }

  void _toggleSelection(String value) {
    setState(() {
      if (_selection.contains(value)) {
        _selection.remove(value);
      } else {
        _selection.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _filteredSuggestions;
    final query = _searchController.text.trim();
    final hasExactMatch = suggestions.any(
      (item) => item.name.toLowerCase() == query.toLowerCase(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.black87),
                  ),
                  const Expanded(
                    child: Text(
                      'New Attractions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _textPrimary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(_selection),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        color: _primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              cursorColor: _primary,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type a Place',
                                hintStyle: TextStyle(color: _textSecondary),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: _textPrimary,
                              ),
                              onChanged: (_) => setState(() {}),
                              onSubmitted: (_) => _addCurrentQuery(),
                            ),
                          ),
                          GestureDetector(
                            onTap: query.isEmpty ? null : _addCurrentQuery,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: hasExactMatch
                                  ? const Color(0xFFE2E2E2)
                                  : _primary,
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: _surfaceBorder),
                    if (suggestions.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          query.isEmpty
                              ? 'Type a place to search'
                              : 'No matching attractions',
                          style: const TextStyle(color: _textSecondary),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.start,
                          children: suggestions
                              .map(
                                (item) => _AttractionSearchCard(
                                  suggestion: item,
                                  selected: _selection.contains(item.name),
                                  onTap: () => _toggleSelection(item.name),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    if (query.isNotEmpty &&
                        !hasExactMatch &&
                        !suggestions.any(
                          (item) => item.name.toLowerCase() == query.toLowerCase(),
                        ))
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: _addCurrentQuery,
                            style: TextButton.styleFrom(
                              foregroundColor: _primary,
                              padding: EdgeInsets.zero,
                            ),
                            child: Text('Add "$query"'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttractionSuggestion {
  const _AttractionSuggestion({
    required this.name,
    this.assetPath,
  });

  final String name;
  final String? assetPath;
}

class _AttractionSearchCard extends StatelessWidget {
  const _AttractionSearchCard({
    required this.suggestion,
    required this.selected,
    required this.onTap,
  });

  final _AttractionSuggestion suggestion;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasImage = suggestion.assetPath != null;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 142,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              if (hasImage)
                AspectRatio(
                  aspectRatio: 1.24,
                  child: Image.asset(
                    suggestion.assetPath!,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 114,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.06),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    suggestion.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: _NewAttractionsScreenState._textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (hasImage)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.48),
                          Color.fromRGBO(0, 0, 0, 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
              if (hasImage)
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Text(
                    suggestion.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (selected)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: _NewAttractionsScreenState._primary,
                    child: Icon(Icons.check, size: 16, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
