enum AppointmentStatus {
  scheduled,
  confirmed,
  inProgress,
  completed,
  cancelled,
  noShow,
  rescheduled
}

extension AppointmentStatusExtension on AppointmentStatus {
  static AppointmentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return AppointmentStatus.scheduled;
      case 'confirmed':
        return AppointmentStatus.confirmed;
      case 'in_progress':
        return AppointmentStatus.inProgress;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'no_show':
        return AppointmentStatus.noShow;
      case 'rescheduled':
        return AppointmentStatus.rescheduled;
      default:
        return AppointmentStatus.scheduled;
    }
  }
}

class Appointment {
  final String id;
  final String patientName;
  final DateTime startTime;
  final DateTime endTime;
  final String appointmentType;
  final AppointmentStatus status;
  final String? notes;
  final String? patientId;
  final String? doctorId;

  const Appointment({
    required this.id,
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.appointmentType,
    required this.status,
    this.notes,
    this.patientId,
    this.doctorId,
  });

  Duration get duration {
    return endTime.difference(startTime);
  }

  bool get isPast {
    return DateTime.now().isAfter(endTime);
  }

  bool get isToday {
    final now = DateTime.now();
    return startTime.year == now.year &&
        startTime.month == now.month &&
        startTime.day == now.day;
  }
}