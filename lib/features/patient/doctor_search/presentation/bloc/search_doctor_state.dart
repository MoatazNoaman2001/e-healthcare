part of 'search_doctor_bloc.dart';

@immutable
class DoctorSearchState extends Equatable {
  final List<DoctorModel> doctors;
  final List<SpecialtyModel> specialties;
  final bool isLoading;
  final String? error;
  final String? query;
  final String? selectedSpecialty;

  const DoctorSearchState({
    this.doctors = const [],
    this.specialties = const [],
    this.isLoading = false,
    this.error,
    this.query,
    this.selectedSpecialty,
  });

  DoctorSearchState copyWith({
    List<DoctorModel>? doctors,
    List<SpecialtyModel>? specialties,
    bool? isLoading,
    String? error,
    String? query,
    String? selectedSpecialty,
  }) {
    return DoctorSearchState(
      doctors: doctors ?? this.doctors,
      specialties: specialties ?? this.specialties,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      query: query ?? this.query,
      selectedSpecialty: selectedSpecialty ?? this.selectedSpecialty,
    );
  }

  @override
  List<Object?> get props => [
    doctors,
    specialties,
    isLoading,
    error,
    query,
    selectedSpecialty,
  ];
}