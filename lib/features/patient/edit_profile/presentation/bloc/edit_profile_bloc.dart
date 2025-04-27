import 'package:doctorapp/features/patient/edit_profile/data/services/edit_profile_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../core/di/dependancy_injection.dart'; // مهم لو بتستخدمي GetIt
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      final editProfileService = EditProfileService(sl<Dio>()); // ✅ استخدمنا Dio من GetIt

      await editProfileService.updatePatientProfile(
        patientId: event.patientId,
        token: event.token,
        updatedData: {
          "user": {
            "email": event.email,
            "first_name": event.firstName,
            "last_name": event.lastName,
            "phone_number": event.phone,
            "user_type": "patient",
            "profile_status": "approved",
          },
          "first_name": event.firstName,
          "last_name": event.lastName,
          "date_of_birth": event.birthDate,
          "gender": event.gender,  // ✅ هنا بقى ديناميك
          "blood_type": event.bloodType,
          "height": event.height,
          "weight": event.weight,
          "allergies": "None",
          "emergency_contact_name": "N/A",
          "emergency_contact_phone": "N/A",
          "emergency_contact_relationship": "N/A",
          "is_insured": true,
          "insurance_provider": "N/A",
          "insurance_policy_number": "N/A",
          "insurance_expiry_date": "2025-12-31",
          "notes": ""
        },
      );

      emit(EditProfileSuccess());
    } catch (e) {
      print('Error while updating profile: $e');
      emit(EditProfileFailure('error_updating_profile'.tr()));
    }
  }
}
