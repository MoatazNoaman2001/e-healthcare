// lib/features/auth/data/models/user_model.dart
class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      userType: json['user_type'],
      profileStatus: json['profile_status'],
      profileImage: json['profile_image'],
      emailVerified: json['email_verified'],
      phoneVerified: json['phone_verified'],
      dateJoined: json['date_joined'],
      lastLogin: json['last_login'],
    );
  }

  // Converting the UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'user_type': userType,
      'profile_status': profileStatus,
      'profile_image': profileImage,
      'email_verified': emailVerified,
      'phone_verified': phoneVerified,
      'date_joined': dateJoined,
      'last_login': lastLogin,
    };
  }

  // Helper methods to get the full name
  String get fullName => '$firstName $lastName';

  // Create a copy with some fields updated
  UserModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? userType,
    String? profileStatus,
    String? profileImage,
    bool? emailVerified,
    bool? phoneVerified,
    String? dateJoined,
    String? lastLogin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      profileStatus: profileStatus ?? this.profileStatus,
      profileImage: profileImage ?? this.profileImage,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      dateJoined: dateJoined ?? this.dateJoined,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}