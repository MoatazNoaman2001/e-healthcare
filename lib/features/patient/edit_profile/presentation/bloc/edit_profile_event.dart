import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends EditProfileEvent {
  final int patientId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String birthDate;
  final String gender;
  final String bloodType;
  final String height;
  final String weight;
  final String? allergies;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelationship;
  final bool isInsured;
  final String? insuranceProvider;
  final String? insurancePolicyNumber;
  final String? insuranceExpiryDate;
  final String? notes;

  const UpdateProfile({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.bloodType,
    required this.height,
    required this.weight,
    this.allergies,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelationship,
    this.isInsured = true,
    this.insuranceProvider,
    this.insurancePolicyNumber,
    this.insuranceExpiryDate,
    this.notes,
  });

  @override
  List<Object?> get props => [
        patientId,
        firstName,
        lastName,
        email,
        phone,
        birthDate,
        gender,
        bloodType,
        height,
        weight,
        allergies,
        emergencyContactName,
        emergencyContactPhone,
        emergencyContactRelationship,
        isInsured,
        insuranceProvider,
        insurancePolicyNumber,
        insuranceExpiryDate,
        notes,
      ];
}
