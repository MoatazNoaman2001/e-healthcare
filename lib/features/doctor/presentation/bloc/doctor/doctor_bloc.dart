import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/doctor.dart';
import '../../../domain/usecases/doctor/get_doctor_profile.dart';
import '../../../domain/usecases/doctor/get_my_profile.dart';
import '../../../domain/usecases/doctor/register_doctor.dart';
import '../../../domain/usecases/doctor/update_doctor_profile.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetMyProfile _getMyProfile;
  final GetDoctorProfile _getDoctorProfile;
  final UpdateDoctorProfile _updateDoctorProfile;
  final RegisterDoctor _registerDoctor;

  DoctorBloc({
    required GetMyProfile getMyProfile,
    required GetDoctorProfile getDoctorProfile,
    required UpdateDoctorProfile updateDoctorProfile,
    required RegisterDoctor registerDoctor,
  }) : _getMyProfile = getMyProfile,
        _getDoctorProfile = getDoctorProfile,
        _updateDoctorProfile = updateDoctorProfile,
        _registerDoctor = registerDoctor,
        super(DoctorInitial()) {
    on<GetMyProfileEvent>(_onGetMyProfile);
    on<GetDoctorProfileEvent>(_onGetDoctorProfile);
    on<UpdateDoctorProfileEvent>(_onUpdateDoctorProfile);
    on<RegisterDoctorEvent>(_onRegisterDoctor);
  }

  Future<void> _onGetMyProfile(
      GetMyProfileEvent event,
      Emitter<DoctorState> emit,
      ) async {
    emit(DoctorLoading());

    final result = await _getMyProfile();

    result.fold(
          (failure) => emit(DoctorError(failure: failure)),
          (doctor) => emit(MyProfileLoaded(doctor: doctor)),
    );
  }

  Future<void> _onGetDoctorProfile(
      GetDoctorProfileEvent event,
      Emitter<DoctorState> emit,
      ) async {
    emit(DoctorLoading());

    final result = await _getDoctorProfile(doctorId: event.doctorId);

    result.fold(
          (failure) => emit(DoctorError(failure: failure)),
          (doctor) => emit(DoctorProfileLoaded(doctor: doctor)),
    );
  }

  Future<void> _onUpdateDoctorProfile(
      UpdateDoctorProfileEvent event,
      Emitter<DoctorState> emit,
      ) async {
    emit(DoctorLoading());

    final result = await _updateDoctorProfile(doctor: event.doctor);

    result.fold(
          (failure) => emit(DoctorError(failure: failure)),
          (doctor) => emit(DoctorProfileUpdated(doctor: doctor)),
    );
  }

  Future<void> _onRegisterDoctor(
      RegisterDoctorEvent event,
      Emitter<DoctorState> emit,
      ) async {
    emit(DoctorLoading());

    final result = await _registerDoctor(
      doctor: event.doctor,
      password: event.password,
    );

    result.fold(
          (failure) => emit(DoctorError(failure: failure)),
          (doctor) => emit(DoctorRegistered(doctor: doctor)),
    );
  }
}