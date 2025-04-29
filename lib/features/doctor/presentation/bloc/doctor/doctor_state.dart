part of 'doctor_bloc.dart';


abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class MyProfileLoaded extends DoctorState {
  final Doctor doctor;

  const MyProfileLoaded({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class DoctorProfileLoaded extends DoctorState {
  final Doctor doctor;

  const DoctorProfileLoaded({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class DoctorProfileUpdated extends DoctorState {
  final Doctor doctor;

  const DoctorProfileUpdated({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class DoctorRegistered extends DoctorState {
  final Doctor doctor;

  const DoctorRegistered({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class DoctorError extends DoctorState {
  final Failure failure;

  const DoctorError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
