import 'package:dio/dio.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart'; // ضروري عشان sl

class EditProfileService {
  final Dio _dio = sl<Dio>();

  Future<void> updatePatientProfile({
    required int patientId,
    required Map<String, dynamic> updatedData,
  }) async {
    final url = '/patients/$patientId/'; // Endpoint الصح

    final response = await _dio.put(
      url,
      data: updatedData,
    );

    if (response.statusCode != 200) {
      throw Exception('فشل في تحديث الملف الشخصي');
    }
  }
}
