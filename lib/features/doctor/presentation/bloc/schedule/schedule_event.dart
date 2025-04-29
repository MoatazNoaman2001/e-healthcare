part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class GetSchedulesEvent extends ScheduleEvent {
  final String doctorId;

  const GetSchedulesEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetSchedulesByClinicEvent extends ScheduleEvent {
  final String doctorId;

  const GetSchedulesByClinicEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetSchedulesByDoctorEvent extends ScheduleEvent {
  final String doctorId;

  const GetSchedulesByDoctorEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class GetScheduleDetailsEvent extends ScheduleEvent {
  final String doctorId;
  final String scheduleId;

  const GetScheduleDetailsEvent({
    required this.doctorId,
    required this.scheduleId,
  });

  @override
  List<Object?> get props => [doctorId, scheduleId];
}

class CreateScheduleEvent extends ScheduleEvent {
  final String doctorId;
  final Schedule schedule;

  const CreateScheduleEvent({
    required this.doctorId,
    required this.schedule,
  });

  @override
  List<Object?> get props => [doctorId, schedule];
}

class UpdateScheduleEvent extends ScheduleEvent {
  final String doctorId;
  final Schedule schedule;

  const UpdateScheduleEvent({
    required this.doctorId,
    required this.schedule,
  });

  @override
  List<Object?> get props => [doctorId, schedule];
}

class DeleteScheduleEvent extends ScheduleEvent {
  final String doctorId;
  final String scheduleId;

  const DeleteScheduleEvent({
    required this.doctorId,
    required this.scheduleId,
  });

  @override
  List<Object?> get props => [doctorId, scheduleId];
}
