import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final int patientId;
  final int userId;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;

  const Patient({
    required this.patientId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
  });

  String get fullName => '$firstName $lastName';

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      gender: json['gender'],
    );
  }

  @override
  List<Object?> get props => [patientId, userId, firstName, lastName, dateOfBirth, gender];
}
