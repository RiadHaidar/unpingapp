import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unping_ui/unping_ui.dart';

import '../../../../core/routing/routes.dart';
import '../logic/registration_cubit.dart';
import '../logic/registration_states.dart';

/// Listens to [RegistrationCubit] state changes and handles:
/// - Loading state: Shows a loading dialog
/// - Success state: Dismisses dialog, shows success snackbar, navigates to home
/// - Failure state: Dismisses dialog, shows error snackbar
class RegistrationStateListener extends StatelessWidget {
  const RegistrationStateListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationCubit, RegistrationStates>(
      listener: _handleStateChange,
      child: const SizedBox.shrink(),
    );
  }

  void _handleStateChange(BuildContext context, RegistrationStates state) {
    if (state is RegistrationLoading) {
      _showLoadingDialog(context);
    } else if (state is RegistrationSuccess) {
      _handleSuccess(context, state);
    } else if (state is RegistrationFailure) {
      _handleFailure(context, state);
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _handleSuccess(BuildContext context, RegistrationSuccess state) {
    _dismissDialogIfOpen(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: UiColors.success,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.go(Routes.home);
      }
    });
  }

  void _handleFailure(BuildContext context, RegistrationFailure state) {
    _dismissDialogIfOpen(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: UiColors.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _dismissDialogIfOpen(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
