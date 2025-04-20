import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    // التحقق من صحة البيانات المدخلة
    if (!state.canSubmit) {
      emit(state.copyWith(
        error: 'يرجى التحقق من البريد الإلكتروني وكلمة المرور',
      ));
      return;
    }

    // بدء عملية تسجيل الدخول
    emit(state.copyWith(
      isLoading: true,
      error: null,
      isSuccess: false,
    ));

    final result = await authRepository.login(
      email: state.email,
      password: state.password,
    );

    result.fold((error) => emit(state.copyWith(
        isLoading: false,
        error: error,
        isSuccess: false,
      )), (authResponse) async {
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
    // هنا يمكن إضافة منطق تسجيل الدخول بواسطة Google
    // لم نقم بتنفيذه حالياً لأنه خارج نطاق المتطلبات الحالية
    emit(state.copyWith(
      error: 'تسجيل الدخول بواسطة Google غير متاح حالياً',
    ));
  }
}