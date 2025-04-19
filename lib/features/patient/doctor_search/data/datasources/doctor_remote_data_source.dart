import 'package:dio/dio.dart';
import '../../domain/models/doctor_model.dart';
import '../../domain/models/specialty_model.dart';

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> searchDoctors({
    String? query,
    String? specialty,
  });

  Future<List<SpecialtyModel>> getSpecialties();
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final Dio dio;

  DoctorRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<DoctorModel>> searchDoctors({
    String? query,
    String? specialty,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (query != null && query.isNotEmpty) {
        queryParams['search'] = query;
      }

      if (specialty != null && specialty.isNotEmpty) {
        queryParams['specialization'] = specialty;
      }

      final response = await dio.get(
        '/doctors/',
        queryParameters: queryParams,
      );

      final List<dynamic> doctorsJson = response.data['results'];
      return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('No Internet Connection');
      }
      throw Exception('Failed to search doctors: ${e.message}');
    }
  }

  @override
  Future<List<SpecialtyModel>> getSpecialties() async {
    try {
      final response = await dio.get('/specializations/');

      final List<dynamic> specialtiesJson = response.data['results'];
      return specialtiesJson.map((json) => SpecialtyModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('No Internet Connection');
      }
      throw Exception('Failed to load specialties: ${e.message}');
    }
  }
}