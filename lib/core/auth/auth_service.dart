// lib/core/auth/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../di/dependancy_injection.dart' as di;
import 'dart:convert';

import '../models/user_model.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService({required SharedPreferences prefs}) : _prefs = prefs;

  // Check if user is logged in
  bool get isLoggedIn => _prefs.containsKey('auth_token') && _prefs.getString('auth_token')!.isNotEmpty;

  // Get the current user ID
  int? get currentUserId => _prefs.getInt('user_id');

  // Get the current patient ID
  int? get currentPatientId => _prefs.getInt('patient_id');

  // Get the current user type
  String? get currentUserType => _prefs.getString('user_type');

  // Get auth token
  String? get token => _prefs.getString('auth_token');

  // Get user model
  UserModel? getUserModel() {
    final userJson = _prefs.getString('user_model');
    if (userJson == null) return null;

    try {
      return UserModel.fromJson(json.decode(userJson));
    } catch (e) {
      print('Error parsing user model: $e');
      return null;
    }
  }

  // Login
  Future<void> login({
    required String token,
    required UserModel user,
    int? patientId,
    int? doctorId,
  }) async {
    // Store auth data
    await _prefs.setString('auth_token', token);
    await _prefs.setInt('user_id', user.id);
    await _prefs.setString('user_email', user.email);
    await _prefs.setString('user_type', user.userType);

    // Store the complete user model as JSON
    await _prefs.setString('user_model', json.encode(user.toJson()));

    // Store additional IDs if available
    if (patientId != null) {
      await _prefs.setInt('patient_id', patientId);
    }

    if (doctorId != null) {
      await _prefs.setInt('doctor_id', doctorId);
    }

    // Notify the app about the login
    di.eventBus.fire(di.UserLoggedInEvent(token));
  }

  // Logout
  Future<void> logout() async {
    // Clear auth data
    await _prefs.remove('auth_token');
    await _prefs.remove('user_id');
    await _prefs.remove('user_email');
    await _prefs.remove('user_type');
    await _prefs.remove('patient_id');
    await _prefs.remove('doctor_id');
    await _prefs.remove('user_model');

    // Notify the app about the logout
    di.eventBus.fire(di.UserLoggedOutEvent());
  }
}

// Register the auth service in the dependency injection container
void registerAuthService() {
  di.sl.registerLazySingleton(
        () => AuthService(prefs: di.sl()),
  );
}