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
      if (!state.isValid) {
        emit(state.copyWith(error: 'الرجاء إدخال بيانات صحيحة'));
        return;
      }

      emit(state.copyWith(isLoading: true, error: null));
      await Future.delayed(const Duration(seconds: 2)); // simulate login

      if (state.email == "test@example.com" && state.password == "123456") {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, error: 'بيانات غير صحيحة'));
      }
    });
  }
}
