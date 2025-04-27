class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String dateOfBirth;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    required this.dateOfBirth,
  });

  // عشان لو بتيجي البيانات من API بصيغة JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'] ?? '',
    );
  }

  // ولو محتاجة ترسلي بيانات للسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
    };
  }
}
