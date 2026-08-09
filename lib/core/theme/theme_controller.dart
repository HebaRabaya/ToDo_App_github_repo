import 'package:flutter/material.dart';

import '../services/preferences_manager.dart';

// =========================================================
// Theme Controller
// =========================================================

// هذا الـ Controller مسؤول عن تغيير الثيم.
//
// بدل ما نغير الثيم من كل مكان بالتطبيق
// بنخلي المسؤولية هون.
class ThemeController extends ChangeNotifier {
  ThemeController._();

  // نسخة واحدة من الـ Controller
  static final ThemeController instance =
  ThemeController._();

  // =========================================================
  // Current Theme
  // =========================================================

  ThemeMode get themeMode {
    return PreferencesManager.instance.isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  // =========================================================
  // Is Dark Mode?
  // =========================================================

  bool get isDarkMode {
    return themeMode == ThemeMode.dark;
  }

  // =========================================================
  // Change Theme
  // =========================================================

  Future<void> setTheme(
      ThemeMode mode,
      ) async {
    final isDark =
        mode == ThemeMode.dark;

    await PreferencesManager.instance
        .saveDarkMode(isDark);

    notifyListeners();
  }

  // =========================================================
  // Toggle Theme
  // =========================================================

  Future<void> toggleTheme() async {
    await setTheme(
      isDarkMode
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }
}