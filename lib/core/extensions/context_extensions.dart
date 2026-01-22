import 'package:flutter/material.dart';

/// Context extensions for UI utilities
extension ContextExtensions on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if device is tablet
  bool get isTablet => MediaQuery.of(this).size.width >= 600;

  /// Get responsive value
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isTablet) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  /// Get responsive padding
  EdgeInsets get responsivePadding => EdgeInsets.symmetric(
        horizontal: isTablet ? 32 : 16,
        vertical: isTablet ? 24 : 16,
      );

  /// Get responsive font size
  double responsiveFontSize(double baseFontSize) =>
      isTablet ? baseFontSize * 1.2 : baseFontSize;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Get status bar height
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Get bottom padding
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Check if app is in dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get theme color based on current theme
  Color get themeColor => isDarkMode ? Colors.white : Colors.black;
}
