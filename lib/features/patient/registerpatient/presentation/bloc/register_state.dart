// part of 'register_bloc.dart';

// class RegisterState extends Equatable {
//   final String name;
//   final String email;
//   final String phone;
//   final String password;
//   final String confirmPassword;
//   final bool obscurePassword;
//   final bool obscureConfirmPassword;
//   final bool acceptTerms;
//   final bool isSubmitted;

//   const RegisterState({
//     this.name = '',
//     this.email = '',
//     this.phone = '',
//     this.password = '',
//     this.confirmPassword = '',
//     this.obscurePassword = true,
//     this.obscureConfirmPassword = true,
//     this.acceptTerms = false,
//     this.isSubmitted = false,
//   });

//   RegisterState copyWith({
//     String? name,
//     String? email,
//     String? phone,
//     String? password,
//     String? confirmPassword,
//     bool? obscurePassword,
//     bool? obscureConfirmPassword,
//     bool? acceptTerms,
//     bool? isSubmitted,
//   }) {
//     return RegisterState(
//       name: name ?? this.name,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       password: password ?? this.password,
//       confirmPassword: confirmPassword ?? this.confirmPassword,
//       obscurePassword: obscurePassword ?? this.obscurePassword,
//       obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
//       acceptTerms: acceptTerms ?? this.acceptTerms,
//       isSubmitted: isSubmitted ?? this.isSubmitted,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         name,
//         email,
//         phone,
//         password,
//         confirmPassword,
//         obscurePassword,
//         obscureConfirmPassword,
//         acceptTerms,
//         isSubmitted,
//       ];
// }

class RegisterState {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool acceptTerms;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  RegisterState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.acceptTerms = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? acceptTerms,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  bool get isValid =>
      name.isNotEmpty &&
      email.contains('@') &&
      phone.length >= 11 &&
      password.length >= 6 &&
      confirmPassword == password &&
      acceptTerms;
}
