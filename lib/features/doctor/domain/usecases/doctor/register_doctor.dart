import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/doctor.dart';
import '../../repositories/doctor_repository.dart';

class RegisterDoctor {
  final DoctorRepository repository;

  RegisterDoctor(this.repository);

  Future<Either<Failure, Doctor>> call({
    required Doctor doctor,
    required String password,
  }) async {
    return await repository.registerDoctor(doctor, password);
  }
}

