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
    final doctorIdValue = json['doctor_id'];
    final userIdValue = json['user_id'];

    return Doctor(
      doctorId: doctorIdValue is int ? doctorIdValue : int.tryParse(doctorIdValue?.toString() ?? '0') ?? 0,
      userId: userIdValue is int ? userIdValue : int.tryParse(userIdValue?.toString() ?? '0') ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      specialization: json['specialization']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
    );
  }

  @override
  List<Object?> get props => [doctorId, userId, firstName, lastName, title, specialization, imageUrl];
}
