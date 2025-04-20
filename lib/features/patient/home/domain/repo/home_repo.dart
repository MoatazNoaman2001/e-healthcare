import 'package:fpdart/fpdart.dart';
import '../models/clinic.dart';
import '../models/doctor.dart';
import '../models/specialization.dart';
import '../models/appointment.dart';

abstract class HomeRepository {
  Future<Either<Exception, List<Doctor>>> getDoctors({String? search});
  Future<Either<Exception, List<Specialization>>> getSpecializations({String? search});
  Future<Either<Exception, List<Appointment>>> getUpcomingAppointments(int patientId);
  Future<Either<Exception, List<Appointment>>> getPastAppointments(int patientId);
  Future<Either<Exception, List<Clinic>>> getClinics();
}