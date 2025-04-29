
import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/doctor.dart';
import '../../repositories/doctor_repository.dart';

class UpdateDoctorProfile {
  final DoctorRepository repository;

  UpdateDoctorProfile(this.repository);

  Future<Either<Failure, Doctor>> call({required Doctor doctor}) async {
    return await repository.updateDoctorProfile(doctor);
  }
}