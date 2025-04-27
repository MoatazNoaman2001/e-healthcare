import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends EditProfileEvent {
  final int patientId;
  final String token;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String birthDate;
  final String gender;
  final String bloodType;
  final String height;
  final String weight;

  const UpdateProfile({
    required this.patientId,
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.bloodType,
    required this.height,
    required this.weight,
  });

  @override
  List<Object?> get props => [
        patientId,
        token,
        firstName,
        lastName,
        email,
        phone,
        birthDate,
        gender,
        bloodType,
        height,
        weight,
      ];
}
