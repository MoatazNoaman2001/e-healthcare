import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final int doctorId;
  final int userId;
  final String firstName;
  final String lastName;
  final String title;
  final String specialization;
  final String? imageUrl;

  const Doctor({
    required this.doctorId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.specialization,
    this.imageUrl,
  });

  String get fullName => '$firstName $lastName';

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctor_id'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      title: json['title'],
      specialization: json['specialization'],
      imageUrl: json['image_url'],
    );
  }

  @override
  List<Object?> get props => [doctorId, userId, firstName, lastName, title, specialization, imageUrl];
}
