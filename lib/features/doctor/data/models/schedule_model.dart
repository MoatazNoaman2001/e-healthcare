import '../../domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    required super.id,
    required super.doctorId,
    super.clinicId,
    required super.day,
    required super.startTime,
    required super.endTime,
    required super.slotDuration,
    required super.isAvailable,
    super.effectiveFrom,
    super.effectiveTo,
    super.createdAt,
    super.updatedAt,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'].toString(),
      doctorId: json['doctor_id'].toString(),
      clinicId: json['clinic_id']?.toString(),
      day: DayExtension.fromString(json['day']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      slotDuration: json['slot_duration'],
      isAvailable: json['is_available'],
      effectiveFrom: json['effective_from'] != null ? DateTime.parse(json['effective_from']) : null,
      effectiveTo: json['effective_to'] != null ? DateTime.parse(json['effective_to']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'clinic_id': clinicId,
      'day': day.name,
      'start_time': startTime,
      'end_time': endTime,
      'slot_duration': slotDuration,
      'is_available': isAvailable,
      'effective_from': effectiveFrom?.toIso8601String(),
      'effective_to': effectiveTo?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ScheduleModel copyWith({
    String? id,
    String? doctorId,
    String? clinicId,
    Day? day,
    String? startTime,
    String? endTime,
    int? slotDuration,
    bool? isAvailable,
    DateTime? effectiveFrom,
    DateTime? effectiveTo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      clinicId: clinicId ?? this.clinicId,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      slotDuration: slotDuration ?? this.slotDuration,
      isAvailable: isAvailable ?? this.isAvailable,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}