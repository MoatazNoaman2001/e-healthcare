class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String? token;

  bool get isValid => email.contains('@') && password.length >= 6;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.token,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? token,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      token: token ?? this.token,
    );
  }
}
