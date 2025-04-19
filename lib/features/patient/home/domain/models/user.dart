import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String email;
  final String phoneNumber;
  final String userType;
  final String profileStatus;

  const User({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.profileStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      userType: json['user_type'],
      profileStatus: json['profile_status'],
    );
  }

  @override
  List<Object?> get props => [userId, email, phoneNumber, userType, profileStatus];
}
