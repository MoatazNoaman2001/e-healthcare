import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<void> updatePatient({
    required int patientId,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.put(
      '/patients/$patientId/',
      data: data,
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('فشل تعديل الملف الشخصي');
    }
  }
}
