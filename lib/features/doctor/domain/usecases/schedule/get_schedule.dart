import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/schedule.dart';
import '../../repositories/doctor_repository.dart';

class GetSchedule {
  final DoctorRepository repository;

  GetSchedule(this.repository);

  Future<Either<Failure, Schedule>> call({
    required String doctorId,
    required String scheduleId
  }) async {
    return await repository.getSchedule(doctorId, scheduleId);
  }
}

