import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.patientName,
    required super.startTime,
    required super.endTime,
    required super.appointmentType,
    required super.status,
    super.notes,
    super.patientId,
    super.doctorId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'].toString(),
      patientName: json['patient_name'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      appointmentType: json['appointment_type'],
      status: AppointmentStatusExtension.fromString(json['status']),
      notes: json['notes'],
      patientId: json['patient_id']?.toString(),
      doctorId: json['doctor_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_name': patientName,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'appointment_type': appointmentType,
      'status': status.name,
      'notes': notes,
      'patient_id': patientId,
      'doctor_id': doctorId,
    };
  }
}