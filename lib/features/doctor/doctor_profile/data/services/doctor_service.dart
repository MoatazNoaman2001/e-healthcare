import 'package:doctorapp/features/doctor/doctor_profile/domain/models/doctor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DoctorService {
  final String baseUrl = 'http://128.140.39.237/api/v1'; // ده الباك الخاص بيكم

  Future<Doctor> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/doctors/me/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Doctor.fromJson(jsonData);
    } else {
      throw Exception('فشل تحميل بيانات البروفايل');
    }
  }
}
