import '../../domain/entities/time_slot.dart';

class TimeSlotModel extends TimeSlot {
  const TimeSlotModel({
    required super.id,
    required super.doctorId,
    super.clinicId,
    required super.startTime,
    required super.endTime,
    required super.status,
    super.appointmentId,
    super.scheduleId,
    super.createdAt,
    super.updatedAt,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      id: json['id'].toString(),
      doctorId: json['doctor_id'].toString(),
      clinicId: json['clinic_id']?.toString(),
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      status: TimeSlotStatusExtension.fromString(json['status']),
      appointmentId: json['appointment_id']?.toString(),
      scheduleId: json['schedule_id']?.toString(),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'clinic_id': clinicId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'status': status.name,
      'appointment_id': appointmentId,
      'schedule_id': scheduleId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  TimeSlotModel copyWith({
    String? id,
    String? doctorId,
    String? clinicId,
    DateTime? startTime,
    DateTime? endTime,
    TimeSlotStatus? status,
    String? appointmentId,
    String? scheduleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TimeSlotModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      clinicId: clinicId ?? this.clinicId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      appointmentId: appointmentId ?? this.appointmentId,
      scheduleId: scheduleId ?? this.scheduleId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}