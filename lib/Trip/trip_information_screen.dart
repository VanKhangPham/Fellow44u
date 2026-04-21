import 'package:flutter/material.dart';

import 'new_attractions_screen.dart';

class TripInformationScreen extends StatefulWidget {
  const TripInformationScreen({super.key});

  static const Color primary = Color(0xFF00C7A7);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color border = Color(0xFFE0E0E0);

  @override
  State<TripInformationScreen> createState() => _TripInformationScreenState();
}

class _TripInformationScreenState extends State<TripInformationScreen> {
  static const Set<String> _builtInAttractions = {
    'Dragon Bridge',
    'Cham Museum',
    'My Khe Beach',
  };

  DateTime? _selectedDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;
  int _travelerCount = 1;
  final Set<String> _selectedAttractions = {'Dragon Bridge', 'My Khe Beach'};

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickFromTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _fromTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      setState(() => _fromTime = picked);
    }
  }

  Future<void> _pickToTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _toTime ?? const TimeOfDay(hour: 17, minute: 0),
    );
    if (picked != null) {
      setState(() => _toTime = picked);
    }
  }

  void _toggleAttraction(String title) {
    setState(() {
      if (_selectedAttractions.contains(title)) {
        _selectedAttractions.remove(title);
      } else {
        _selectedAttractions.add(title);
      }
    });
  }

  Future<void> _openNewAttractions() async {
    final result = await Navigator.of(context).push<Set<String>>(
      MaterialPageRoute(
        builder: (context) => NewAttractionsScreen(
          initialSelection: _selectedAttractions,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _selectedAttractions
          ..clear()
          ..addAll(result);
      });
    }
  }

  String get _dateLabel {
    final date = _selectedDate;
    if (date == null) {
      return 'mm/dd/yy';
    }
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year.toString().substring(2)}';
  }

  String _formatTime(TimeOfDay? time, String placeholder) {
    if (time == null) {
      return placeholder;
    }
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final suffix = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $suffix';
  }

  List<String> get _customAttractions => _selectedAttractions
      .where((item) => !_builtInAttractions.contains(item))
      .toList();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.black87),
                  ),
                  const Expanded(
                    child: Text(
                      'Trip Information',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: TripInformationScreen.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 24 + bottomInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: TripInformationScreen.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _InputLine(
                      icon: Icons.calendar_today_outlined,
                      label: _dateLabel,
                      labelColor: _selectedDate == null
                          ? TripInformationScreen.textSecondary
                          : TripInformationScreen.textPrimary,
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: TripInformationScreen.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _InputLine(
                            icon: Icons.access_time_outlined,
                            label: _formatTime(_fromTime, 'From'),
                            labelColor: _fromTime == null
                                ? TripInformationScreen.textSecondary
                                : TripInformationScreen.textPrimary,
                            onTap: _pickFromTime,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _InputLine(
                            icon: Icons.access_time_outlined,
                            label: _formatTime(_toTime, 'To'),
                            labelColor: _toTime == null
                                ? TripInformationScreen.textSecondary
                                : TripInformationScreen.textPrimary,
                            onTap: _pickToTime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'City',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: TripInformationScreen.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const _InputLine(
                      icon: Icons.location_on_outlined,
                      label: 'Danang',
                      labelColor: TripInformationScreen.textPrimary,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Number of travelers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: TripInformationScreen.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _StepperButton(
                          icon: Icons.keyboard_arrow_down_rounded,
                          onTap: _travelerCount > 1
                              ? () => setState(() => _travelerCount--)
                              : null,
                        ),
                        Container(
                          width: 82,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: TripInformationScreen.border,
                              ),
                            ),
                          ),
                          child: Text(
                            '$_travelerCount',
                            style: const TextStyle(
                              fontSize: 16,
                              color: TripInformationScreen.textPrimary,
                            ),
                          ),
                        ),
                        _StepperButton(
                          icon: Icons.keyboard_arrow_up_rounded,
                          onTap: () => setState(() => _travelerCount++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Attractions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: TripInformationScreen.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.22,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _AddAttractionCard(
                          onTap: _openNewAttractions,
                        ),
                        _AttractionCard(
                          title: 'Dragon Bridge',
                          imagePath:
                              'assets/images/trip_information/51414a035e8038967a7f919ee4da7a5fcf080c96.jpg',
                          selected:
                              _selectedAttractions.contains('Dragon Bridge'),
                          onTap: () => _toggleAttraction('Dragon Bridge'),
                        ),
                        _AttractionCard(
                          title: 'Cham Museum',
                          imagePath:
                              'assets/images/trip_information/d71237a5361fac18bae734ec580522bee9c8b09a.jpg',
                          selected:
                              _selectedAttractions.contains('Cham Museum'),
                          onTap: () => _toggleAttraction('Cham Museum'),
                        ),
                        _AttractionCard(
                          title: 'My Khe Beach',
                          imagePath:
                              'assets/images/trip_information/3c81e523d054dd0f67c96d6c7dc0d797c5c12c40.jpg',
                          selected:
                              _selectedAttractions.contains('My Khe Beach'),
                          onTap: () => _toggleAttraction('My Khe Beach'),
                        ),
                      ],
                    ),
                    if (_customAttractions.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _customAttractions
                            .map(
                              (item) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 199, 167, 0.1),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: TripInformationScreen.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _toggleAttraction(item),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: TripInformationScreen.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    const SizedBox(height: 38),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TripInformationScreen.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'DONE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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

class _InputLine extends StatelessWidget {
  const _InputLine({
    required this.icon,
    required this.label,
    required this.labelColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color labelColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: TripInformationScreen.textPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: labelColor),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: TripInformationScreen.border),
          ),
        ),
        child: content,
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: enabled
              ? TripInformationScreen.primary
              : TripInformationScreen.textSecondary,
        ),
      ),
    );
  }
}

class _AddAttractionCard extends StatelessWidget {
  const _AddAttractionCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE9E9E9)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 34,
              color: TripInformationScreen.primary,
            ),
            SizedBox(height: 8),
            Text(
              'Add New',
              style: TextStyle(
                fontSize: 16,
                color: TripInformationScreen.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttractionCard extends StatelessWidget {
  const _AttractionCard({
    required this.title,
    required this.imagePath,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color.fromRGBO(0, 0, 0, 0.45),
                    selected
                        ? const Color.fromRGBO(0, 199, 167, 0.18)
                        : Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            if (selected)
              const Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: TripInformationScreen.primary,
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
