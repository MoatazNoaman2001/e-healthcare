import 'package:doctorapp/core/network/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';


class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ApiService apiService; // Inject ApiService (مثلا ديو)

  EditProfileBloc({required this.apiService}) : super(EditProfileInitial()) {
    on<UpdateProfile>((event, emit) async {
      emit(EditProfileLoading());
      try {
        await apiService.updatePatient(
          patientId: event.patientId,
          data: {
            "first_name": event.name,
            "last_name": event.name.split(' ').last,
            "date_of_birth": event.birthDate,
            "user": {
              "email": event.email,
              "first_name": event.name.split(' ').first,
              "last_name": event.name.split(' ').last,
            }
          },
        );
        emit(EditProfileSuccess());
      } catch (e) {
        emit(EditProfileError('فشل تعديل البيانات'));
      }
    });
  }
}
