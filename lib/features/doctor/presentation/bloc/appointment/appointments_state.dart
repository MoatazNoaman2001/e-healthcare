part of 'appointments_bloc.dart';


abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const AppointmentsLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class TodayAppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const TodayAppointmentsLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class UpcomingAppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const UpcomingAppointmentsLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class PastAppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const PastAppointmentsLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class AppointmentDetailsLoaded extends AppointmentState {
  final Appointment appointment;

  const AppointmentDetailsLoaded({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentCreated extends AppointmentState {
  final Appointment appointment;

  const AppointmentCreated({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentUpdated extends AppointmentState {
  final Appointment appointment;

  const AppointmentUpdated({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentDeleted extends AppointmentState {}

class AppointmentCancelled extends AppointmentState {
  final Appointment appointment;

  const AppointmentCancelled({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentCompleted extends AppointmentState {
  final Appointment appointment;

  const AppointmentCompleted({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentConfirmed extends AppointmentState {
  final Appointment appointment;

  const AppointmentConfirmed({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentMarkedNoShow extends AppointmentState {
  final Appointment appointment;

  const AppointmentMarkedNoShow({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentRescheduled extends AppointmentState {
  final Appointment appointment;

  const AppointmentRescheduled({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentError extends AppointmentState {
  final Failure failure;

  const AppointmentError({required this.failure});

  @override
  List<Object?> get props => [failure];
}