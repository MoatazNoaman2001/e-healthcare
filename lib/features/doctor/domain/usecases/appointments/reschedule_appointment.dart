import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/appointment.dart';
import '../../repositories/doctor_repository.dart';

class RescheduleAppointment {
  final DoctorRepository repository;

  RescheduleAppointment(this.repository);

  Future<Either<Failure, Appointment>> call({
    required String doctorId,
    required String appointmentId,
    required DateTime newStartTime,
    required DateTime newEndTime,
  }) async {
    return await repository.rescheduleAppointment(
      doctorId,
      appointmentId,
      newStartTime,
      newEndTime,
    );
  }
}
