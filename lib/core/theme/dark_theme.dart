// =========================================================
// Dark Theme
// =========================================================
//
// هذا الملف فيه إعدادات الـ Dark Theme
// الخاصة بالتطبيق.
//
// =========================================================

import 'package:flutter/material.dart';

class DarkTheme {
  static final ThemeData theme =
  ThemeData(
    brightness:
    Brightness.dark,

    scaffoldBackgroundColor:
    const Color(0xFF181818),

    cardColor:
    const Color(0xFF242424),

    colorScheme:
    ColorScheme.fromSeed(
      seedColor:
      const Color(
        0xFF52C070,
      ),
      brightness:
      Brightness.dark,
    ),

    useMaterial3: true,

    inputDecorationTheme:
    InputDecorationTheme(
      filled: true,

      fillColor:
      const Color(
        0xFF242424,
      ),

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