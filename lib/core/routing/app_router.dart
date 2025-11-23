import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../di/dependency_injection.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/registration/presentation/screens/registration_screen.dart';
import '../../features/registration/presentation/logic/registration_cubit.dart';
import 'routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.registration,
    routes: [
      // Home Screen Route
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      // Registration Screen Route with BlocProvider
      GoRoute(
        path: Routes.registration,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<RegistrationCubit>(),
          child: const RegistrationScreen(),
        ),
      ),

 
    ],
  );
}