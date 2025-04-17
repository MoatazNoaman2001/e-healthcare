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
  }) async {
    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phone,            // لازم تكون phone_number مش phone
      'password': password,
      'confirm_password': password,     // ضروري في الـ API
      'date_of_birth': dateOfBirth,
      'user_type': 'patient',           // Enum موجود في Swagger
      'agreed_to_terms': true,          // حقل مطلوب
    };

    print('🔵 Sending data: ${jsonEncode(data)}');

    final response = await http.post(
      Uri.parse('$baseUrl/users/'),     // ❗ المسار الصحيح من Swagger
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
