import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart' as rft;
import '../../../../core/networking/api_constants.dart';
import '../models/response/registration_response.dart';
import 'registration_api_constants.dart';

part 'registration_api_service.g.dart';

/// API service for registration-related HTTP calls using Retrofit
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RegistrationApiService {
  factory RegistrationApiService(Dio dio) {
    // Add any service-specific interceptors here if needed
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Ensure Accept header for registration
          options.headers['Accept'] = 'application/json';
          handler.next(options);
        },
        onError: (error, handler) {
          // Handle registration-specific errors
          if (error.response?.statusCode == 422) {
            // Validation errors - parse as RegistrationErrorResponse
            try {
              final errorResponse = RegistrationErrorResponse.fromJson(error.response!.data);
              // Attach parsed error to the DioException
              final modifiedException = DioException(
                requestOptions: error.requestOptions,
                response: error.response,
                type: error.type,
                error: errorResponse,
              );
              handler.next(modifiedException);
            } catch (e) {
              // If parsing fails, continue with original error
              handler.next(error);
            }
          } else {
            handler.next(error);
          }
        },
      ),
    );

    return _RegistrationApiService(dio);
  }

  /// Registers a new user
  ///
  /// Makes a POST request to /auth/register with multipart/form-data
  /// as specified in the VCare API documentation
  @POST(RegistrationApiConstants.register)
  @rft.Headers({'Content-Type': 'multipart/form-data'})
  Future<RegistrationResponse> register(
    @Body() FormData formData,
  );
}