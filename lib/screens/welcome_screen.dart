import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/services/preferences_manager.dart';
import 'main_screen.dart';

// =========================================================
// Welcome Screen
// =========================================================

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() =>
      _WelcomeScreenState();
}

// =========================================================
// Logic
// =========================================================

class _WelcomeScreenState
    extends State<WelcomeScreen> {

  final _formKey =
  GlobalKey<FormState>();

  final TextEditingController controller =
  TextEditingController();

  // =========================================================
  // Dispose
  // =========================================================

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // =========================================================
  // Save Username
  // =========================================================

  Future<void> saveUserName() async {

    final name =
    controller.text.trim();

    await PreferencesManager.instance
        .saveUsername(name);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(
        builder: (_) =>
        const MainScreen(),
      ),
    );
  }

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {

    final theme =
    Theme.of(context);

    return AnnotatedRegion<
        SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
        Colors.transparent,

        statusBarIconBrightness:
        theme.brightness ==
            Brightness.dark
            ? Brightness.light
            : Brightness.dark,

        statusBarBrightness:
        theme.brightness ==
            Brightness.dark
            ? Brightness.dark
            : Brightness.light,
      ),

      child: Scaffold(

        backgroundColor:
        theme.scaffoldBackgroundColor,

        body: SafeArea(
          child: SingleChildScrollView(

            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,

                  children: [

                    const SizedBox(height: 18),

                    // =================================================
                    // Logo
                    // =================================================

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Image.asset(
                          "assets/images/logo.png",

                          width: 48,
                          height: 48,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "Tasky",

                          style:
                          theme
                              .textTheme
                              .headlineSmall,
                        ),
                      ],
                    ),

                    const SizedBox(height: 108),

                    // =================================================
                    // Welcome Text
                    // =================================================

                    Text(
                      "Welcome To Tasky 👋🏻",

                      style: theme
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Your productivity journey starts here.",

                      style:
                      theme
                          .textTheme
                          .bodySmall,
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // Image
                    // =================================================

                    Image.asset(
                      "assets/images/task.png",

                      width: 180,
                      height: 180,
                    ),

                    const SizedBox(height: 28),

                    // =================================================
                    // Full Name
                    // =================================================

                    Align(
                      alignment:
                      Alignment.centerLeft,

                      child: Text(
                        "Full Name",

                        style:
                        theme
                            .textTheme
                            .bodyMedium,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller:
                      controller,

                      style:
                      theme
                          .textTheme
                          .bodyMedium,

                      validator: (value) {

                        if (value == null ||
                            value.trim().isEmpty) {

                          return
                            "Please enter your name";
                        }

                        return null;
                      },

                      decoration:
                      const InputDecoration(
                        hintText:
                        "e.g. Sarah Khalid",
                      ),
                    ),

                    const SizedBox(height: 24),

                    // =================================================
                    // Start Button
                    // =================================================

                    SizedBox(
                      width:
                      double.infinity,

                      height: 55,

                      child:
                      ElevatedButton(
                        onPressed: () {

                          if (_formKey
                              .currentState!
                              .validate()) {

                            saveUserName();
                          }
                        },

                        child: const Text(
                          "Let's Get Started",
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}