import 'package:flutter/material.dart';

import '../models/tour_detail_model.dart';
import '../models/tour_schedule_day_model.dart';
import '../repositories/api_tour_repository.dart';
import '../repositories/tour_repository.dart';
import 'tour_detail_share.dart';

class TourDetailScreen extends StatefulWidget {
  const TourDetailScreen({
    super.key,
    required this.tourId,
    this.repository = const ApiTourRepository(),
  });

  final String tourId;
  final TourRepository repository;

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF8A8A8A);
  static const Color _surface = Color(0xFFF7F7F7);
  static const Color _border = Color(0xFFE4E4E4);

  static const String _shareIcon = 'assets/images/tour_detail/Frame 43.png';
  static const String _favoriteIcon = 'assets/images/tour_detail/Shape.png';
  static const String _bookmarkIcon = 'assets/images/tour_detail/Inactive.png';

  late Future<TourDetailModel?> _detailFuture;
  int _selectedDay = 0;

  @override
  void initState() {
    super.initState();
    _detailFuture = widget.repository.fetchTourDetail(widget.tourId);
  }

  void _reload() {
    setState(() {
      _detailFuture = widget.repository.fetchTourDetail(widget.tourId);
    });
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ShareBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: _surface,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<TourDetailModel?>(
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
                  'Tour details unavailable',
                  style: TextStyle(color: _textPrimary),
                ),
              );
            }

            final days = detail.scheduleDays;
            final safeIndex = _selectedDay >= days.length ? 0 : _selectedDay;
            final selectedDay = days[safeIndex];

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context, detail),
                        _buildOverview(detail),
                        _buildSummaryCard(detail),
                        _buildScheduleSection(days, selectedDay),
                        _buildPriceSection(detail),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    bottomInset > 0 ? bottomInset : 16,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'BOOK THIS TOUR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TourDetailModel detail) {
    return Stack(
      children: [
        SizedBox(
          height: 270,
          width: double.infinity,
          child: Image.asset(detail.headerImagePath, fit: BoxFit.cover),
        ),
        Container(
          height: 270,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 0.08),
                Color.fromRGBO(0, 0, 0, 0.24),
              ],
            ),
          ),
        ),
        Positioned(
          left: 8,
          top: 12,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 18,
          child: Row(
            children: [
              _HeaderActionIcon(
                assetPath: _shareIcon,
                onTap: () => _showShareBottomSheet(context),
              ),
              const SizedBox(width: 12),
              const _HeaderActionIcon(assetPath: _favoriteIcon),
              const SizedBox(width: 12),
              const _HeaderActionIcon(assetPath: _bookmarkIcon),
            ],
          ),
        ),
        const Positioned(
          bottom: 14,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeaderIndicator(active: true),
              SizedBox(width: 8),
              _HeaderIndicator(active: false),
              SizedBox(width: 8),
              _HeaderIndicator(active: false),
            ],
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
            'Unable to load tour details.',
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

  Widget _buildOverview(TourDetailModel detail) {
    final tour = detail.tour;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (_) => const Icon(
                        Icons.star,
                        size: 16,
                        color: Color(0xFFFFC107),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${detail.reviewsCount} Reviews',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: _textSecondary),
                    children: [
                      TextSpan(
                        text: tour.oldPriceLabel ?? tour.priceLabel,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: tour.priceLabel,
                        style: const TextStyle(
                          color: _primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(TourDetailModel detail) {
    final tour = detail.tour;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _SummaryField(
                      label: 'Provider',
                      value: tour.provider,
                    ),
                  ),
                  Expanded(
                    child: _SummaryField(
                      label: 'Departure Date',
                      value: tour.departureDateLabel,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _SummaryField(
                      label: 'Itinerary',
                      value: tour.itinerary,
                    ),
                  ),
                  Expanded(
                    child: _SummaryField(
                      label: 'Departure Place',
                      value: tour.departurePlace,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _SummaryField(label: 'Duration', value: tour.durationDetail),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleSection(
    List<TourScheduleDayModel> days,
    TourScheduleDayModel selectedDay,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Schedule',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(days.length, (index) {
                final day = days[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == days.length - 1 ? 0 : 10,
                  ),
                  child: _DayChip(
                    label: day.label,
                    active: _selectedDay == index,
                    onTap: () => setState(() => _selectedDay = index),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: selectedDay.entries
                  .map((entry) => _ScheduleTile(entry: entry))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(TourDetailModel detail) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border),
        ),
        child: Column(
          children: [
            _PriceRow(label: 'Adult', value: detail.tour.priceLabel),
            const Divider(height: 1, color: _border),
            _PriceRow(label: 'Child', value: detail.tour.oldPriceLabel ?? '--'),
          ],
        ),
      ),
    );
  }
}

class _HeaderActionIcon extends StatelessWidget {
  const _HeaderActionIcon({required this.assetPath, this.onTap});

  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(17),
        ),
        alignment: Alignment.center,
        child: Image.asset(assetPath, width: 18, height: 18),
      ),
    );
  }
}

class _HeaderIndicator extends StatelessWidget {
  const _HeaderIndicator({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 3,
      decoration: BoxDecoration(
        color: active ? _TourDetailScreenState._primary : Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _SummaryField extends StatelessWidget {
  const _SummaryField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: _TourDetailScreenState._textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: _TourDetailScreenState._textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _TourDetailScreenState._primary : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active
                ? Colors.white
                : _TourDetailScreenState._textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({required this.entry});

  final dynamic entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: _TourDetailScreenState._primary,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.timeLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: _TourDetailScreenState._primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  entry.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: _TourDetailScreenState._textPrimary,
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

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

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
                  color: _TourDetailScreenState._textPrimary,
                ),
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: _TourDetailScreenState._border,
          ),
          SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: _TourDetailScreenState._textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
