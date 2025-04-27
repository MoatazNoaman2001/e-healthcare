import 'package:dio/dio.dart';

class EditProfileService {
  final Dio _dio;

  EditProfileService(this._dio);

  Future<void> updatePatientProfile({
    required int patientId,
    required String token,
    required Map<String, dynamic> updatedData,
  }) async {
    final url = '/patients/$patientId/';

    final response = await _dio.patch(
      url,
      data: updatedData,
      options: Options(
        headers: {
          'Authorization': 'Token $token', // لو السيرفر بيستخدم Token مش Bearer
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update profile');
    }
  }
}
