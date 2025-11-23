import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unping_ui/unping_ui.dart';

import '../../../../core/helpers/validation_helper.dart';
import '../logic/registration_cubit.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _genderError;
  String? _passwordError;
  String? _passwordConfirmationError;

  bool _validateAllFields(RegistrationCubit cubit) {
    setState(() {
      _nameError = ValidationHelper.validateName(cubit.nameController.text);
      _emailError = ValidationHelper.validateEmail(cubit.emailController.text);
      _phoneError = ValidationHelper.validatePhone(cubit.phoneController.text);
      _genderError = ValidationHelper.validateGender(cubit.selectedGender);
      _passwordError = ValidationHelper.validatePassword(cubit.passwordController.text);
      _passwordConfirmationError = ValidationHelper.validatePasswordConfirmation(
        cubit.passwordController.text,
        cubit.passwordConfirmationController.text,
      );
    });

    return _nameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _genderError == null &&
        _passwordError == null &&
        _passwordConfirmationError == null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegistrationCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseInput(
          controller: cubit.nameController,
          resizable: true,
          helperText: 'Full Name',
          placeholder: 'Enter your full name',
          errorText: _nameError,
          onChanged: (_) {
            if (_nameError != null) setState(() => _nameError = null);
          },
        ),
        UiSpacing.verticalGapM,

        BaseInput(
          controller: cubit.emailController,
          helperText: 'Email Address',
          placeholder: 'Enter your email',
          errorText: _emailError,
          onChanged: (_) {
            if (_emailError != null) setState(() => _emailError = null);
          },
        ),
        UiSpacing.verticalGapM,

        BaseInput(
          controller: cubit.phoneController,
          helperText: 'Phone Number',
          placeholder: 'Enter your phone number',
          errorText: _phoneError,
          onChanged: (_) {
            if (_phoneError != null) setState(() => _phoneError = null);
          },
        ),
        UiSpacing.verticalGapM,

        Text('Gender', style: UiTextStyles.textMdSemibold),
        UiSpacing.verticalGapSm,
        BaseDropdown(
          config: DropdownConfig(menuPosition: DropdownMenuPosition.below),
          options: [
            DropdownOption(value: 0, label: 'Male'),
            DropdownOption(value: 1, label: 'Female'),
          ],
          onChanged: (value) {
            cubit.setGender(value);
            if (_genderError != null) setState(() => _genderError = null);
          },
        ),
        if (_genderError != null) ...[
          UiSpacing.verticalGapSm,
          Text(
            _genderError!,
            style: UiTextStyles.textSm.copyWith(color: UiColors.error),
          ),
        ],
        UiSpacing.verticalGapM,

        BaseInput(
          controller: cubit.passwordController,
          helperText: 'Password',
          placeholder: 'Enter your password',
          obscureText: true,
          showObscureToggle: true,
          errorText: _passwordError,
          onChanged: (_) {
            if (_passwordError != null) setState(() => _passwordError = null);
          },
        ),
        UiSpacing.verticalGapM,

        BaseInput(
          controller: cubit.passwordConfirmationController,
          helperText: 'Confirm Password',
          placeholder: 'Enter your password again',
          obscureText: true,
          showObscureToggle: true,
          errorText: _passwordConfirmationError,
          onChanged: (_) {
            if (_passwordConfirmationError != null) setState(() => _passwordConfirmationError = null);
          },
        ),
        UiSpacing.verticalGapXl,

        Buttons.filled(
          text: 'Create Account',
          onPressed: () {
            if (_validateAllFields(cubit)) {
              cubit.register();
            }
          },
        ),
        UiSpacing.verticalGapM,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: UiTextStyles.textMd.copyWith(color: UiColors.textSecondary),
            ),
            GestureDetector(
              onTap: () {
                // TODO: Navigate to sign in screen
              },
              child: Text(
                'Sign In',
                style: UiTextStyles.textMdSemibold.copyWith(color: UiColors.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
