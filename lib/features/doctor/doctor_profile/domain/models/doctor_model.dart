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
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      specialization: json['specialization'],
      experience: json['experience'],
      bio: json['bio'],
      phone: json['phone'],
      imageUrl: json['image_url'],
    );
  }
}
