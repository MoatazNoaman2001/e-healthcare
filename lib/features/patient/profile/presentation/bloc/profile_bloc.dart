import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../domain/entities/user_entity.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
  }

  void _onLoadUserProfile(LoadUserProfile event, Emitter<ProfileState> emit) {
    emit(ProfileLoading());

    // بيانات وهمية كمثال
    final user = UserEntity(
      name: 'محمد أحمد',
      email: 'mohammed@example.com',
      phone: '01012345678',
      birthDate: '١٥ يناير ١٩٩٠',
      bloodType: 'O+',
      height: '175 سم',
      weight: '75 كجم',
      insuranceCompany: 'شركة التأمين العربية',
      insuranceNumber: '123456789',
      insuranceExpiry: '٣٠ ديسمبر ٢٠٢٣',
    );

    emit(ProfileLoaded(user));
  }
}
