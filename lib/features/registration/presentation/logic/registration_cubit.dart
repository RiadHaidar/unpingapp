import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/authentication_service.dart';
import '../../domain/usecases/register_user_use_case.dart';
import 'registration_states.dart';


class RegistrationCubit extends Cubit<RegistrationStates> {
  final RegisterUserUseCase _registerUserUseCase;
  final AuthenticationService _authService;

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  // Gender selection (0 = Male, 1 = Female)
  int? selectedGender;

  RegistrationCubit(
    this._registerUserUseCase,
    this._authService,
  ) : super(RegistrationInitial());

  void setGender(int? gender) {
    selectedGender = gender;
  }


  Future<void> register() async {
    emit(RegistrationLoading());

    final params = RegisterUserParams(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      gender: selectedGender!,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
    );

    final result = await _registerUserUseCase.call(params);

    result.when(
      success: (user) async {
        await _storeAuthenticationData(user.token, user.username);

        emit(RegistrationSuccess(
          user: user,
          message: 'Registration successful! Welcome ${user.username}',
        ));
      },
      failure: (error) {
        emit(RegistrationFailure(error));
      },
    );
  }



  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
    selectedGender = null;
  }

  void reset() {
    clearForm();
    emit(RegistrationInitial());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    return super.close();
  }

  /// Stores authentication data after successful registration
  Future<void> _storeAuthenticationData(String token, String username) async {
    await _authService.saveToken(token);

    await _authService.saveUserId(username);
  }
}