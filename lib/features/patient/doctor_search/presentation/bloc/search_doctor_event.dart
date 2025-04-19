part of 'search_doctor_bloc.dart';

@immutable

abstract class DoctorSearchEvent extends Equatable {
  const DoctorSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchDoctorsEvent extends DoctorSearchEvent {
  final String? query;
  final String? specialty;

  const SearchDoctorsEvent({
    this.query,
    this.specialty,
  });

  @override
  List<Object?> get props => [query, specialty];
}

class LoadSpecialtiesEvent extends DoctorSearchEvent {
  const LoadSpecialtiesEvent();
}
