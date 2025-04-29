import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../error/failure.dart';
import './endpoints.dart';
import 'package:fpdart/fpdart.dart';
import '../utils/typedefs.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  ApiClient({required Dio dio, required FlutterSecureStorage secureStorage})
      : _dio = dio, _secureStorage = secureStorage {
  }

  // Generic request method that returns Either type from fpdart
  ResultFuture<T> request<T>({
    required String endpoint,
    required RequestMethod method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      Response response;

      switch (method) {
        case RequestMethod.get:
          response = await _dio.get(
            endpoint,
            queryParameters: queryParameters,
          );
          break;
        case RequestMethod.post:
          response = await _dio.post(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case RequestMethod.put:
          response = await _dio.put(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case RequestMethod.patch:
          response = await _dio.patch(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case RequestMethod.delete:
          response = await _dio.delete(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (fromJson != null) {
          return right(fromJson(response.data));
        }
        return right(response.data as T);
      } else {
        return left(
          ServerFailure(
            message: response.statusMessage ?? 'Unknown error occurred',
          ),
        );
      }
    } on DioError catch (e) {
      return left(
        ServerFailure(
          message: e.response?.statusMessage ?? e.message ?? 'Unknown error occurred',
        ),
      );
    } catch (e) {
      return left(
        UnexpectedFailure(
          message: e.toString(),
        ),
      );
    }
  }
}

enum RequestMethod { get, post, put, patch, delete }