import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    const baseUrl = 'http://10.0.2.2:5000/api';

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    /// 🔥 Logging (dev only ideally)
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Dio get dio => _dio;

  // ===============================
  // HTTP METHODS
  // ===============================

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> put<T>(String path, {dynamic data}) async {
    try {
      return await _dio.put<T>(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> delete<T>(String path, {dynamic data}) async {
    try {
      return await _dio.delete<T>(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ===============================
  // ERROR HANDLER
  // ===============================

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception('Error ${e.response?.statusCode}: ${e.response?.data}');
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
