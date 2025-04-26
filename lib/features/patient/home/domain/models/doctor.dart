import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final int doctorId;
  final int userId;
  final String firstName;
  final String lastName;
  final String title;
  final String specialization;
  final String? imageUrl;
  final double? rating;
  final int? experience;
  final String? nextAvailableSlot;
  final bool isAvailable;

  const Doctor({
    required this.doctorId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.specialization,
    this.imageUrl,
    this.rating,
    this.experience,
    this.nextAvailableSlot,
    this.isAvailable = true,
  });

  String get fullName => '$title. $firstName $lastName';

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
      rating: (json['rating'] as num?)?.toDouble(),
      experience: (json['experience'] as num?)?.toInt(),
      nextAvailableSlot: json['next_available_slot']?.toString(),
      isAvailable: json['is_available'] == true,
    );
  }

  @override
  List<Object?> get props => [
    doctorId,
    userId,
    firstName,
    lastName,
    title,
    specialization,
    imageUrl,
    rating,
    experience,
    nextAvailableSlot,
    isAvailable,
  ];
}
