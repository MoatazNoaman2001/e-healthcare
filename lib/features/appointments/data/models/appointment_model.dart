// lib/features/appointments/data/models/appointment_model.dart

import '../../domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    required super.id,
    required super.doctor,
    required super.specialty,
    required super.date,
    required super.time,
    required super.status,
    required super.clinicAddress,
    super.review,
    super.cancelReason,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctor: json['doctor'],
      specialty: json['specialty'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      status: json['status'],
      clinicAddress: json['clinicAddress'],
      review: json['review'],
      cancelReason: json['cancelReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor,
      'specialty': specialty,
      'date': date.toIso8601String(),
      'time': time,
      'status': status,
      'clinicAddress': clinicAddress,
      'review': review,
      'cancelReason': cancelReason,
    };
  }
}
