import 'package:fpdart/fpdart.dart';
import '../../domain/models/clinic.dart';
import '../../domain/models/doctor.dart';
import '../../domain/models/specialization.dart';
import '../../domain/models/appointment.dart';
import '../../domain/repo/home_repo.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, List<Doctor>>> getDoctors({String? search}) async {
    try {
      final doctors = await remoteDataSource.getDoctors(search: search);
      return right(doctors);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Specialization>>> getSpecializations({String? search}) async {
    try {
      final specializations = await remoteDataSource.getSpecializations(search: search);
      return right(specializations);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Appointment>>> getUpcomingAppointments(int patientId) async {
    try {
      final appointments = await remoteDataSource.getUpcomingAppointments(patientId);
      return right(appointments);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Appointment>>> getPastAppointments(int patientId) async {
    try {
      final appointments = await remoteDataSource.getPastAppointments(patientId);
      return right(appointments);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<Clinic>>> getClinics() async {
    try {
      final clinics = await remoteDataSource.getClinics();
      return right(clinics);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
