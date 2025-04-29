class Doctor {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? specialization;
  final String? licenseNumber;
  final String? profilePicture;
  final String? bio;
  final String? clinicAddress;

  const Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.specialization,
    this.licenseNumber,
    this.profilePicture,
    this.bio,
    this.clinicAddress,
  });

  String get fullName => '$firstName $lastName';
}