import 'package:flutter/material.dart';

import 'core/services/preferences_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';

import 'screens/main_screen.dart';
import 'screens/welcome_screen.dart';

// =========================================================
// Main
// =========================================================

// أول ملف ببدأ منه التطبيق.
Future<void> main() async {
  // بنتأكد إن Flutter جاهز.
  WidgetsFlutterBinding.ensureInitialized();

  // تجهيز PreferencesManager قبل تشغيل التطبيق.
  await PreferencesManager.instance.init();

  // تشغيل التطبيق.
  runApp(const MyApp());
}

// =========================================================
// My App
// =========================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        PreferencesManager.instance,
        ThemeController.instance,
      ]),
      builder: (context, child) {
        final themeMode =
            ThemeController.instance.themeMode;

        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // =================================================
          // Themes
          // =================================================

          theme: LightTheme.theme,

          darkTheme: DarkTheme.theme,

          themeMode: themeMode,

          // =================================================
          // First Screen
          // =================================================

          home: const StartScreen(),
        );
      },
    );
  }
}

// =========================================================
// Start Screen
// =========================================================

// هاي الشاشة بتقرر:
//
// إذا المستخدم موجود
// → MainScreen
//
// إذا مش موجود
// → WelcomeScreen
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName =
        PreferencesManager.instance.username;

    if (userName.isNotEmpty) {
      return const MainScreen();
    }

    return const WelcomeScreen();
  }
}