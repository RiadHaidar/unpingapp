import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(
        title: Text(
          'UnPing Home',
          style: UiTextStyles.displayMdSemibold,
        ),
        backgroundColor: UiColors.background,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: UiColors.primary,
            ),
            UiSpacing.verticalGapXl,
            Text(
              '🎉 Welcome to UnPing!',
              style: UiTextStyles.displayMdSemibold,
              textAlign: TextAlign.center,
            ),
            UiSpacing.verticalGapM,
            Text(
              'Registration successful!\nYou are now logged in.',
              style: UiTextStyles.textLg.copyWith(
                color: UiColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            UiSpacing.verticalGapXl,
            Buttons.filled(
              text: 'Explore App',
              onPressed: () {
                // TODO: Navigate to other features
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Feature coming soon!'),
                    backgroundColor: UiColors.neutral800,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}