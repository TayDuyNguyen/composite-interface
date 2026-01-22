import 'package:myapp/core/validation/validators.dart';

/// Form validator
/// Provides form validation functionality
class FormValidator {
  /// Validate a single field
  static String? validateField({
    required String? value,
    required List<String? Function(String?)> validators,
  }) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  /// Validate multiple fields
  static Map<String, String?> validateFields({
    required Map<String, String?> values,
    required Map<String, List<String? Function(String?)>> fieldValidators,
  }) {
    final errors = <String, String?>{};

    for (final field in fieldValidators.keys) {
      final value = values[field];
      final validators = fieldValidators[field]!;

      final error = validateField(value: value, validators: validators);

      if (error != null) {
        errors[field] = error;
      }
    }

    return errors;
  }

  /// Validate login form
  static Map<String, String?> validateLoginForm({
    required String? email,
    required String? password,
  }) => validateFields(
    values: {'email': email, 'password': password},
    fieldValidators: {
      'email': [Validators.required, Validators.email],
      'password': [Validators.required],
    },
  );

  /// Validate registration form
  static Map<String, String?> validateRegistrationForm({
    required String? email,
    required String? password,
    required String? confirmPassword,
    required String? name,
    String? phone,
  }) => validateFields(
    values: {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
      'phone': phone,
    },
    fieldValidators: {
      'email': [Validators.required, Validators.email],
      'password': [Validators.required, Validators.password],
      'confirmPassword': [
        Validators.required,
        (value) => Validators.confirmPassword(value, password),
      ],
      'name': [Validators.required, Validators.name],
      'phone': [Validators.phone],
    },
  );

  /// Validate profile form
  static Map<String, String?> validateProfileForm({
    required String? name,
    String? phone,
    String? email,
  }) => validateFields(
    values: {'name': name, 'phone': phone, 'email': email},
    fieldValidators: {
      'name': [Validators.required, Validators.name],
      'phone': [Validators.phone],
      'email': [Validators.required, Validators.email],
    },
  );

  /// Validate change password form
  static Map<String, String?> validateChangePasswordForm({
    required String? currentPassword,
    required String? newPassword,
    required String? confirmPassword,
  }) => validateFields(
    values: {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    },
    fieldValidators: {
      'currentPassword': [Validators.required],
      'newPassword': [Validators.required, Validators.password],
      'confirmPassword': [
        Validators.required,
        (value) => Validators.confirmPassword(value, newPassword),
      ],
    },
  );

  /// Validate forgot password form
  static Map<String, String?> validateForgotPasswordForm({
    required String? email,
  }) => validateFields(
    values: {'email': email},
    fieldValidators: {
      'email': [Validators.required, Validators.email],
    },
  );

  /// Validate reset password form
  static Map<String, String?> validateResetPasswordForm({
    required String? token,
    required String? newPassword,
    required String? confirmPassword,
  }) => validateFields(
    values: {
      'token': token,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    },
    fieldValidators: {
      'token': [Validators.required],
      'newPassword': [Validators.required, Validators.password],
      'confirmPassword': [
        Validators.required,
        (value) => Validators.confirmPassword(value, newPassword),
      ],
    },
  );

  /// Check if form is valid
  static bool isFormValid(Map<String, String?> errors) =>
      errors.values.every((error) => error == null);

  /// Get first error message
  static String? getFirstError(Map<String, String?> errors) {
    for (final error in errors.values) {
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  /// Get all error messages
  static List<String> getAllErrors(Map<String, String?> errors) =>
      errors.values.where((error) => error != null).cast<String>().toList();

  /// Clear errors
  static Map<String, String?> clearErrors(Map<String, String?> errors) =>
      errors.map((key, value) => MapEntry(key, null));

  /// Clear specific field error
  static Map<String, String?> clearFieldError(
    Map<String, String?> errors,
    String fieldName,
  ) {
    final newErrors = Map<String, String?>.from(errors);
    newErrors[fieldName] = null;
    return newErrors;
  }
}
