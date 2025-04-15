abstract class AppointmentBookingEvent {}

class SelectDate extends AppointmentBookingEvent {
  final DateTime date;
  SelectDate(this.date);
}

class SelectTimeSlot extends AppointmentBookingEvent {
  final String slot;
  SelectTimeSlot(this.slot);
}

class SelectReason extends AppointmentBookingEvent {
  final String reason;
  SelectReason(this.reason);
}
