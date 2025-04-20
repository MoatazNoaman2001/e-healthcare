part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchDoctorsEvent extends HomeEvent {
  final String? searchQuery;

  const FetchDoctorsEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class FetchSpecializationsEvent extends HomeEvent {
  final String? searchQuery;

  const FetchSpecializationsEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class FetchUpcomingAppointmentsEvent extends HomeEvent {
  final int patientId;

  const FetchUpcomingAppointmentsEvent({required this.patientId});

  @override
  List<Object?> get props => [patientId];
}

class FetchPastAppointmentsEvent extends HomeEvent {
  final int patientId;

  const FetchPastAppointmentsEvent({required this.patientId});

  @override
  List<Object?> get props => [patientId];
}

class FetchClinicsEvent extends HomeEvent {
  const FetchClinicsEvent();

  @override
  List<Object?> get props => [];
}
