import 'package:dio/dio.dart';
import '../services/authentication_service.dart';
import 'api_constants.dart';

class DioFactory {
  static Dio getDio(AuthenticationService authService) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // TODO: Add API key if required
        // 'x-api-key': ApiConstants.apiKey,
      },
    );

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authentication token if available
          final token = await authService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          // TODO: Add API key to headers if required
          // options.headers['x-api-key'] = ApiConstants.apiKey;
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle errors globally if needed
          return handler.next(error);
        },
      ),
    );

    // Add logging interceptor in debug mode
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    return dio;
  }
}