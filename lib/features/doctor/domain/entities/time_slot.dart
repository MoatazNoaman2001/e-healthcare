enum TimeSlotStatus {
  available,
  booked,
  blocked,
  unavailable
}

extension TimeSlotStatusExtension on TimeSlotStatus {
  static TimeSlotStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return TimeSlotStatus.available;
      case 'booked':
        return TimeSlotStatus.booked;
      case 'blocked':
        return TimeSlotStatus.blocked;
      case 'unavailable':
        return TimeSlotStatus.unavailable;
      default:
        return TimeSlotStatus.unavailable;
    }
  }

  String get name {
    switch (this) {
      case TimeSlotStatus.available:
        return 'available';
      case TimeSlotStatus.booked:
        return 'booked';
      case TimeSlotStatus.blocked:
        return 'blocked';
      case TimeSlotStatus.unavailable:
        return 'unavailable';
    }
  }
}

class TimeSlot {
  final String id;
  final String doctorId;
  final String? clinicId;
  final DateTime startTime;
  final DateTime endTime;
  final TimeSlotStatus status;
  final String? appointmentId;
  final String? scheduleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TimeSlot({
    required this.id,
    required this.doctorId,
    this.clinicId,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.appointmentId,
    this.scheduleId,
    this.createdAt,
    this.updatedAt,
  });

  Duration get duration {
    return endTime.difference(startTime);
  }
}