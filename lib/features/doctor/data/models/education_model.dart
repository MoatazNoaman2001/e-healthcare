import '../../domain/entities/educations.dart';

class EducationModel extends Education {
  const EducationModel({
    required super.id,
    required super.doctorId,
    required super.institution,
    required super.degree,
    super.fieldOfStudy,
    required super.startDate,
    super.endDate,
    required super.isCurrentlyStudying,
    super.createdAt,
    super.updatedAt,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'].toString(),
      doctorId: json['doctor_id'].toString(),
      institution: json['institution'],
      degree: json['degree'],
      fieldOfStudy: json['field_of_study'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isCurrentlyStudying: json['is_currently_studying'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'institution': institution,
      'degree': degree,
      'field_of_study': fieldOfStudy,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_currently_studying': isCurrentlyStudying,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  EducationModel copyWith({
    String? id,
    String? doctorId,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyStudying,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EducationModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}