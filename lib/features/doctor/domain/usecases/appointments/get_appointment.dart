import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/appointment.dart';
import '../../repositories/doctor_repository.dart';

class GetAppointment {
  final DoctorRepository repository;

  GetAppointment(this.repository);

  Future<Either<Failure, Appointment>> call({
    required String doctorId,
    required String appointmentId,
  }) async {
    return await repository.getAppointment(doctorId, appointmentId);
  }
}
