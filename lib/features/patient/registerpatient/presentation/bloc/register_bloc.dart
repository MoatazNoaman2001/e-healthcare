// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'register_event.dart';
// part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   RegisterBloc() : super(const RegisterState()) {
//     on<NameChanged>((event, emit) {
//       emit(state.copyWith(name: event.name));
//     });

//     on<EmailChanged>((event, emit) {
//       emit(state.copyWith(email: event.email));
//     });

//     on<PhoneChanged>((event, emit) {
//       emit(state.copyWith(phone: event.phone));
//     });

//     on<PasswordChanged>((event, emit) {
//       emit(state.copyWith(password: event.password));
//     });

//     on<ConfirmPasswordChanged>((event, emit) {
//       emit(state.copyWith(confirmPassword: event.confirmPassword));
//     });

//     on<ToggleAcceptTerms>((event, emit) {
//       emit(state.copyWith(acceptTerms: !state.acceptTerms));
//     });

//     on<TogglePasswordVisibility>((event, emit) {
//       emit(state.copyWith(obscurePassword: !state.obscurePassword));
//     });

//     on<ToggleConfirmPasswordVisibility>((event, emit) {
//       emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
//     });

//     on<SubmitForm>((event, emit) {
//       emit(state.copyWith(isSubmitted: true));
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PhoneChanged>((event, emit) => emit(state.copyWith(phone: event.phone)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<AcceptTermsChanged>((event, emit) => emit(state.copyWith(acceptTerms: event.accept)));
    on<RegisterSubmitted>((event, emit) async {
      if (!state.isValid) {
        emit(state.copyWith(error: 'يرجى إدخال جميع البيانات بشكل صحيح'));
        return;
      }
      emit(state.copyWith(isLoading: true, error: null));
      await Future.delayed(const Duration(seconds: 2)); // محاكاة التسجيل
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
