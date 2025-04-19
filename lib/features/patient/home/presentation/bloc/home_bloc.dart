import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/clinic.dart';
import '../../domain/models/doctor.dart';
import '../../domain/models/specialization.dart';
import '../../domain/models/appointment.dart';
import '../../domain/repo/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(const HomeState()) {
    on<FetchDoctorsEvent>(_onFetchDoctors);
    on<FetchSpecializationsEvent>(_onFetchSpecializations);
    on<FetchUpcomingAppointmentsEvent>(_onFetchUpcomingAppointments);
    on<FetchPastAppointmentsEvent>(_onFetchPastAppointments);
    on<FetchClinicsEvent>(_onFetchClinics);
  }

  Future<void> _onFetchDoctors(FetchDoctorsEvent event,
      Emitter<HomeState> emit,) async {
    emit(state.copyWith(isDoctorsLoading: true, doctorsError: null));

    final result = await repository.getDoctors(search: event.searchQuery);

    result.fold(
          (failure) => emit(state.copyWith(
        isDoctorsLoading: false,
        doctorsError: failure.toString(),
      )),
          (doctors) => emit(state.copyWith(
        isDoctorsLoading: false,
        doctors: doctors,
      )),
    );
  }

  Future<void> _onFetchSpecializations(
      FetchSpecializationsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isSpecializationsLoading: true, specializationsError: null));

    final result = await repository.getSpecializations(search: event.searchQuery);

    result.fold(
          (failure) => emit(state.copyWith(
        isSpecializationsLoading: false,
        specializationsError: failure.toString(),
      )),
          (specializations) => emit(state.copyWith(
        isSpecializationsLoading: false,
        specializations: specializations,
      )),
    );
  }

  Future<void> _onFetchUpcomingAppointments(
      FetchUpcomingAppointmentsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isUpcomingAppointmentsLoading: true, upcomingAppointmentsError: null));

    final result = await repository.getUpcomingAppointments(event.patientId);

    result.fold(
          (failure) => emit(state.copyWith(
        isUpcomingAppointmentsLoading: false,
        upcomingAppointmentsError: failure.toString(),
      )),
          (appointments) => emit(state.copyWith(
        isUpcomingAppointmentsLoading: false,
        upcomingAppointments: appointments,
      )),
    );
  }

  Future<void> _onFetchPastAppointments(
      FetchPastAppointmentsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isPastAppointmentsLoading: true, pastAppointmentsError: null));

    final result = await repository.getPastAppointments(event.patientId);

    result.fold(
          (failure) => emit(state.copyWith(
        isPastAppointmentsLoading: false,
        pastAppointmentsError: failure.toString(),
      )),
          (appointments) => emit(state.copyWith(
        isPastAppointmentsLoading: false,
        pastAppointments: appointments,
      )),
    );
  }

  Future<void> _onFetchClinics(
      FetchClinicsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isClinicsLoading: true, clinicsError: null));

    final result = await repository.getClinics();

    result.fold(
          (failure) => emit(state.copyWith(
        isClinicsLoading: false,
        clinicsError: failure.toString(),
      )),
          (clinics) => emit(state.copyWith(
        isClinicsLoading: false,
        clinics: clinics,
      )),
    );
  }
}
