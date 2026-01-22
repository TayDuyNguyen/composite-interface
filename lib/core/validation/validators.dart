/// Validation utilities
/// Provides common validation functions
class Validators {
  /// Required field validation
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (value.length > 128) {
      return 'Password must be less than 128 characters';
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp('[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!value.contains(RegExp('[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp('[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Name validation
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }

    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  /// Phone validation
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (digitsOnly.length > 15) {
      return 'Phone number must be less than 15 digits';
    }

    return null;
  }

  /// Minimum length validation
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }

    return null;
  }

  /// Maximum length validation
  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    if (value.length > maxLength) {
      return '${fieldName ?? 'This field'} must be less than $maxLength characters';
    }

    return null;
  }

  /// URL validation
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }

    final urlRegex = RegExp(
        r'^https?:/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Numeric validation
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    return null;
  }

  /// Integer validation
  static String? integer(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid integer';
    }

    return null;
  }

  /// Positive number validation
  static String? positiveNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    if (number <= 0) {
      return '${fieldName ?? 'This field'} must be a positive number';
    }

    return null;
  }

  /// Date validation
  static String? date(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    try {
      DateTime.parse(value);
      return null;
    } on Exception catch (_) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }

  /// Future date validation
  static String? futureDate(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    try {
      final date = DateTime.parse(value);
      if (date.isBefore(DateTime.now())) {
        return '${fieldName ?? 'This field'} must be a future date';
      }
      return null;
    } on Exception catch (_) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }

  /// Past date validation
  static String? pastDate(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    try {
      final date = DateTime.parse(value);
      if (date.isAfter(DateTime.now())) {
        return '${fieldName ?? 'This field'} must be a past date';
      }
      return null;
    } on Exception catch (_) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }

  /// Confirm password validation
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Custom validation
  static String? custom(
      String? value, bool Function(String) validator, String errorMessage) {
    if (value == null || value.isEmpty) {
      return null; // Let required validation handle empty values
    }

    if (!validator(value)) {
      return errorMessage;
    }

    return null;
  }
}
