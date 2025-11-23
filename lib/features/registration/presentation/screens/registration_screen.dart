import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

import '../widgets/registration_state_listener.dart';
import '../widgets/registration_form.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(
        title: Text('Registration', style: UiTextStyles.displayMdSemibold),
        backgroundColor: UiColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: UiColors.neutral700),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UiSpacing.allL,
          child: Center(
            child: Container(
              width: UiSpacing.spacing96,
              constraints: const BoxConstraints(
                maxWidth: UiSpacing.spacing96,
                minWidth: UiSpacing.spacing48,
              ),
              decoration: BoxDecoration(
                color: UiColors.primary200,
                borderRadius: UiRadius.allLg,
                border: Border.all(color: UiColors.border, width: 1),
              ),
              child: Padding(
                padding: UiSpacing.allL,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const RegistrationStateListener(),
                    Text(
                      'Create Account',
                      style: UiTextStyles.displayMdSemibold,
                      textAlign: TextAlign.center,
                    ),
                    UiSpacing.verticalGapXs,
                    Text(
                      'Fill in the details below to get started',
                      style: UiTextStyles.textLg.copyWith(color: UiColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    UiSpacing.verticalGapXl,
                    const RegistrationForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
