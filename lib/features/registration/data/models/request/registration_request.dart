import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegistrationRequest {
  final String name;
  final String email;
  final String phone;
  final int gender; // 0 = Male, 1 = Female
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;

  RegistrationRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
    required this.passwordConfirmation,
  });

  /// Converts the object to a Map for multipart/form-data
  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);

  /// Creates a copy with updated fields
  RegistrationRequest copyWith({
    String? name,
    String? email,
    String? phone,
    int? gender,
    String? password,
    String? passwordConfirmation,
  }) {
    return RegistrationRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }
}