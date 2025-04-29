part of 'appointments_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class GetAppointmentsEvent extends AppointmentEvent {
  final String doctorId;

  const GetAppointmentsEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetTodayAppointmentsEvent extends AppointmentEvent {
  final String doctorId;

  const GetTodayAppointmentsEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetUpcomingAppointmentsEvent extends AppointmentEvent {
  final String doctorId;

  const GetUpcomingAppointmentsEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetPastAppointmentsEvent extends AppointmentEvent {
  final String doctorId;

  const GetPastAppointmentsEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetAppointmentDetailsEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;

  const GetAppointmentDetailsEvent({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId];
}

class CreateAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final Appointment appointment;

  const CreateAppointmentEvent({
    required this.doctorId,
    required this.appointment,
  });

  @override
  List<Object?> get props => [doctorId, appointment];
}

class UpdateAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final Appointment appointment;

  const UpdateAppointmentEvent({
    required this.doctorId,
    required this.appointment,
  });

  @override
  List<Object?> get props => [doctorId, appointment];
}

class DeleteAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;

  const DeleteAppointmentEvent({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId];
}

class CancelAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;

  const CancelAppointmentEvent({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId];
}

class CompleteAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;

  const CompleteAppointmentEvent({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId];
}

class ConfirmAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;

  const ConfirmAppointmentEvent({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId];
}

class MarkNoShowEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;

  const MarkNoShowEvent({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId];
}

class RescheduleAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final String appointmentId;
  final DateTime newStartTime;
  final DateTime newEndTime;

  const RescheduleAppointmentEvent({
    required this.doctorId,
    required this.appointmentId,
    required this.newStartTime,
    required this.newEndTime,
  });

  @override
  List<Object?> get props => [doctorId, appointmentId, newStartTime, newEndTime];
}

