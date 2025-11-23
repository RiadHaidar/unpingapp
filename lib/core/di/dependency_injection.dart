import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../networking/dio_factory.dart';
import '../services/authentication_service.dart';

import '../../features/registration/data/datasources/registration_api_service.dart';
import '../../features/registration/data/repositories/registration_repo.dart';
import '../../features/registration/domain/repositories/registration_repository.dart';
import '../../features/registration/domain/usecases/register_user_use_case.dart';
import '../../features/registration/presentation/logic/registration_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // ===== CORE SERVICES =====
  getIt.registerLazySingleton<AuthenticationService>(
    () => AuthenticationService(),
  );

  // ===== DIO (HTTP CLIENT) =====
  getIt.registerLazySingleton<Dio>(
    () => DioFactory.getDio(getIt<AuthenticationService>()),
  );

  // ===== FEATURES =====

  // ===== REGISTRATION FEATURE =====
  // Registration API Service
  getIt.registerLazySingleton<RegistrationApiService>(
    () => RegistrationApiService(getIt<Dio>()),
  );

  // Registration Repository Implementation
  getIt.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepo(getIt<RegistrationApiService>()),
  );

  // Registration Use Case
  getIt.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(getIt<RegistrationRepository>()),
  );

  // Registration Cubit
  getIt.registerFactory<RegistrationCubit>(
    () => RegistrationCubit(
      getIt<RegisterUserUseCase>(),
      
      getIt<AuthenticationService>(),
    ),
  );

}