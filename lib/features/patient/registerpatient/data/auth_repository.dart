import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://128.140.39.237/api/v1';

  Future<void> registerPatient({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
    String gender = 'male', // Default value, should be configurable
    String bloodType = 'A+', // Default value, should be configurable
  }) async {
    final data = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'blood_type': bloodType,
    };

    print('🔵 Sending data: ${jsonEncode(data)}');

    final response = await http.post(
      Uri.parse('$baseUrl/patients/register/'), // New API endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('🟡 Status: ${response.statusCode}');
    print('🟡 Response Body: ${response.body}');

    if (response.statusCode != 201) {
      final message = response.statusCode == 500
          ? 'حدث خطأ داخلي في السيرفر. الرجاء المحاولة لاحقًا.'
          : 'فشل التسجيل (${response.statusCode})';

      throw Exception(message);
    }

    print('✅ تم التسجيل بنجاح');
  }
}