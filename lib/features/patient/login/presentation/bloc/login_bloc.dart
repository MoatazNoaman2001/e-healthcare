import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, error: null));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, error: null));
    });
on<LoginSubmitted>((event, emit) async {
  emit(state.copyWith(isLoading: true, error: null));

  await Future.delayed(const Duration(seconds: 1)); // محاكاة انتظار

  // تسجيل الدخول مباشرة دون تحقق
  emit(state.copyWith(isLoading: false, isSuccess: true));
});
  }
}
