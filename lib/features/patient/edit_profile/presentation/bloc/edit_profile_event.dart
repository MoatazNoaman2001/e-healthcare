import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends EditProfileEvent {
  final int patientId;
  final String name;
  final String phone;
  final String email;
  final String birthDate;

  const UpdateProfile({
    required this.patientId,
    required this.name,
    required this.phone,
    required this.email,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [patientId, name, phone, email, birthDate];
}
