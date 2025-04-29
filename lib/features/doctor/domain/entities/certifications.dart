class Certification {
  final String id;
  final String doctorId;
  final String name;
  final String issuingOrganization;
  final DateTime issueDate;
  final DateTime? expiryDate;
  final String? credentialId;
  final String? credentialUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Certification({
    required this.id,
    required this.doctorId,
    required this.name,
    required this.issuingOrganization,
    required this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.credentialUrl,
    this.createdAt,
    this.updatedAt,
  });

  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }
}