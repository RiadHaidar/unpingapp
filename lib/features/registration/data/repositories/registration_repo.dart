import 'package:dio/dio.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../domain/repositories/registration_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/registration_api_service.dart';
import '../models/request/registration_request.dart';
import '../models/response/registration_response.dart';

/// Repository implementation for registration functionality
///
/// Handles API calls through [RegistrationApiService] and returns type-safe
/// [ApiResult] objects for success/failure scenarios
class RegistrationRepo implements RegistrationRepository {
  final RegistrationApiService _apiService;

  RegistrationRepo(this._apiService);

 
  @override
  Future<ApiResult<UserEntity>> register({
    required String name,
    required String email,
    required String phone,
    required int gender,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final request = RegistrationRequest(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      final formData = FormData.fromMap({
        'name': request.name,
        'email': request.email,
        'phone': request.phone,
        'gender': request.gender.toString(),
        'password': request.password,
        'password_confirmation': request.passwordConfirmation,
      });

      final response = await _apiService.register(formData);

      final userEntity = _mapResponseToEntity(response);

      return ApiResult.success(userEntity);
    } catch (error) {
      if (error is DioException && error.error is RegistrationErrorResponse) {
        final errorResponse = error.error as RegistrationErrorResponse;
        return ApiResult.failure(errorResponse.getAllErrorsAsString());
      }

      if (error is DioException) {
        final apiError = ApiErrorHandler.handle(error);
        return ApiResult.failure(apiError.message);
      }

      return ApiResult.failure(error.toString());
    }
  }

  /// Maps [RegistrationResponse] to [UserEntity]
  ///
  /// Converts the API response data to domain entity
  UserEntity _mapResponseToEntity(RegistrationResponse response) {
    return UserEntity(
      token: response.data.token,
      username: response.data.username,
    );
  }
}