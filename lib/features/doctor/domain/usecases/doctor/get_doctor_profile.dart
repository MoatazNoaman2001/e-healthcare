import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/typedefs.dart';
import '../../entities/doctor.dart';
import '../../repositories/doctor_repository.dart';

class GetDoctorProfile {
  final DoctorRepository repository;

  GetDoctorProfile(this.repository);

  Future<Either<Failure, Doctor>> call({required String doctorId}) async {
    return await repository.getDoctorProfile(doctorId);
  }
}
