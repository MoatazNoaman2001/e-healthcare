import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final int appointmentId;
  final int patientId;
  final int doctorId;
  final int clinicId;
  final DateTime scheduledDateTime;
  final String status;
  final String type;

  // Additional fields for UI display
  final String? doctorName;
  final String? specialization;
  final String? clinicName;

  const Appointment({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.clinicId,
    required this.scheduledDateTime,
    required this.status,
    required this.type,
    this.doctorName,
    this.specialization,
    this.clinicName,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointment_id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      clinicId: json['clinic_id'],
      scheduledDateTime: DateTime.parse(json['scheduled_date_time']),
      status: json['status'],
      type: json['type'],
      doctorName: json['doctor_name'],
      specialization: json['specialization'],
      clinicName: json['clinic_name'],
    );
  }

  @override
  List<Object?> get props => [
    appointmentId,
    patientId,
    doctorId,
    clinicId,
    scheduledDateTime,
    status,
    type,
    doctorName,
    specialization,
    clinicName,
  ];
}