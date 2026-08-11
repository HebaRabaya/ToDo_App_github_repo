// =========================================================
// Light Theme
// =========================================================
//
// هذا الملف فيه إعدادات الـ Light Theme
// الخاصة بالتطبيق.
//
// =========================================================

import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData theme =
  ThemeData(
    brightness:
    Brightness.light,

    scaffoldBackgroundColor:
    const Color(0xFFF8F8F8),

    cardColor:
    Colors.white,

    colorScheme:
    ColorScheme.fromSeed(
      seedColor:
      const Color(
        0xFF52C070,
      ),
      brightness:
      Brightness.light,
    ),

    useMaterial3: true,

    inputDecorationTheme:
    InputDecorationTheme(
      filled: true,

      fillColor:
      Colors.white,

      border:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(
          10,
        ),
        borderSide:
        BorderSide.none,
      ),
    ),
  );
}