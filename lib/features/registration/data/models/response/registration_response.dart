import 'package:json_annotation/json_annotation.dart';

part 'registration_response.g.dart';

/// Success response from registration API
@JsonSerializable()
class RegistrationResponse {
  final String message;
  final RegistrationData data;
  final bool status;
  final int code;

  RegistrationResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResponseToJson(this);
}

/// Registration data containing token and username
@JsonSerializable()
class RegistrationData {
  final String token;
  final String username;

  RegistrationData({
    required this.token,
    required this.username,
  });

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationDataToJson(this);
}

/// Error response from registration API (validation failures)
@JsonSerializable()
class RegistrationErrorResponse {
  final String message;
  final Map<String, List<String>> data; // Field-specific validation errors
  final bool status;
  final int code;

  RegistrationErrorResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory RegistrationErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationErrorResponseToJson(this);

  /// Get error messages for a specific field
  List<String> getFieldErrors(String field) {
    return data[field] ?? [];
  }

  /// Get the first error message for a specific field
  String? getFirstFieldError(String field) {
    final errors = getFieldErrors(field);
    return errors.isNotEmpty ? errors.first : null;
  }

  /// Get all error messages as a single formatted string
  String getAllErrorsAsString() {
    return data.values
        .expand((errors) => errors)
        .join('\n');
  }
}