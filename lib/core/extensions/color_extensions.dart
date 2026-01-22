import 'package:flutter/material.dart';

/// Color extensions for opacity handling
/// Provides compatibility layer for withOpacity deprecated warning
extension ColorExtensions on Color {
  /// Get color with opacity (0.0 - 1.0)
  Color withAlphaValue(double opacity) =>
      withAlpha((opacity.clamp(0.0, 1.0) * 255).round());

  /// Returns true if the color is dark
  bool get isDark => computeLuminance() < 0.5;

  /// Returns true if the color is light
  bool get isLight => computeLuminance() >= 0.5;

  /// Returns a contrast color (black or white) for the current color
  Color get contrastColor => isDark ? Colors.white : Colors.black;

  /// Converts color to hex string
  String toHex({bool includeAlpha = true}) {
    final a = (this.a * 255).round().toRadixString(16).padLeft(2, '0');
    final r = (this.r * 255).round().toRadixString(16).padLeft(2, '0');
    final g = (this.g * 255).round().toRadixString(16).padLeft(2, '0');
    final b = (this.b * 255).round().toRadixString(16).padLeft(2, '0');
    return '#${includeAlpha ? a : ''}$r$g$b'.toUpperCase();
  }

  /// Darkens the color by the given amount (0.0 - 1.0)
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Lightens the color by the given amount (0.0 - 1.0)
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

/// MaterialColor extensions for opacity handling
extension MaterialColorExtensions on MaterialColor {
  /// Get color with opacity (0.0 - 1.0)
  Color withAlphaValue(double opacity) {
    final clampedOpacity = opacity.clamp(0.0, 1.0);
    final alpha = (clampedOpacity * 255).round();
    return withAlpha(alpha);
  }
}
