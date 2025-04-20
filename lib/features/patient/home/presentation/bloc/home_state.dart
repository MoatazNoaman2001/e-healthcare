part of 'home_bloc.dart';

@immutable

class HomeState extends Equatable {
  final List<Doctor> doctors;
  final List<Specialization> specializations;
  final List<Appointment> upcomingAppointments;
  final List<Appointment> pastAppointments;
  final List<Clinic> clinics;
  final bool isDoctorsLoading;
  final bool isSpecializationsLoading;
  final bool isUpcomingAppointmentsLoading;
  final bool isPastAppointmentsLoading;
  final bool isClinicsLoading;
  final String? doctorsError;
  final String? specializationsError;
  final String? upcomingAppointmentsError;
  final String? pastAppointmentsError;
  final String? clinicsError;

  const HomeState({
    this.doctors = const [],
    this.specializations = const [],
    this.upcomingAppointments = const [],
    this.pastAppointments = const [],
    this.clinics = const [],
    this.isDoctorsLoading = false,
    this.isSpecializationsLoading = false,
    this.isUpcomingAppointmentsLoading = false,
    this.isPastAppointmentsLoading = false,
    this.isClinicsLoading = false,
    this.doctorsError,
    this.specializationsError,
    this.upcomingAppointmentsError,
    this.pastAppointmentsError,
    this.clinicsError,
  });

  HomeState copyWith({
    List<Doctor>? doctors,
    List<Specialization>? specializations,
    List<Appointment>? upcomingAppointments,
    List<Appointment>? pastAppointments,
    List<Clinic>? clinics,
    bool? isDoctorsLoading,
    bool? isSpecializationsLoading,
    bool? isUpcomingAppointmentsLoading,
    bool? isPastAppointmentsLoading,
    bool? isClinicsLoading,
    String? doctorsError,
    String? specializationsError,
    String? upcomingAppointmentsError,
    String? pastAppointmentsError,
    String? clinicsError,
  }) {
    return HomeState(
      doctors: doctors ?? this.doctors,
      specializations: specializations ?? this.specializations,
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
      pastAppointments: pastAppointments ?? this.pastAppointments,
      clinics: clinics ?? this.clinics,
      isDoctorsLoading: isDoctorsLoading ?? this.isDoctorsLoading,
      isSpecializationsLoading: isSpecializationsLoading ?? this.isSpecializationsLoading,
      isUpcomingAppointmentsLoading: isUpcomingAppointmentsLoading ?? this.isUpcomingAppointmentsLoading,
      isPastAppointmentsLoading: isPastAppointmentsLoading ?? this.isPastAppointmentsLoading,
      isClinicsLoading: isClinicsLoading ?? this.isClinicsLoading,
      doctorsError: doctorsError,
      specializationsError: specializationsError,
      upcomingAppointmentsError: upcomingAppointmentsError,
      pastAppointmentsError: pastAppointmentsError,
      clinicsError: clinicsError,
    );
  }

  @override
  List<Object?> get props => [
    doctors,
    specializations,
    upcomingAppointments,
    pastAppointments,
    clinics,
    isDoctorsLoading,
    isSpecializationsLoading,
    isUpcomingAppointmentsLoading,
    isPastAppointmentsLoading,
    isClinicsLoading,
    doctorsError,
    specializationsError,
    upcomingAppointmentsError,
    pastAppointmentsError,
    clinicsError,
  ];
}
