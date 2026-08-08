import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,

      scaffoldBackgroundColor:
      Colors.white,

      colorScheme: const ColorScheme.light(
        primary: Color(0xFF20C477),
        surface: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      cardColor: const Color(0xFFF5F5F5),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),

        bodySmall: TextStyle(
          color: Color(0xFF666666),
        ),

        titleMedium: TextStyle(
          color: Colors.black,
        ),
      ),

      inputDecorationTheme:
      InputDecorationTheme(
        filled: true,

        fillColor:
        const Color(0xFFF5F5F5),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),

          borderSide: const BorderSide(
            color: Color(0xFFCCCCCC),
          ),
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),

          borderSide: const BorderSide(
            color: Color(0xFFCCCCCC),
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),

          borderSide: const BorderSide(
            color: Color(0xFF20C477),
          ),
        ),

        hintStyle: const TextStyle(
          color: Color(0xFF777777),
        ),
      ),

      elevatedButtonTheme:
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          const Color(0xFF20C477),

          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}