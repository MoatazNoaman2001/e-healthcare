// lib/features/appointments/presentation/bloc/appointments_state.dart

import '../../domain/entities/appointment_entity.dart';

class AppointmentsState {
  final List<AppointmentEntity> upcoming;
  final List<AppointmentEntity> completed;
  final List<AppointmentEntity> cancelled;

  final bool isLoading;
  final String? errorMessage;

  AppointmentsState({
    required this.upcoming,
    required this.completed,
    required this.cancelled,
    this.isLoading = false,
    this.errorMessage,
  });

  factory AppointmentsState.initial() => AppointmentsState(
        upcoming: [],
        completed: [],
        cancelled: [],
        isLoading: false,
      );

  AppointmentsState copyWith({
    List<AppointmentEntity>? upcoming,
    List<AppointmentEntity>? completed,
    List<AppointmentEntity>? cancelled,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AppointmentsState(
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
