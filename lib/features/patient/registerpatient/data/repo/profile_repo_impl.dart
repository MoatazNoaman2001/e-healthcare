import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/models/patient_profile.dart';
import '../../domain/repo/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;

  ProfileRepositoryImpl(this._dio);

  @override
  Future<Either<String, PatientProfile>> getUserProfile() async {
    try {
      final response = await _dio.get('/patients/me/');

      if (response.statusCode == 200) {
        return right(PatientProfile.fromJson(response.data));
      } else {
        return left('Failed to load profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred: $e');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return 'Server error ($statusCode): ${error.response}';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Network error: ${error.message}';
    }
  }
}