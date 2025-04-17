import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://128.140.39.237/api/v1';

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String userType, // 'doctor' or 'patient'
  }) async {
    final body = {
      "email": email,
      "password": password,
      "confirm_password": password,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phone,
      "user_type": userType,
      "agreed_to_terms": true,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('فشل التسجيل: ${response.body}');
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('فشل تسجيل الدخول: ${response.body}');
    }
  }
}
