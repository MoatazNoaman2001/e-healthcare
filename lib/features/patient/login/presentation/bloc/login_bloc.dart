import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/auth/auth_service.dart';
import '../../../../../core/di/dependancy_injection.dart' as di;
import '../../data/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  late final AuthService _authService;

  LoginBloc({required this.authRepository}) : super(LoginState()) {
    _authService = di.sl<AuthService>();

    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      error: null,
      isSuccess: false,
    ));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      error: null,
      isSuccess: false,
    ));
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
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

    final result = await authRepository.login(
      email: state.email,
      password: state.password,
    );

    await result.fold(
      (error) async {
        emit(state.copyWith(
          isLoading: false,
          error: error,
          isSuccess: false,
        ));
      },
      (authResponse) async {
        final prefs = di.sl<SharedPreferences>();
        await prefs.setString('auth_token', authResponse.token);

        if (authResponse.user != null) {
          await prefs.setInt('user_id', authResponse.user!.id);
          await prefs.setString('user_email', authResponse.user!.email);
          await prefs.setString('user_type', authResponse.user!.userType);
        }

        // ✅ هنا نطلب /patients/me/ ونخزن الـ patientId
        try {
          final dio = di.sl<Dio>();
          final response = await dio.get('/patients/me/');
          final patientId = response.data['id'];

          await prefs.setInt('patient_id', patientId);
        } catch (e) {
          print('❌ Error fetching patient ID: $e');
        }

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          token: authResponse.token,
          user: authResponse.user,
          error: null,
        ));
      },
    );
  }

  Future<void> _onLoginWithGoogle(LoginWithGoogle event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      error: 'تسجيل الدخول بواسطة Google غير متاح حالياً',
    ));
  }
}
