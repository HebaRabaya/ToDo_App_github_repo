import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,

      scaffoldBackgroundColor:
      const Color(0xFF181818),

      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF20C477),
        surface: Color(0xFF181818),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF181818),
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      cardColor: const Color(0xFF252525),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),

        bodySmall: TextStyle(
          color: Color(0xFFBDBDBD),
        ),

        titleMedium: TextStyle(
          color: Colors.white,
        ),
      ),

      inputDecorationTheme:
      InputDecorationTheme(
        filled: true,

        fillColor:
        const Color(0xFF292929),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),

          borderSide: const BorderSide(
            color: Color(0xFF555555),
          ),
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),

          borderSide: const BorderSide(
            color: Color(0xFF555555),
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
          color: Color(0xFFAAAAAA),
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