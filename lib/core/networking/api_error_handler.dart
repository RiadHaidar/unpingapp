import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: 'Connection timeout');
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'Request cancelled');
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: 'No internet connection');
        default:
          return ApiErrorModel(message: 'Something went wrong');
      }
    }
    return ApiErrorModel(message: error.toString());
  }

  static ApiErrorModel _handleBadResponse(Response? response) {
    if (response?.statusCode == 401) {
      return ApiErrorModel(message: 'Unauthorized');
    } else if (response?.statusCode == 404) {
      return ApiErrorModel(message: 'Not found');
    } else if (response?.statusCode == 500) {
      return ApiErrorModel(message: 'Server error');
    }
    return ApiErrorModel(message: 'Error: ${response?.statusCode}');
  }
}