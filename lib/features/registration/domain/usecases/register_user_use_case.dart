import '../../../../core/networking/api_result.dart';
import '../entities/user_entity.dart';
import '../repositories/registration_repository.dart';

/// Use case for registering a new user
///
/// This encapsulates the business coordination for user registration.
/// Validation is handled in the presentation layer for immediate UI feedback.
class RegisterUserUseCase {
  final RegistrationRepository _repository;

  RegisterUserUseCase(this._repository);

  /// Registers a new user
  ///
  /// Parameters:
  /// - [params]: Registration parameters
  ///
  /// Returns [ApiResult.success] with [UserEntity] on successful registration
  /// Returns [ApiResult.failure] with error message on failure
  Future<ApiResult<UserEntity>> call(RegisterUserParams params) async {
    return await _repository.register(
      name: params.name,
      email: params.email,
      phone: params.phone,
      gender: params.gender,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }
}

/// Parameters for user registration
class RegisterUserParams {
  final String name;
  final String email;
  final String phone;
  final int gender; // 0 = Male, 1 = Female
  final String password;
  final String passwordConfirmation;

  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
    required this.passwordConfirmation,
  });

  /// Creates a copy with updated fields
  RegisterUserParams copyWith({
    String? name,
    String? email,
    String? phone,
    int? gender,
    String? password,
    String? passwordConfirmation,
  }) {
    return RegisterUserParams(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterUserParams &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          gender == other.gender &&
          password == other.password &&
          passwordConfirmation == other.passwordConfirmation;

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      gender.hashCode ^
      password.hashCode ^
      passwordConfirmation.hashCode;

  @override
  String toString() =>
      'RegisterUserParams(name: $name, email: $email, phone: $phone, gender: $gender, password: [HIDDEN], passwordConfirmation: [HIDDEN])';
}