class RegisterState {
  final String firstName;
  final String lastName;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String dateOfBirth;
  final String gender;
  final String bloodType;
  final bool acceptTerms;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.dateOfBirth = '',
    this.gender = 'male',
    this.bloodType = 'A+',
    this.acceptTerms = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    String? dateOfBirth,
    String? gender,
    String? bloodType,
    bool? acceptTerms,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  bool get isValid =>
      firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.contains('@') &&
          phone.length >= 11 &&
          password.length >= 6 &&
          confirmPassword == password &&
          dateOfBirth.isNotEmpty &&
          gender.isNotEmpty &&
          bloodType.isNotEmpty &&
          acceptTerms;
}
