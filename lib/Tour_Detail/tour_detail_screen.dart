import 'package:flutter/material.dart';
import 'tour_detail_share.dart';

class TourDetailScreen extends StatefulWidget {
  const TourDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.provider,
    required this.itinerary,
    required this.duration,
    required this.departureDate,
    required this.departurePlace,
  });

  final String title;
  final String price;
  final String oldPrice;
  final String provider;
  final String itinerary;
  final String duration;
  final String departureDate;
  final String departurePlace;

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF8A8A8A);
  static const Color _surface = Color(0xFFF7F7F7);
  static const Color _border = Color(0xFFE4E4E4);

  static const String _headerAsset =
      'assets/images/tour_detail/670301139 1.png';
  static const String _shareIcon = 'assets/images/tour_detail/Frame 43.png';
  static const String _favoriteIcon = 'assets/images/tour_detail/Shape.png';
  static const String _bookmarkIcon = 'assets/images/tour_detail/Inactive.png';
  static const String _scheduleIcon = 'assets/images/tour_detail/Vector.png';

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ShareBottomSheet(),
    );
  }

  int _selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: _surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    _buildOverview(),
                    _buildSummaryCard(),
                    _buildScheduleSection(),
                    _buildPriceSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 12, 16, bottomInset > 0 ? bottomInset : 16),
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
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 270,
          width: double.infinity,
          child: Image.asset(_headerAsset, fit: BoxFit.cover),
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

  Widget _buildOverview() {
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
                  widget.title,
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
                    const Text(
                      '145 Reviews',
                      style: TextStyle(color: _textSecondary, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: _textSecondary),
                    children: [
                      const TextSpan(text: 'Provider '),
                      TextSpan(
                        text: widget.provider,
                        style: const TextStyle(color: _primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.price,
                style: const TextStyle(
                  color: _primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.oldPrice,
                style: const TextStyle(
                  color: Color(0xFFB0B0B0),
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
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
            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _SummaryField(label: 'Itinerary', value: widget.itinerary),
            const SizedBox(height: 14),
            _SummaryField(label: 'Duration', value: widget.duration),
            const SizedBox(height: 14),
            _SummaryField(label: 'Departure Date', value: widget.departureDate),
            const SizedBox(height: 14),
            _SummaryField(label: 'Departure Place', value: widget.departurePlace),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection() {
    final dayOneItems = const [
      _ScheduleEntry(
        time: '6:00AM',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.",
      ),
      _ScheduleEntry(
        time: '10:00AM',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.",
      ),
      _ScheduleEntry(
        time: '1:00PM',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets.",
      ),
      _ScheduleEntry(
        time: '8:00PM',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.",
      ),
    ];
    final dayTwoItems = const [
      _ScheduleEntry(
        time: '8:30AM',
        description:
            "Breakfast and transfer to Ba Na Hills. Continue with guided visits and photo stops across the main attractions.",
      ),
      _ScheduleEntry(
        time: '12:00PM',
        description:
            "Lunch break and free exploration time before descending back to the city center.",
      ),
      _ScheduleEntry(
        time: '6:30PM',
        description:
            "Return to the hotel and close the day with a relaxed evening in Hoi An.",
      ),
    ];
    final items = _selectedDay == 0 ? dayOneItems : dayTwoItems;
    final routeTitle = _selectedDay == 0 ? 'Ho Chi Minh - Da Nang' : 'Da Nang - Ba Na - Hoi An';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(_scheduleIcon, width: 22, height: 22, color: _textPrimary),
              const SizedBox(width: 12),
              const Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _DayChip(
                label: 'Day 1',
                active: _selectedDay == 0,
                onTap: () => setState(() => _selectedDay = 0),
              ),
              const SizedBox(width: 12),
              _DayChip(
                label: 'Day 2',
                active: _selectedDay == 1,
                onTap: () => setState(() => _selectedDay = 1),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            routeTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => _ScheduleTile(entry: item)),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.transparent,
                child: Text(
                  '\$',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border),
            ),
            child: Column(
              children: const [
                _PriceRow(label: 'Adult (>10 years old)', value: '\$400.00'),
                Divider(height: 1, color: _border),
                _PriceRow(label: 'Child (5 - 10 years old)', value: '\$320.00'),
                Divider(height: 1, color: _border),
                _PriceRow(label: 'Child (<5 years old)', value: 'Free'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderActionIcon extends StatelessWidget {
  const _HeaderActionIcon({
    required this.assetPath,
    this.onTap,
  });

  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(78, 110, 150, 0.72),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: Image.asset(assetPath, width: 18, height: 18)),
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
      width: 16,
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
          style: const TextStyle(fontSize: 16, color: _TourDetailScreenState._textSecondary),
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
            color: active ? Colors.white : _TourDetailScreenState._textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ScheduleEntry {
  const _ScheduleEntry({
    required this.time,
    required this.description,
  });

  final String time;
  final String description;
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({required this.entry});

  final _ScheduleEntry entry;

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
                  entry.time,
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
          const VerticalDivider(width: 1, color: _TourDetailScreenState._border),
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
