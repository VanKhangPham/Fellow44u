import 'package:flutter/material.dart';

import '../models/attraction_model.dart';
import '../repositories/attraction_repository.dart';
import '../repositories/mock_attraction_repository.dart';

class NewAttractionsScreen extends StatefulWidget {
  const NewAttractionsScreen({
    super.key,
    required this.initialSelection,
    this.repository = const MockAttractionRepository(),
  });

  final Set<String> initialSelection;
  final AttractionRepository repository;

  @override
  State<NewAttractionsScreen> createState() => _NewAttractionsScreenState();
}

class _NewAttractionsScreenState extends State<NewAttractionsScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF8A8A8A);
  static const Color _surfaceBorder = Color(0xFFF0F0F0);

  late final TextEditingController _searchController;
  late Set<String> _selection;
  late Future<List<AttractionModel>> _suggestionsFuture;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selection = {...widget.initialSelection};
    _suggestionsFuture = widget.repository.fetchSuggestedAttractions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      final query = _searchController.text.trim();
      _suggestionsFuture = query.isEmpty
          ? widget.repository.fetchSuggestedAttractions()
          : widget.repository.searchAttractions(query);
    });
  }

  void _addCurrentQuery() {
    final value = _searchController.text.trim();
    if (value.isEmpty) {
      return;
    }
    setState(() {
      _selection.add(value);
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
    final query = _searchController.text.trim();
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
                              onChanged: (_) => _search(),
                              onSubmitted: (_) => _addCurrentQuery(),
                            ),
                          ),
                          GestureDetector(
                            onTap: query.isEmpty ? null : _addCurrentQuery,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor:
                                  query.isEmpty ? const Color(0xFFE2E2E2) : _primary,
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: _surfaceBorder),
                    FutureBuilder<List<AttractionModel>>(
                      future: _suggestionsFuture,
                      builder: (context, snapshot) {
                        final suggestions = snapshot.data ?? const <AttractionModel>[];
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(color: _primary),
                          );
                        }

                        if (suggestions.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              query.isEmpty
                                  ? 'Type a place to search'
                                  : 'No matching attractions',
                              style: const TextStyle(color: _textSecondary),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
                          child: Wrap(
                            children: suggestions
                                .map((item) => _buildSuggestionChip(item))
                                .toList(),
                          ),
                        );
                      },
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

  Widget _buildSuggestionChip(AttractionModel suggestion) {
    final isSelected = _selection.contains(suggestion.name);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _toggleSelection(suggestion.name),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF0FFFB) : Colors.white,
            border: Border.all(
              color: isSelected ? _primary : const Color(0xFFEAEAEA),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              if (suggestion.imagePath != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    suggestion.imagePath!,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  suggestion.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: _textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Checkbox(
                value: isSelected,
                activeColor: _primary,
                onChanged: (_) => _toggleSelection(suggestion.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
