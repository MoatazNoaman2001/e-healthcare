import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../patient/appointments/presentation/bloc/appointments_event.dart';
import 'package:equatable/equatable.dart';
import '../../../../patient/appointments/presentation/bloc/appointments_state.dart';
import '../../../domain/entities/appointment.dart';
import '../../../domain/usecases/appointments/cancel_appointment.dart';
import '../../../domain/usecases/appointments/complete_appointment.dart';
import '../../../domain/usecases/appointments/confirm_appointment.dart';
import '../../../domain/usecases/appointments/create_appointment.dart';
import '../../../domain/usecases/appointments/delete_appointment.dart';
import '../../../domain/usecases/appointments/get_appointment.dart';
import '../../../domain/usecases/appointments/get_appointments.dart';
import '../../../domain/usecases/appointments/get_past_appointment.dart';
import '../../../domain/usecases/appointments/get_today_appointments.dart';
import '../../../domain/usecases/appointments/get_upcoming_appointments.dart';
import '../../../domain/usecases/appointments/mark_no_show.dart';
import '../../../domain/usecases/appointments/reschedule_appointment.dart';
import '../../../domain/usecases/appointments/update_appointment.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final CancelAppointment _cancelAppointment;
  final CompleteAppointment _completeAppointment;
  final ConfirmAppointment _confirmAppointment;
  final CreateAppointment _createAppointment;
  final DeleteAppointment _deleteAppointment;
  final GetAppointment _getAppointment;
  final GetAppointments _getAppointments;
  final GetPastAppointments _getPastAppointments;
  final GetTodayAppointments _getTodayAppointments;
  final GetUpcomingAppointments _getUpcomingAppointments;
  final MarkNoShow _markNoShow;
  final RescheduleAppointment _rescheduleAppointment;
  final UpdateAppointment _updateAppointment;

  AppointmentBloc({
    required CancelAppointment cancelAppointment,
    required CompleteAppointment completeAppointment,
    required ConfirmAppointment confirmAppointment,
    required CreateAppointment createAppointment,
    required DeleteAppointment deleteAppointment,
    required GetAppointment getAppointment,
    required GetAppointments getAppointments,
    required GetPastAppointments getPastAppointments,
    required GetTodayAppointments getTodayAppointments,
    required GetUpcomingAppointments getUpcomingAppointments,
    required MarkNoShow markNoShow,
    required RescheduleAppointment rescheduleAppointment,
    required UpdateAppointment updateAppointment,
  }) : _cancelAppointment = cancelAppointment,
        _completeAppointment = completeAppointment,
        _confirmAppointment = confirmAppointment,
        _createAppointment = createAppointment,
        _deleteAppointment = deleteAppointment,
        _getAppointment = getAppointment,
        _getAppointments = getAppointments,
        _getPastAppointments = getPastAppointments,
        _getTodayAppointments = getTodayAppointments,
        _getUpcomingAppointments = getUpcomingAppointments,
        _markNoShow = markNoShow,
        _rescheduleAppointment = rescheduleAppointment,
        _updateAppointment = updateAppointment,
        super(AppointmentInitial()) {
    on<GetTodayAppointmentsEvent>(_onGetTodayAppointments);
    on<GetUpcomingAppointmentsEvent>(_onGetUpcomingAppointments);
    on<GetPastAppointmentsEvent>(_onGetPastAppointments);
    on<GetAppointmentDetailsEvent>(_onGetAppointmentDetails);
    on<GetAppointmentsEvent>(_onGetAppointments);
    on<CreateAppointmentEvent>(_onCreateAppointment);
    on<UpdateAppointmentEvent>(_onUpdateAppointment);
    on<DeleteAppointmentEvent>(_onDeleteAppointment);
    on<CancelAppointmentEvent>(_onCancelAppointment);
    on<CompleteAppointmentEvent>(_onCompleteAppointment);
    on<ConfirmAppointmentEvent>(_onConfirmAppointment);
    on<MarkNoShowEvent>(_onMarkNoShow);
    on<RescheduleAppointmentEvent>(_onRescheduleAppointment);
  }

  Future<void> _onGetTodayAppointments(
      GetTodayAppointmentsEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _getTodayAppointments(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointments) => emit(TodayAppointmentsLoaded(appointments: appointments)),
    );
  }

  Future<void> _onGetAppointments(
      GetAppointmentsEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _getAppointments(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointments) => emit(AppointmentsLoaded(appointments: appointments)),
    );
  }

  Future<void> _onGetUpcomingAppointments(
      GetUpcomingAppointmentsEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _getUpcomingAppointments(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointments) => emit(UpcomingAppointmentsLoaded(appointments: appointments)),
    );
  }

  Future<void> _onGetPastAppointments(
      GetPastAppointmentsEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _getPastAppointments(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointments) => emit(PastAppointmentsLoaded(appointments: appointments)),
    );
  }

  Future<void> _onGetAppointmentDetails(
      GetAppointmentDetailsEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _getAppointment(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentDetailsLoaded(appointment: appointment)),
    );
  }

  Future<void> _onCreateAppointment(
      CreateAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _createAppointment(
      doctorId: event.doctorId,
      appointment: event.appointment,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentCreated(appointment: appointment)),
    );
  }

  Future<void> _onUpdateAppointment(
      UpdateAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _updateAppointment(
      doctorId: event.doctorId,
      appointment: event.appointment,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentUpdated(appointment: appointment)),
    );
  }

  Future<void> _onDeleteAppointment(
      DeleteAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _deleteAppointment(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (_) => emit(AppointmentDeleted()),
    );
  }

  Future<void> _onCancelAppointment(
      CancelAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _cancelAppointment(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentCancelled(appointment: appointment)),
    );
  }

  Future<void> _onCompleteAppointment(
      CompleteAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _completeAppointment(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentCompleted(appointment: appointment)),
    );
  }

  Future<void> _onConfirmAppointment(
      ConfirmAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _confirmAppointment(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentConfirmed(appointment: appointment)),
    );
  }

  Future<void> _onMarkNoShow(
      MarkNoShowEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _markNoShow(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentMarkedNoShow(appointment: appointment)),
    );
  }

  Future<void> _onRescheduleAppointment(
      RescheduleAppointmentEvent event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());

    final result = await _rescheduleAppointment(
      doctorId: event.doctorId,
      appointmentId: event.appointmentId,
      newStartTime: event.newStartTime,
      newEndTime: event.newEndTime,
    );

    result.fold(
          (failure) => emit(AppointmentError(failure: failure)),
          (appointment) => emit(AppointmentRescheduled(appointment: appointment)),
    );
  }
}
