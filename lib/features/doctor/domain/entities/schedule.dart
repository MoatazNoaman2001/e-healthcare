enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

extension DayExtension on Day {
  static Day fromString(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return Day.monday;
      case 'tuesday':
        return Day.tuesday;
      case 'wednesday':
        return Day.wednesday;
      case 'thursday':
        return Day.thursday;
      case 'friday':
        return Day.friday;
      case 'saturday':
        return Day.saturday;
      case 'sunday':
        return Day.sunday;
      default:
        throw ArgumentError('Invalid day: $day');
    }
  }

  String get name {
    switch (this) {
      case Day.monday:
        return 'monday';
      case Day.tuesday:
        return 'tuesday';
      case Day.wednesday:
        return 'wednesday';
      case Day.thursday:
        return 'thursday';
      case Day.friday:
        return 'friday';
      case Day.saturday:
        return 'saturday';
      case Day.sunday:
        return 'sunday';
    }
  }
}

class Schedule {
  final String id;
  final String doctorId;
  final String? clinicId;
  final Day day;
  final String startTime; // Format: "HH:MM"
  final String endTime; // Format: "HH:MM"
  final int slotDuration; // in minutes
  final bool isAvailable;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Schedule({
    required this.id,
    required this.doctorId,
    this.clinicId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.isAvailable,
    this.effectiveFrom,
    this.effectiveTo,
    this.createdAt,
    this.updatedAt,
  });
}