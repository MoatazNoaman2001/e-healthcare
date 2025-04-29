import 'package:bloc/bloc.dart';
import 'package:doctorapp/features/patient/edit_profile/data/services/edit_profile_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileService _editProfileService = EditProfileService();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      await _editProfileService.updatePatientProfile(
        patientId: event.patientId,
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
          "gender": event.gender,
          "blood_type": event.bloodType,
          "height": event.height,
          "weight": event.weight,
          "allergies": event.allergies ?? "None",
          "emergency_contact_name": event.emergencyContactName ?? "N/A",
          "emergency_contact_phone": event.emergencyContactPhone ?? "N/A",
          "emergency_contact_relationship": event.emergencyContactRelationship ?? "N/A",
          "is_insured": event.isInsured,
          "insurance_provider": event.insuranceProvider ?? "N/A",
          "insurance_policy_number": event.insurancePolicyNumber ?? "N/A",
          "insurance_expiry_date": event.insuranceExpiryDate ?? "2025-12-31",
          "notes": event.notes ?? "",
        },
      );

      emit(EditProfileSuccess());
    } catch (e) {
      print('❌ Error while updating profile: $e');
      emit(EditProfileFailure('error_updating_profile'.tr()));
    }
  }
}
