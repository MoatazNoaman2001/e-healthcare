// lib/features/appointments/presentation/bloc/appointments_event.dart

abstract class AppointmentsEvent {}

class LoadAppointmentsEvent extends AppointmentsEvent {}

class CancelAppointmentEvent extends AppointmentsEvent {
  final String appointmentId;

  CancelAppointmentEvent(this.appointmentId);
}
