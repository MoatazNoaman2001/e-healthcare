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
}