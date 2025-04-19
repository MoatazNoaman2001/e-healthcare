import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';import 'package:equatable/equatable.dart';
import '../../domain/models/doctor_model.dart';
import '../../domain/models/specialty_model.dart';
import '../../domain/repo/doctor_repo.dart';

part 'search_doctor_event.dart';
part 'search_doctor_state.dart';

class DoctorSearchBloc extends Bloc<DoctorSearchEvent, DoctorSearchState> {
  final DoctorRepository repository;

  DoctorSearchBloc({required this.repository}) : super(const DoctorSearchState()) {
    on<SearchDoctorsEvent>(_onSearchDoctors);
    on<LoadSpecialtiesEvent>(_onLoadSpecialties);
  }

  Future<void> _onSearchDoctors(
      SearchDoctorsEvent event,
      Emitter<DoctorSearchState> emit,
      ) async {
    emit(state.copyWith(
      isLoading: true,
      error: null,
      query: event.query,
      selectedSpecialty: event.specialty,
    ));

    final result = await repository.searchDoctors(
      query: event.query,
      specialty: event.specialty,
    );

    result.fold(
          (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
          (doctors) => emit(state.copyWith(
        isLoading: false,
        doctors: doctors,
      )),
    );
  }

  Future<void> _onLoadSpecialties(
      LoadSpecialtiesEvent event,
      Emitter<DoctorSearchState> emit,
      ) async {
    if (state.specialties.isNotEmpty) return;

    emit(state.copyWith(isLoading: true));

    final result = await repository.getSpecialties();

    result.fold(
          (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
          (specialties) => emit(state.copyWith(
        isLoading: false,
        specialties: specialties,
      )),
    );
  }
}