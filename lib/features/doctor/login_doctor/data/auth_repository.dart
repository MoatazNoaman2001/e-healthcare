import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:doctorapp/core/network/api_client.dart';

import 'models/auth_response.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<Either<String, AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/users/login/',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponseModel.fromJson(response.data);

        // التحقق من أن المستخدم من نوع مريض
        if (authResponse.user.userType != 'doctor') {
            return left('عذراً، هذا الحساب ليس مخصصاً لاطباء');
        }

        return right(authResponse);
      } else {
        final errorMessage = _handleErrorResponse(response);
        return left(errorMessage);
      }
    } catch (e) {
      return left('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى');
    }
  }

  String _handleErrorResponse(Response response) {
    if (response.statusCode == 400) {
      if (response.data != null && response.data is Map) {
        if (response.data.containsKey('non_field_errors')) {
          final errors = response.data['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first;
          }
        }

        if (response.data.containsKey('email')) {
          final errors = response.data['email'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first;
          }
        }

        if (response.data.containsKey('password')) {
          final errors = response.data['password'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first;
          }
        }
      }
      return 'بيانات غير صحيحة، يرجى التحقق من البريد الإلكتروني وكلمة المرور';
    } else if (response.statusCode == 401) {
      return 'بيانات الدخول غير صحيحة';
    } else if (response.statusCode == 403) {
      return 'غير مصرح لك بالدخول';
    } else if (response.statusCode == 404) {
      return 'الخدمة غير متوفرة';
    } else if (response.statusCode == 500) {
      return 'حدث خطأ في الخادم، يرجى المحاولة لاحقاً';
    }

    return 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى';
  }
}