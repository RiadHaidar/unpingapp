import '../../../../core/networking/api_result.dart';
import '../entities/user_entity.dart';

/// Abstract repository interface for registration functionality
///
/// This defines the contract that the data layer must implement.
/// The domain layer depends on this abstraction, not on concrete implementations.
abstract class RegistrationRepository {
  /// Registers a new user with the provided information
  ///
  /// Returns [ApiResult.success] with [UserEntity] on successful registration
  /// Returns [ApiResult.failure] with error message on failure
  ///
  /// Parameters:
  /// - [name]: User's full name
  /// - [email]: User's email address (must be valid and unique)
  /// - [phone]: User's phone number (must be numeric and unique)
  /// - [gender]: User's gender (0 = Male, 1 = Female)
  /// - [password]: User's password (minimum 8 characters)
  /// - [passwordConfirmation]: Password confirmation (must match password)
  Future<ApiResult<UserEntity>> register({
    required String name,
    required String email,
    required String phone,
    required int gender,
    required String password,
    required String passwordConfirmation,
  });
}