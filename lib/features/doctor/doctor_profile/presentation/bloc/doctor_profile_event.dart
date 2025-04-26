import 'package:equatable/equatable.dart';

abstract class DoctorProfileEvent extends Equatable {
  const DoctorProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadDoctorProfile extends DoctorProfileEvent {
  final String token;

  const LoadDoctorProfile(this.token);

  @override
  List<Object?> get props => [token];
}
