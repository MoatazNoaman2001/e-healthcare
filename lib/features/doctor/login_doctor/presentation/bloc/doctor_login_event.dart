part of 'doctor_login_bloc.dart';

@immutable
sealed class DoctorLoginEvent {}


class DoctorLoginEmailChanged extends DoctorLoginEvent {
  final String email;

  DoctorLoginEmailChanged(this.email);
}

class DoctorLoginPasswordChanged extends DoctorLoginEvent {
  final String password;

  DoctorLoginPasswordChanged(this.password);
}

class DoctorLoginRememberMeChanged extends DoctorLoginEvent {
  final bool rememberMe;

  DoctorLoginRememberMeChanged(this.rememberMe);
}

class DoctorLoginSubmitted extends DoctorLoginEvent {}