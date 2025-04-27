class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String specialization;
  final int experience;
  final String? bio;
  final String? phone;
  final String? imageUrl;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.specialization,
    required this.experience,
    this.bio,
    this.phone,
    this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['user'] != null ? json['user']['email'] ?? '' : '',
      specialization: (json['specializations_list'] != null && json['specializations_list'].isNotEmpty)
          ? json['specializations_list'][0]
          : '',
      experience: json['years_of_experience'] ?? 0,
      bio: json['bio'],
      phone: json['user'] != null ? json['user']['phone_number'] : null,
      imageUrl: json['profile_image'],
    );
  }
}
