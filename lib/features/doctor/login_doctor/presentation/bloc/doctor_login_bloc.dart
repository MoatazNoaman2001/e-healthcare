import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_repository.dart';

part 'doctor_login_event.dart';
part 'doctor_login_state.dart';


class DoctorLoginBloc extends Bloc<DoctorLoginEvent, DoctorLoginState> {
  final AuthRepository authRepository;

  DoctorLoginBloc({required this.authRepository}) : super(DoctorLoginState()) {
    on<DoctorLoginEmailChanged>(_onEmailChanged);
    on<DoctorLoginPasswordChanged>(_onPasswordChanged);
    on<DoctorLoginRememberMeChanged>(_onRememberMeChanged);
    on<DoctorLoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(DoctorLoginEmailChanged event, Emitter<DoctorLoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      error: null,
      isSuccess: false,
    ));
  }

  void _onPasswordChanged(DoctorLoginPasswordChanged event, Emitter<DoctorLoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      error: null,
      isSuccess: false,
    ));
  }

  void _onRememberMeChanged(DoctorLoginRememberMeChanged event, Emitter<DoctorLoginState> emit) {
    emit(state.copyWith(
      rememberMe: event.rememberMe,
    ));
  }

  Future<void> _onSubmitted(DoctorLoginSubmitted event, Emitter<DoctorLoginState> emit) async {
    // التحقق من صحة البيانات المدخلة
    if (!state.canSubmit) {
      emit(state.copyWith(
        error: 'يرجى التحقق من البريد الإلكتروني وكلمة المرور',
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      error: null,
      isSuccess: false,
    ));

    try {
      final token = await authRepository.login(
        email: state.email,
        password: state.password,
      );

      token.fold((l) => emit(DoctorLoginState(error: l)), (authModel) async{
        if (state.rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('doctor_auth_token', authModel.token);
        }

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          token: authModel.token,
          error: null,
        ));

      },);
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      ));
    }
  }
}