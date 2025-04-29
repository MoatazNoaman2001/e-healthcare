import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/schedule.dart';
import '../../repositories/doctor_repository.dart';

class GetSchedules {
  final DoctorRepository repository;

  GetSchedules(this.repository);

  Future<Either<Failure, List<Schedule>>> call({
    required String doctorId,
  }) async {
    return await repository.getSchedules(doctorId);
  }
}

