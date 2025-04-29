class WorkExperience {
  final String id;
  final String doctorId;
  final String organization;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentlyWorking;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WorkExperience({
    required this.id,
    required this.doctorId,
    required this.organization,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.isCurrentlyWorking,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Duration get duration {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate);
  }

  int get durationInYears {
    final end = endDate ?? DateTime.now();
    return end.year - startDate.year;
  }
}

// 8. Insurance Entity
// domain/entities/insurance.dart
class Insurance {
  final String id;
  final String name;
  final String? description;
  final String? coverageDetails;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Insurance({
    required this.id,
    required this.name,
    this.description,
    this.coverageDetails,
    this.createdAt,
    this.updatedAt,
  });
}