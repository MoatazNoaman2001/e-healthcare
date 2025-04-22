import 'package:fpdart/fpdart.dart';
import '../models/patient_profile.dart';

abstract class ProfileRepository {
  Future<Either<String, PatientProfile>> getUserProfile();
}