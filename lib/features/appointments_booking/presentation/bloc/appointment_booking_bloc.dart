import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_booking_event.dart';
import 'appointment_booking_state.dart';

class AppointmentBookingBloc extends Bloc<AppointmentBookingEvent, AppointmentBookingState> {
  AppointmentBookingBloc() : super(const AppointmentBookingState()) {
    on<SelectDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });
    on<SelectTimeSlot>((event, emit) {
      emit(state.copyWith(selectedTimeSlot: event.slot));
    });
    on<SelectReason>((event, emit) {
      emit(state.copyWith(selectedReason: event.reason));
    });
  }
}
