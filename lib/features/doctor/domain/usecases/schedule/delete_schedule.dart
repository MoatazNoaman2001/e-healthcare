import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/doctor_repository.dart';

class DeleteSchedule {
  final DoctorRepository repository;

  DeleteSchedule(this.repository);

  Future<Either<Failure, void>> call({
    required String doctorId,
    required String scheduleId,
  }) async {
    return await repository.deleteSchedule(doctorId, scheduleId);
  }
}

