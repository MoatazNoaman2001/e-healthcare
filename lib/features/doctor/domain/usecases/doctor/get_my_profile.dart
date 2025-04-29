import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/doctor.dart';
import '../../repositories/doctor_repository.dart';

class GetMyProfile {
  final DoctorRepository repository;

  GetMyProfile(this.repository);

  Future<Either<Failure, Doctor>> call() async {
    return await repository.getMyProfile();
  }
}

