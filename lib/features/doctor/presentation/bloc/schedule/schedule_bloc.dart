import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/schedule.dart';
import '../../../domain/usecases/schedule/create_schedule.dart';
import '../../../domain/usecases/schedule/delete_schedule.dart';
import '../../../domain/usecases/schedule/get_schedule.dart';
import '../../../domain/usecases/schedule/get_schedules.dart';
import '../../../domain/usecases/schedule/get_schedules_by_clinic.dart';
import '../../../domain/usecases/schedule/get_schedules_by_doctor.dart';
import '../../../domain/usecases/schedule/update_schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final CreateSchedule _createSchedule;
  final DeleteSchedule _deleteSchedule;
  final GetSchedule _getSchedule;
  final GetSchedules _getSchedules;
  final GetSchedulesByClinic _getSchedulesByClinic;
  final GetSchedulesByDoctor _getSchedulesByDoctor;
  final UpdateSchedule _updateSchedule;

  ScheduleBloc({
    required CreateSchedule createSchedule,
    required DeleteSchedule deleteSchedule,
    required GetSchedule getSchedule,
    required GetSchedules getSchedules,
    required GetSchedulesByClinic getSchedulesByClinic,
    required GetSchedulesByDoctor getSchedulesByDoctor,
    required UpdateSchedule updateSchedule,
  }) : _createSchedule = createSchedule,
        _deleteSchedule = deleteSchedule,
        _getSchedule = getSchedule,
        _getSchedules = getSchedules,
        _getSchedulesByClinic = getSchedulesByClinic,
        _getSchedulesByDoctor = getSchedulesByDoctor,
        _updateSchedule = updateSchedule,
        super(ScheduleInitial()) {
    on<GetSchedulesEvent>(_onGetSchedules);
    on<GetSchedulesByClinicEvent>(_onGetSchedulesByClinic);
    on<GetSchedulesByDoctorEvent>(_onGetSchedulesByDoctor);
    on<GetScheduleDetailsEvent>(_onGetScheduleDetails);
    on<CreateScheduleEvent>(_onCreateSchedule);
    on<UpdateScheduleEvent>(_onUpdateSchedule);
    on<DeleteScheduleEvent>(_onDeleteSchedule);
  }

  Future<void> _onGetSchedules(
      GetSchedulesEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _getSchedules(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (schedules) => emit(SchedulesLoaded(schedules: schedules)),
    );
  }

  Future<void> _onGetSchedulesByClinic(
      GetSchedulesByClinicEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _getSchedulesByClinic(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (schedules) => emit(SchedulesByClinicLoaded(schedules: schedules)),
    );
  }

  Future<void> _onGetSchedulesByDoctor(
      GetSchedulesByDoctorEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _getSchedulesByDoctor(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (schedules) => emit(SchedulesByDoctorLoaded(schedules: schedules)),
    );
  }

  Future<void> _onGetScheduleDetails(
      GetScheduleDetailsEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _getSchedule(
      doctorId: event.doctorId,
      scheduleId: event.scheduleId,
    );

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (schedule) => emit(ScheduleDetailsLoaded(schedule: schedule)),
    );
  }

  Future<void> _onCreateSchedule(
      CreateScheduleEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _createSchedule(
      doctorId: event.doctorId,
      schedule: event.schedule,
    );

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (schedule) => emit(ScheduleCreated(schedule: schedule)),
    );
  }

  Future<void> _onUpdateSchedule(
      UpdateScheduleEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _updateSchedule(
      doctorId: event.doctorId,
      schedule: event.schedule,
    );

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (schedule) => emit(ScheduleUpdated(schedule: schedule)),
    );
  }

  Future<void> _onDeleteSchedule(
      DeleteScheduleEvent event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(ScheduleLoading());

    final result = await _deleteSchedule(
      doctorId: event.doctorId,
      scheduleId: event.scheduleId,
    );

    result.fold(
          (failure) => emit(ScheduleError(failure: failure)),
          (_) => emit(ScheduleDeleted()),
    );
  }
}