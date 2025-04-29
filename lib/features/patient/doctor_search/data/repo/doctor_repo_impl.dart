import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/models/doctor_model.dart';
import '../../domain/models/specialty_model.dart';
import '../../domain/repo/doctor_repo.dart';
import '../datasources/doctor_remote_data_source.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctors({
    String? query,
    String? specialty,
  }) async {
    try {
      final doctors = await remoteDataSource.searchDoctors(
        query: query,
        specialty: specialty,
      );
      return right(doctors);
    } on Exception catch (e) {
      if (e.toString().contains('No Internet')) {
        return left(const NetworkFailure(message: 'تأكد من اتصالك بالإنترنت'));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SpecialtyModel>>> getSpecialties() async {
    try {
      final specialties = await remoteDataSource.getSpecialties();
      return right(specialties);
    } on Exception catch (e) {
      if (e.toString().contains('No Internet')) {
        return left(const NetworkFailure(message: 'تأكد من اتصالك بالإنترنت'));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}