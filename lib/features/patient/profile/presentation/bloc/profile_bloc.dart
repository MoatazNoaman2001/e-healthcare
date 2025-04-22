import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../registerpatient/domain/models/patient_profile.dart';
import '../../../registerpatient/domain/repo/profile_repo.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../domain/entities/user_entity.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    final profileResult = await profileRepository.getUserProfile();

    profileResult.fold(
          (error) => emit(ProfileError(error)),
          (profile) {
        final userProfile = UserProfile.fromPatientProfile(profile);
        emit(ProfileLoaded(userProfile));
      },
    );
  }

  void _onLogoutUser(LogoutUser event, Emitter<ProfileState> emit) {
    // Here you could implement logout logic if needed
    // For example, clearing tokens from secure storage
    emit(ProfileInitial());
  }
}
