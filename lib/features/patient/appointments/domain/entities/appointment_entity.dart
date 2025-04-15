// lib/features/appointments/domain/entities/appointment_entity.dart

class AppointmentEntity {
  final String id;
  final String doctor;
  final String specialty;
  final DateTime date;
  final String time;
  final String status;
  final String clinicAddress;
  final double? review;
  final String? cancelReason;

  AppointmentEntity({
    required this.id,
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.clinicAddress,
    this.review,
    this.cancelReason,
  });
}
