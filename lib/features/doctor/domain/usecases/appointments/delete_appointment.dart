import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/doctor_repository.dart';

class DeleteAppointment {
  final DoctorRepository repository;

  DeleteAppointment(this.repository);

  Future<Either<Failure, void>> call({
    required String doctorId,
    required String appointmentId,
  }) async {
    return await repository.deleteAppointment(doctorId, appointmentId);
  }
}

