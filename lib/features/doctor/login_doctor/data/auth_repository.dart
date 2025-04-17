import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final String baseUrl = 'http://128.140.39.237/api/v1';
  final _secureStorage = const FlutterSecureStorage(); 

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('📥 Status Code: ${response.statusCode}');
    print('📥 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      await _secureStorage.write(key: 'auth_token', value: token);

      return token;
    } else {
      throw Exception('فشل تسجيل الدخول: ${response.body}');
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }
}
