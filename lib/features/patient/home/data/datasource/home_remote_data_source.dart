import 'package:dio/dio.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart' as di;
import '../../../../../core/auth/auth_service.dart';
import '../../domain/models/doctor.dart';
import '../../domain/models/specialization.dart';
import '../../domain/models/appointment.dart';
import '../../domain/models/clinic.dart';

abstract class HomeRemoteDataSource {
  Future<List<Doctor>> getDoctors({String? search});
  Future<List<Specialization>> getSpecializations({String? search});
  Future<List<Appointment>> getUpcomingAppointments(int patientId);
  Future<List<Appointment>> getPastAppointments(int patientId);
  Future<List<Clinic>> getClinics();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Doctor>> getDoctors({String? search}) async {
    try {
      final response = await dio.get(
        '/doctors/',
        queryParameters: search != null ? {'search': search} : null,
        options: Options(
          headers: {
            'X-CSRFTOKEN': 'zbKQsbqX8PCzAuWkbYegM0iOiRRvBjD7Mkz9VOqLMBCSmdiX3cQKzyDuhT6uwpNs',
          }
        )
      );
      final List<dynamic> doctorsJson = response.data['results'];
      return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load doctors: ${e.message}');
    }
  }

  @override
  Future<List<Specialization>> getSpecializations({String? search}) async {
    try {
      final response = await dio.get(
        '/specializations/',
        queryParameters: search != null ? {'search': search} : null,
      );

      final List<dynamic> specializationsJson = response.data['results'];
      return specializationsJson.map((json) => Specialization.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load specializations: ${e.message}');
    }
  }

  @override
  Future<List<Appointment>> getUpcomingAppointments(int patientId) async {
    try {
      final response = await dio.get('/patients/$patientId/appointments/upcoming/');

      final List<dynamic> appointmentsJson = response.data['results'];
      return appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load upcoming appointments: ${e.message}');
    }
  }

  @override
  Future<List<Appointment>> getPastAppointments(int patientId) async {
    try {
      final response = await dio.get('/patients/$patientId/appointments/past/');

      final List<dynamic> appointmentsJson = response.data['results'];
      return appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load past appointments: ${e.message}');
    }
  }

  @override
  Future<List<Clinic>> getClinics() async {
    try {
      final response = await dio.get('/clinics/');

      final List<dynamic> clinicsJson = response.data['results'];
      return clinicsJson.map((json) => Clinic.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load clinics: ${e.message}');
    }
  }
}