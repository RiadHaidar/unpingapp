import '../../domain/entities/user_entity.dart';


sealed class RegistrationStates {}

final class RegistrationInitial extends RegistrationStates {}

final class RegistrationLoading extends RegistrationStates {}

final class RegistrationSuccess extends RegistrationStates {
  final UserEntity user;
  final String message;

  RegistrationSuccess({
    required this.user,
    this.message = 'Registration successful!',
  });
}

final class RegistrationFailure extends RegistrationStates {
  final String message;

  RegistrationFailure(this.message);
}