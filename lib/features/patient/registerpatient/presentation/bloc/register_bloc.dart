import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterState()) {
    on<FirstNameChanged>((event, emit) => emit(state.copyWith(firstName: event.firstName)));
    on<LastNameChanged>((event, emit) => emit(state.copyWith(lastName: event.lastName)));
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PhoneChanged>((event, emit) => emit(state.copyWith(phone: event.phone)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<DateOfBirthChanged>((event, emit) => emit(state.copyWith(dateOfBirth: event.dateOfBirth)));
    on<AcceptTermsChanged>((event, emit) => emit(state.copyWith(acceptTerms: event.accept)));

    on<RegisterSubmitted>((event, emit) async {
      if (!state.isValid) {
        emit(state.copyWith(error: 'يرجى ملء جميع الحقول بشكل صحيح'));
        return;
      }

      emit(state.copyWith(isLoading: true, error: null));

      try {
        await authRepository.registerPatient(
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.email,
          phone: state.phone,
          password: state.password,
          dateOfBirth: state.dateOfBirth,
        );

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });
  }
}
