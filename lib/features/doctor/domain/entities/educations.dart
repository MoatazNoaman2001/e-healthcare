class Education {
  final String id;
  final String doctorId;
  final String institution;
  final String degree;
  final String? fieldOfStudy;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentlyStudying;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Education({
    required this.id,
    required this.doctorId,
    required this.institution,
    required this.degree,
    this.fieldOfStudy,
    required this.startDate,
    this.endDate,
    required this.isCurrentlyStudying,
    this.createdAt,
    this.updatedAt,
  });
}