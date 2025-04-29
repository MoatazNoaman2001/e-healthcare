import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/schedule.dart';
import '../../repositories/doctor_repository.dart';

class UpdateSchedule {
  final DoctorRepository repository;

  UpdateSchedule(this.repository);

  Future<Either<Failure, Schedule>> call({
    required String doctorId,
    required Schedule schedule,
  }) async {
    return await repository.updateSchedule(doctorId, schedule);
  }
}
