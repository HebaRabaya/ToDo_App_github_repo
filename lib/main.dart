import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/preferences_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';
import 'screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager.instance.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PreferencesManager.instance,
        ),

        ChangeNotifierProvider.value(
          value: ThemeController.instance,
        ),
      ],

      child: const MyApp(),
    ),
  );
}

// =========================================================
// My App
// =========================================================

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeController =
    context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Tasky",

      theme: LightTheme.theme,

      darkTheme: DarkTheme.theme,

      themeMode:
      themeController.themeMode,

      home: const MainScreen(),
    );
  }
}