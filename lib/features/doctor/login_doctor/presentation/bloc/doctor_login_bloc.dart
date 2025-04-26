import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/auth/auth_service.dart';
import '../../../../../core/di/dependancy_injection.dart' as di;
import '../../data/auth_repository.dart';

part 'doctor_login_event.dart';
part 'doctor_login_state.dart';

class DoctorLoginBloc extends Bloc<DoctorLoginEvent, DoctorLoginState> {
  final AuthRepository authRepository;
  late final AuthService _authService;

  DoctorLoginBloc({required this.authRepository}) : super(DoctorLoginState()) {
    _authService = di.sl<AuthService>();

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
      final result = await authRepository.login(
        email: state.email,
        password: state.password,
      );

      if (result.isLeft()) {
        final error = result.fold((l) => l, (r) => null);
        if (!emit.isDone) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: error,
          ));
        }
      } else {
        final authResponse = result.fold((l) => null, (r) => r);

        await _authService.login(
          token: authResponse!.token,
          user: authResponse.user,
          doctorId: authResponse.user.userType == 'doctor' ? authResponse.user.id : null,
        );

        if (!emit.isDone) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            token: authResponse.token,
            error: null,
          ));
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: e.toString(),
        ));
      }
    }
  }
}
