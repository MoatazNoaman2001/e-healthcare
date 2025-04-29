import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/appointment.dart';
import '../../repositories/doctor_repository.dart';

class GetPastAppointments {
  final DoctorRepository repository;

  GetPastAppointments(this.repository);

  Future<Either<Failure, List<Appointment>>> call({
    required String doctorId,
  }) async {
    return await repository.getPastAppointments(doctorId);
  }
}

