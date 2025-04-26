import 'package:doctorapp/features/doctor/doctor_profile/domain/models/doctor_model.dart';
import 'package:equatable/equatable.dart';


abstract class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object?> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileLoaded extends DoctorProfileState {
  final Doctor doctor;

  const DoctorProfileLoaded(this.doctor);

  @override
  List<Object?> get props => [doctor];
}

class DoctorProfileError extends DoctorProfileState {
  final String message;

  const DoctorProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
