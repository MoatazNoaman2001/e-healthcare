
import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/appointment.dart';
import '../../repositories/doctor_repository.dart';

class CreateAppointment {
  final DoctorRepository repository;

  CreateAppointment(this.repository);

  Future<Either<Failure, Appointment>> call({
    required String doctorId,
    required Appointment appointment,
  }) async {
    return await repository.createAppointment(doctorId, appointment);
  }
}