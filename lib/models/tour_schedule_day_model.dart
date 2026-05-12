import 'tour_schedule_entry_model.dart';

class TourScheduleDayModel {
  const TourScheduleDayModel({required this.label, required this.entries});

  final String label;
  final List<TourScheduleEntryModel> entries;
}
