import 'package:flutter/material.dart';

/// String extensions for common operations
extension StringExtensions on String {
  /// Convert hex string to Color
  Color get toColor {
    var hex = replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    try {
      return Color(int.parse(hex, radix: 16));
    } on Exception catch (_) {
      return Colors.black; // Fallback
    }
  }

  /// Generate color from string hash
  Color get toColorFromHash {
    int hash = 0;
    for (int i = 0; i < length; i++) {
      hash = codeUnitAt(i) + ((hash << 5) - hash);
    }
    return Color(hash & 0x00FFFFFF).withAlpha(255);
  }

  /// Check if string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => !isEmpty;

  /// Capitalize first letter
  String get capitalizeFirst {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word
  String get capitalizeWords {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((word) => word.capitalizeFirst).join(' ');
  }

  /// Remove extra whitespace
  String get removeExtraWhitespace => replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Truncate text with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength)}$suffix';
  }

  /// Check if string is valid email
  bool get isValidEmail {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(this);
  }

  /// Check if string is valid phone number
  bool get isValidPhone {
    final regex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return regex.hasMatch(this);
  }

  /// Check if string is valid URL
  bool get isValidUrl {
    try {
      Uri.parse(this);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Check if string contains only digits
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Check if string contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string contains only alphanumeric characters
  bool get isAlphaNumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Remove all non-numeric characters
  String get removeNonNumeric => replaceAll(RegExp('[^0-9]'), '');

  /// Remove all non-alphabetic characters
  String get removeNonAlpha => replaceAll(RegExp('[^a-zA-Z]'), '');

  /// Remove all non-alphanumeric characters
  String get removeNonAlphaNumeric => replaceAll(RegExp('[^a-zA-Z0-9]'), '');
}
