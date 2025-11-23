# UnPing App

A Flutter application built with **Clean Architecture** principles, demonstrating best practices for scalable and maintainable mobile development.

## Features

- User Registration with form validation
- Token-based authentication
- Cross-platform support (iOS, Android, macOS, Windows, Linux)

---

## Architecture

This project follows **Clean Architecture** with a feature-first folder structure, ensuring separation of concerns and testability.

```
lib/
├── core/                           # Shared infrastructure
│   ├── di/                         # Dependency injection (GetIt)
│   ├── helpers/                    # Utilities (validation, storage, constants)
│   ├── networking/                 # HTTP client setup (Dio, interceptors)
│   ├── routing/                    # Navigation (GoRouter)
│   └── services/                   # App-wide services (authentication)
│
├── features/                       # Feature modules
│   └── registration/
│       ├── data/                   # Data layer
│       │   ├── datasources/        # API services (Retrofit)
│       │   ├── models/             # DTOs, request/response models
│       │   └── repos/              # Repository implementations
│       │
│       ├── domain/                 # Domain layer
│       │   ├── entities/           # Business objects
│       │   ├── repos/              # Repository contracts (abstract)
│       │   └── usecases/           # Business logic
│       │
│       └── presentation/           # Presentation layer
│           ├── logic/              # State management (Cubit)
│           ├── screens/            # Page widgets
│           └── widgets/            # Reusable UI components
│
├── main.dart                       # Entry point
└── unpingapp.dart                  # Root widget
```

### Layer Responsibilities

| Layer | Purpose |
|-------|---------|
| **Domain** | Business logic, entities, use cases. No external dependencies. |
| **Data** | API calls, DTOs, repository implementations. Depends on domain. |
| **Presentation** | UI, state management, user interaction. Depends on domain. |

---

## Tech Stack

### State Management
- **flutter_bloc** `^8.1.6` - Cubit pattern for predictable state management

### Dependency Injection
- **get_it** `^9.0.5` - Service locator for dependency injection

### Networking
- **dio** `^5.9.0` - HTTP client with interceptors
- **retrofit** `^4.1.0` - Type-safe API client generator

### Navigation
- **go_router** `^17.0.0` - Declarative routing with deep link support

### Local Storage
- **shared_preferences** `^2.5.3` - Key-value persistent storage

### Serialization
- **json_annotation** `^4.9.0` - JSON serialization annotations
- **json_serializable** `^6.8.0` - Code generation for JSON

### UI
- **unping_ui** `^0.2.0` - Custom design system components

### Desktop Support
- **window_manager** `^0.5.1` - Desktop window configuration

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.9.2`
- Dart SDK `^3.9.2`

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd unpingapp

# Install dependencies
flutter pub get

# Generate code (Retrofit, JSON serialization)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Running on Different Platforms

```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

---

## Project Patterns

### API Result Pattern

Type-safe error handling using sealed classes:

```dart
sealed class ApiResult<T> {
  const factory ApiResult.success(T data) = SuccessResult;
  const factory ApiResult.failure(String error) = FailureResult;
}

// Usage
final result = await repository.register(request);
result.when(
  success: (user) => emit(RegistrationSuccess(user)),
  failure: (error) => emit(RegistrationFailure(error)),
);
```

### State Management

Cubit with sealed state classes:

```dart
sealed class RegistrationStates {}
class RegistrationInitial extends RegistrationStates {}
class RegistrationLoading extends RegistrationStates {}
class RegistrationSuccess extends RegistrationStates {}
class RegistrationFailure extends RegistrationStates {}
```

### Dependency Injection

Lazy singleton registration with GetIt:

```dart
final getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerLazySingleton<Dio>(() => DioFactory.createDio());

  // Repositories
  getIt.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepo(getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => RegisterUserUseCase(getIt()));

  // Cubits (factory for fresh instances)
  getIt.registerFactory(() => RegistrationCubit(getIt(), getIt()));
}
```

---

## API Configuration

Base URL and endpoints are configured in:

```
lib/features/registration/data/datasources/registration_api_constants.dart
```

The Dio client includes interceptors for:
- **Authentication** - Automatically attaches bearer tokens
- **Error Handling** - Parses validation errors (422 responses)
- **Logging** - Request/response logging in debug mode

---

## Validation

Client-side validation is centralized in `ValidationHelper`:

```dart
ValidationHelper.validateEmail(email);      // Email format
ValidationHelper.validatePassword(password); // Min 8 characters
ValidationHelper.validatePhone(phone);       // Numeric, min 8 digits
ValidationHelper.validateName(name);         // Non-empty, min 2 chars
```

---

## Environment

| Requirement | Version |
|-------------|---------|
| Flutter | 3.9.2+ |
| Dart | 3.9.2+ |
| iOS | 12.0+ |
| Android | API 21+ |
| macOS | 10.14+ |

---

DEMO:


https://github.com/user-attachments/assets/76a6baf6-0baa-4556-afff-376c71644694




https://github.com/user-attachments/assets/6fa61f27-3564-4561-aa43-67e09413f983


