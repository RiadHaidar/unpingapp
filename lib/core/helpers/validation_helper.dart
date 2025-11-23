/// Helper class for input validation
///
/// Provides validation methods for common input types.
/// Used in the presentation layer for immediate UI feedback.
class ValidationHelper {
  /// Validates name field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required';
    }
    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validates email field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates phone field
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\d+$');
    if (!phoneRegex.hasMatch(phone.trim())) {
      return 'Phone number must contain only numbers';
    }

    if (phone.trim().length < 8) {
      return 'Phone number must be at least 8 digits';
    }

    return null;
  }

  /// Validates password field
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  /// Validates password confirmation
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePasswordConfirmation(
    String? password,
    String? passwordConfirmation,
  ) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return 'Password confirmation is required';
    }

    if (password != passwordConfirmation) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates gender field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateGender(int? gender) {
    if (gender == null) {
      return 'Please select your gender';
    }

    if (gender != 0 && gender != 1) {
      return 'Please select a valid gender';
    }

    return null;
  }

  /// Validates all registration fields at once
  ///
  /// Returns a map of field names to error messages
  /// Empty map means all fields are valid
  static Map<String, String> validateRegistrationForm({
    required String? name,
    required String? email,
    required String? phone,
    required int? gender,
    required String? password,
    required String? passwordConfirmation,
  }) {
    final Map<String, String> errors = {};

    final nameError = validateName(name);
    if (nameError != null) errors['name'] = nameError;

    final emailError = validateEmail(email);
    if (emailError != null) errors['email'] = emailError;

    final phoneError = validatePhone(phone);
    if (phoneError != null) errors['phone'] = phoneError;

    final genderError = validateGender(gender);
    if (genderError != null) errors['gender'] = genderError;

    final passwordError = validatePassword(password);
    if (passwordError != null) errors['password'] = passwordError;

    final confirmPasswordError = validatePasswordConfirmation(
      password,
      passwordConfirmation,
    );
    if (confirmPasswordError != null) {
      errors['passwordConfirmation'] = confirmPasswordError;
    }

    return errors;
  }

  /// Checks if all fields are valid
  static bool isRegistrationFormValid({
    required String? name,
    required String? email,
    required String? phone,
    required int? gender,
    required String? password,
    required String? passwordConfirmation,
  }) {
    final errors = validateRegistrationForm(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    return errors.isEmpty;
  }
}