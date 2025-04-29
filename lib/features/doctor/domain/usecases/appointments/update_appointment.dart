import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/appointment.dart';
import '../../repositories/doctor_repository.dart';

class UpdateAppointment {
  final DoctorRepository repository;

  UpdateAppointment(this.repository);

  Future<Either<Failure, Appointment>> call({
    required String doctorId,
    required Appointment appointment,
  }) async {
    return await repository.updateAppointment(doctorId, appointment);
  }
}
