import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../models/doctor_model.dart';
import '../models/specialty_model.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorModel>>> searchDoctors({
    String? query,
    String? specialty,
  });

  Future<Either<Failure, List<SpecialtyModel>>> getSpecialties();
}