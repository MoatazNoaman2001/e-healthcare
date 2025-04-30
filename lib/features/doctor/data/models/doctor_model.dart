import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  const DoctorModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    super.specialization,
    super.licenseNumber,
    super.profilePicture,
    super.bio,
    super.clinicAddress,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'].toString(),
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email']?? "",
      phoneNumber: json['phone_number']?? "",
      specialization: json['specialization'] ?? "",
      licenseNumber: json['license_number']?? "",
      profilePicture: json['profile_picture'] ?? "",
      bio: json['bio']?? "",
      clinicAddress: json['clinic_address']?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'specialization': specialization,
      'license_number': licenseNumber,
      'profile_picture': profilePicture,
      'bio': bio,
      'clinic_address': clinicAddress,
    };
  }
}