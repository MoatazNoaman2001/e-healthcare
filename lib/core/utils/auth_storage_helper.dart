import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageHelper {
  static Future<Map<String, dynamic>> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final patientId = prefs.getInt('patientId');

    if (token == null || patientId == null) {
      throw Exception('User not logged in properly');
    }

    return {
      'token': token,
      'patientId': patientId,
    };
  }
}
