import 'package:doctorapp/features/doctor/doctor_profile/data/services/doctor_service.dart';
import 'package:doctorapp/features/doctor/doctor_profile/presentation/bloc/doctor_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_profile_event.dart';


class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  final DoctorService doctorService;

  DoctorProfileBloc(this.doctorService) : super(DoctorProfileInitial()) {
    on<LoadDoctorProfile>((event, emit) async {
      emit(DoctorProfileLoading());
      try {
        final doctor = await doctorService.getProfile(event.token);
        emit(DoctorProfileLoaded(doctor));
      } catch (e) {
        emit(DoctorProfileError('فشل تحميل البروفايل'));
      }
    });
  }
}
