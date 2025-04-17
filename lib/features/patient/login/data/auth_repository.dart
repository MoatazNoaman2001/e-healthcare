import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://128.140.39.237/api/v1';

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
    return data['token'] ?? 'no_token_found'; // حسب شكل الاستجابة
  } else {
    try {
      final error = jsonDecode(response.body);
      if (error is Map && error.containsKey('detail')) {
        throw Exception('فشل تسجيل الدخول: ${error['detail']}');
      } else {
        throw Exception('فشل تسجيل الدخول: ${response.body}');
      }
    } catch (e) {
      throw Exception('فشل تسجيل الدخول: ${response.body}');
    }
  }
}
}