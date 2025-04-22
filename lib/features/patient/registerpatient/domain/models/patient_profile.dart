class PatientProfile {
  final int id;
  final UserData user;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String bloodType;
  final double? height;
  final double? weight;
  final String? allergies;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelationship;
  final bool isInsured;
  final String? insuranceProvider;
  final String? insurancePolicyNumber;
  final String? insuranceExpiryDate;
  final String? notes;
  final int age;
  final String fullName;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> addresses;
  final List<dynamic> medicalHistory;
  final List<dynamic> medications;
  final List<dynamic> familyMedicalHistory;

  PatientProfile({
    required this.id,
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodType,
    this.height,
    this.weight,
    this.allergies,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelationship,
    required this.isInsured,
    this.insuranceProvider,
    this.insurancePolicyNumber,
    this.insuranceExpiryDate,
    this.notes,
    required this.age,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
    required this.addresses,
    required this.medicalHistory,
    required this.medications,
    required this.familyMedicalHistory,
  });

  factory PatientProfile.fromJson(Map<String, dynamic> json) {
    return PatientProfile(
      id: json['id'],
      user: UserData.fromJson(json['user']),
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      bloodType: json['blood_type'] ?? '',
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      allergies: json['allergies'],
      emergencyContactName: json['emergency_contact_name'],
      emergencyContactPhone: json['emergency_contact_phone'],
      emergencyContactRelationship: json['emergency_contact_relationship'],
      isInsured: json['is_insured'] ?? false,
      insuranceProvider: json['insurance_provider'],
      insurancePolicyNumber: json['insurance_policy_number'],
      insuranceExpiryDate: json['insurance_expiry_date'],
      notes: json['notes'],
      age: json['age'] ?? 0,
      fullName: json['full_name'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      addresses: json['addresses'] ?? [],
      medicalHistory: json['medical_history'] ?? [],
      medications: json['medications'] ?? [],
      familyMedicalHistory: json['family_medical_history'] ?? [],
    );
  }
}

class UserData {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String userType;
  final String profileStatus;
  final String? profileImage;
  final bool emailVerified;
  final bool phoneVerified;
  final String dateJoined;
  final String lastLogin;

  UserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.userType,
    required this.profileStatus,
    this.profileImage,
    required this.emailVerified,
    required this.phoneVerified,
    required this.dateJoined,
    required this.lastLogin,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'],
      userType: json['user_type'] ?? '',
      profileStatus: json['profile_status'] ?? '',
      profileImage: json['profile_image'],
      emailVerified: json['email_verified'] ?? false,
      phoneVerified: json['phone_verified'] ?? false,
      dateJoined: json['date_joined'] ?? '',
      lastLogin: json['last_login'] ?? '',
    );
  }
}

// This is our user model that will be used in the UI
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String birthDate;
  final String bloodType;
  final String height;
  final String weight;
  final String insuranceCompany;
  final String insuranceNumber;
  final String insuranceExpiry;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.insuranceCompany,
    required this.insuranceNumber,
    required this.insuranceExpiry,
  });

  factory UserProfile.fromPatientProfile(PatientProfile profile) {
    return UserProfile(
      name: profile.fullName,
      email: profile.user.email,
      phone: profile.user.phoneNumber ?? 'لا يوجد',
      birthDate: profile.dateOfBirth,
      bloodType: profile.bloodType,
      height: profile.height != null ? '${profile.height} سم' : 'لا يوجد',
      weight: profile.weight != null ? '${profile.weight} كجم' : 'لا يوجد',
      insuranceCompany: profile.insuranceProvider ?? 'لا يوجد',
      insuranceNumber: profile.insurancePolicyNumber ?? 'لا يوجد',
      insuranceExpiry: profile.insuranceExpiryDate ?? 'لا يوجد',
    );
  }
}