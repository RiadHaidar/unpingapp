import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';

class UnpingApp extends StatelessWidget {
  const UnpingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UnPing App',
  
      routerConfig: AppRouter.router,
    );
  }
}
