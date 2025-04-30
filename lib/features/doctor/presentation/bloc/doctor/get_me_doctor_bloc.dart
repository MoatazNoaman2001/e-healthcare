import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/doctor.dart';
import '../../../domain/usecases/doctor/get_doctor_profile.dart';
import '../../../domain/usecases/doctor/get_my_profile.dart';
import '../../../domain/usecases/doctor/register_doctor.dart';
import '../../../domain/usecases/doctor/update_doctor_profile.dart';
import 'doctor_bloc.dart';


class GetMeDoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetMyProfile _getMyProfile;

  Doctor? doctor = null;

  GetMeDoctorBloc({
    required GetMyProfile getMyProfile,
  }) : _getMyProfile = getMyProfile,
        super(DoctorInitial()) {
    on<GetMyProfileEvent>(_onGetMyProfile);
  }

  Future<void> _onGetMyProfile(
      GetMyProfileEvent event,
      Emitter<DoctorState> emit,
      ) async {
    emit(DoctorLoading());

    final result = await _getMyProfile();

    result.fold(
          (failure){
            emit(DoctorError(failure: failure));
          },
          (doctor) {
            this.doctor = doctor;
            emit(MyProfileLoaded(doctor: doctor));
          },
    );
  }
}