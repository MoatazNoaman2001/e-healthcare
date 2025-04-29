import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/schedule.dart';
import '../../repositories/doctor_repository.dart';

class GetSchedulesByDoctor {
  final DoctorRepository repository;

  GetSchedulesByDoctor(this.repository);

  Future<Either<Failure, List<Schedule>>> call({
    required String doctorId,
  }) async {
    return await repository.getSchedulesByDoctor(doctorId);
  }
}