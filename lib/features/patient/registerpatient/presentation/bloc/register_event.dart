abstract class RegisterEvent {}
class FirstNameChanged extends RegisterEvent {
  final String firstName;
  FirstNameChanged(this.firstName);
}

class LastNameChanged extends RegisterEvent {
  final String lastName;
  LastNameChanged(this.lastName);
}

class NameChanged extends RegisterEvent {
  final String name;
  NameChanged(this.name);
}

class EmailChanged extends RegisterEvent {
  final String email;
  EmailChanged(this.email);
}

class PhoneChanged extends RegisterEvent {
  final String phone;
  PhoneChanged(this.phone);
}

class PasswordChanged extends RegisterEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class DateOfBirthChanged extends RegisterEvent {
  final String dateOfBirth;
  DateOfBirthChanged(this.dateOfBirth);
}

class GenderChanged extends RegisterEvent {
  final String gender;
  GenderChanged(this.gender);
}

class BloodTypeChanged extends RegisterEvent {
  final String bloodType;
  BloodTypeChanged(this.bloodType);
}

class AcceptTermsChanged extends RegisterEvent {
  final bool accept;
  AcceptTermsChanged(this.accept);
}

class RegisterSubmitted extends RegisterEvent {}
