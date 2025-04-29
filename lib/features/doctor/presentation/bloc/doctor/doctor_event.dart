part of 'doctor_bloc.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object?> get props => [];
}

class GetMyProfileEvent extends DoctorEvent {}

class GetDoctorProfileEvent extends DoctorEvent {
  final String doctorId;

  const GetDoctorProfileEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class UpdateDoctorProfileEvent extends DoctorEvent {
  final Doctor doctor;

  const UpdateDoctorProfileEvent({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class RegisterDoctorEvent extends DoctorEvent {
  final Doctor doctor;
  final String password;

  const RegisterDoctorEvent({
    required this.doctor,
    required this.password,
  });

  @override
  List<Object?> get props => [doctor, password];
}
