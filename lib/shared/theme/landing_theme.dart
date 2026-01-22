import 'package:flutter/material.dart';

class SaaSColors {
  // Trust Blue + Accent contrast (Pattern 1)
  static const Color primary = Color(0xFF0066FF); // Trust Blue
  static const Color accent = Color(0xFF6366F1); // Electric Indigo
  static const Color background = Color(0xFFFAFAFA);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color glassWhite = Color(0xCCFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  // Pricing Tiers
  static const Color free = Color(0xFF94A3B8);
  static const Color starter = Color(0xFF0066FF);
  static const Color pro = Color(0xFFFACC15);
  static const Color enterprise = Color(0xFF1E293B);
}

class SaaSTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w900,
    color: SaaSColors.textPrimary,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: SaaSColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: SaaSColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    color: SaaSColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    color: SaaSColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}
