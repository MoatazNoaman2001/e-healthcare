// lib/features/appointments/presentation/bloc/appointments_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_appointments_usecase.dart';
import '../../domain/entities/appointment_entity.dart';
import 'appointments_event.dart';
import 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final LoadAppointmentsUseCase loadAppointments;

  AppointmentsBloc(this.loadAppointments) : super(AppointmentsState.initial()) {
    on<LoadAppointmentsEvent>(_onLoadAppointments);
    on<CancelAppointmentEvent>(_onCancelAppointment);
  }

  void _onLoadAppointments(
    LoadAppointmentsEvent event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final data = await loadAppointments();
      emit(state.copyWith(
        isLoading: false,
        upcoming: data['upcoming'],
        completed: data['completed'],
        cancelled: data['cancelled'],
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onCancelAppointment(
    CancelAppointmentEvent event,
    Emitter<AppointmentsState> emit,
  ) {
    final updatedUpcoming = state.upcoming.where((a) => a.id != event.appointmentId).toList();
    final cancelled = state.upcoming.firstWhere((a) => a.id == event.appointmentId);
    emit(state.copyWith(
      upcoming: updatedUpcoming,
      cancelled: [...state.cancelled, cancelled],
    ));
  }
}
