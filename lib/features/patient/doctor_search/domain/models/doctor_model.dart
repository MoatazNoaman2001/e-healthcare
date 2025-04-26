class DoctorModel {
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

  DoctorModel({
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

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctor_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      title: json['title'] ?? '',
      specialization: json['specialization'] ?? '',
      imageUrl: json['image_url'],
      rating: (json['rating'] as num?)?.toDouble(),
      experience: (json['experience'] as num?)?.toInt(),
      nextAvailableSlot: json['next_available_slot'],
      isAvailable: json['is_available'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'title': title,
      'specialization': specialization,
      'image_url': imageUrl,
      'rating': rating,
      'experience': experience,
      'next_available_slot': nextAvailableSlot,
      'is_available': isAvailable,
    };
  }

  String get fullName => '$title. $firstName $lastName';

  String get availableSlot => nextAvailableSlot ?? 'غير متاح';
}
