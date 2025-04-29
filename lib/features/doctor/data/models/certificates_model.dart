import '../../domain/entities/certifications.dart';

class CertificationModel extends Certification {
  const CertificationModel({
    required super.id,
    required super.doctorId,
    required super.name,
    required super.issuingOrganization,
    required super.issueDate,
    super.expiryDate,
    super.credentialId,
    super.credentialUrl,
    super.createdAt,
    super.updatedAt,
  });

  factory CertificationModel.fromJson(Map<String, dynamic> json) {
    return CertificationModel(
      id: json['id'].toString(),
      doctorId: json['doctor_id'].toString(),
      name: json['name'],
      issuingOrganization: json['issuing_organization'],
      issueDate: DateTime.parse(json['issue_date']),
      expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) : null,
      credentialId: json['credential_id'],
      credentialUrl: json['credential_url'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'name': name,
      'issuing_organization': issuingOrganization,
      'issue_date': issueDate.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'credential_id': credentialId,
      'credential_url': credentialUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  CertificationModel copyWith({
    String? id,
    String? doctorId,
    String? name,
    String? issuingOrganization,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? credentialId,
    String? credentialUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CertificationModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      name: name ?? this.name,
      issuingOrganization: issuingOrganization ?? this.issuingOrganization,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      credentialId: credentialId ?? this.credentialId,
      credentialUrl: credentialUrl ?? this.credentialUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
