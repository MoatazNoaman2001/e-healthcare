part of 'doctor_login_bloc.dart';

@immutable
class DoctorLoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isLoading;
  final bool isSuccess;
  final String? token;
  final String? error;

  DoctorLoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.token,
    this.error,
  });

  bool get isValidEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool get isValidPassword => password.length >= 6;

  bool get canSubmit => isValidEmail && isValidPassword && !isLoading;

  DoctorLoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isLoading,
    bool? isSuccess,
    String? token,
    String? error,
  }) {
    return DoctorLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }
}
