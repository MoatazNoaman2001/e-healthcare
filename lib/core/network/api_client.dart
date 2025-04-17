import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  static const String _baseUrl = 'http://128.140.39.237/api/v1';

  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    responseType: ResponseType.json,
  ));

  Future<Response> post(
      String path, {
        required Map<String, dynamic> data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Response _handleError(DioException e) {
    if (e.response != null) {
      return e.response!;
    } else {
      throw Exception('فشل الاتصال بالخادم، يرجى التحقق من اتصالك بالإنترنت');
    }
  }
}