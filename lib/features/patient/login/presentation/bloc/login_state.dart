part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String? token;
  final UserModel? user;
  final String? error;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.token,
    this.user,
    this.error,
  });

  bool get isValidEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool get isValidPassword => password.length >= 6;

  bool get canSubmit => isValidEmail && isValidPassword && !isLoading;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? token,
    UserModel? user,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      token: token ?? this.token,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}