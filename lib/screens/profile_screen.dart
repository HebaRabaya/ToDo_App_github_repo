import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../core/theme/theme_controller.dart';
import 'user_details_screen.dart';
import 'welcome_screen.dart';

// =========================================================
// Profile Screen
// =========================================================

class ProfileScreen
    extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen>
  createState() =>
      _ProfileScreenState();
}

// =========================================================
// Logic
// =========================================================

class _ProfileScreenState
    extends State<ProfileScreen> {
  // =======================================================
  // Show Theme Sheet
  // =======================================================

  Future<void>
  _showThemeSheet() async {
    final currentTheme =
        ThemeController
            .instance
            .themeMode;

    await showModalBottomSheet<void>(
      context: context,

      backgroundColor:
      Theme.of(context)
          .scaffoldBackgroundColor,

      shape:
      const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) {
        final theme =
        Theme.of(context);

        return SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.all(
              16,
            ),

            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Text(
                  "Choose Theme",
                  style: theme
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(
                  height: 16,
                ),

                // Light
                RadioListTile<ThemeMode>(
                  value:
                  ThemeMode.light,

                  groupValue:
                  currentTheme,

                  title:
                  const Text(
                    "Light",
                  ),

                  secondary:
                  const Icon(
                    Icons
                        .light_mode_outlined,
                  ),

                  onChanged:
                      (value) async {
                    if (value ==
                        null) {
                      return;
                    }

                    await ThemeController
                        .instance
                        .setTheme(
                      value,
                    );

                    if (!context.mounted) {
                      return;
                    }

                    Navigator.pop(
                      context,
                    );
                  },
                ),

                // Dark
                RadioListTile<ThemeMode>(
                  value:
                  ThemeMode.dark,

                  groupValue:
                  currentTheme,

                  title:
                  const Text(
                    "Dark",
                  ),

                  secondary:
                  const Icon(
                    Icons
                        .dark_mode_outlined,
                  ),

                  onChanged:
                      (value) async {
                    if (value ==
                        null) {
                      return;
                    }

                    await ThemeController
                        .instance
                        .setTheme(
                      value,
                    );

                    if (!context.mounted) {
                      return;
                    }

                    Navigator.pop(
                      context,
                    );
                  },
                ),

                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    final userName =
        PreferencesManager
            .instance
            .username;

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "My Profile",
        ),
      ),

      body: SafeArea(
        child:
        SingleChildScrollView(
          padding:
          const EdgeInsets
              .symmetric(
            horizontal: 14,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [
              const SizedBox(
                height: 20,
              ),

              // =================================================
              // Profile Image
              // =================================================

              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,

                      decoration:
                      const BoxDecoration(
                        shape:
                        BoxShape.circle,
                      ),

                      child:
                      ClipOval(
                        child:
                        Image.asset(
                          "assets/images/profile.png",
                          fit:
                          BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      right: 0,
                      bottom: 0,

                      child:
                      Container(
                        width: 32,
                        height: 32,

                        decoration:
                        BoxDecoration(
                          color:
                          theme
                              .cardColor,

                          shape:
                          BoxShape
                              .circle,
                        ),

                        child:
                        Icon(
                          Icons
                              .camera_alt_outlined,

                          color: theme
                              .iconTheme
                              .color,

                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // =================================================
              // User Name
              // =================================================

              Center(
                child: Text(
                  userName,

                  style: theme
                      .textTheme
                      .titleLarge,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Center(
                child: Text(
                  "One task at a time. One step closer.",

                  style: theme
                      .textTheme
                      .bodySmall,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // =================================================
              // Profile Info
              // =================================================

              Text(
                "Profile Info",

                style: theme
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(
                height: 8,
              ),

              // =================================================
              // User Details
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading: const Icon(
                  Icons
                      .person_outline,
                ),

                title:
                const Text(
                  "User Details",
                ),

                trailing:
                const Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 18,
                ),

                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const UserDetailsScreen(),
                    ),
                  );

                  if (mounted) {
                    setState(() {});
                  }
                },
              ),

              const Divider(),

              // =================================================
              // Theme
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading: Icon(
                  ThemeController
                      .instance
                      .isDarkMode
                      ? Icons
                      .dark_mode_outlined
                      : Icons
                      .light_mode_outlined,
                ),

                title: const Text(
                  "Theme",
                ),

                subtitle: Text(
                  ThemeController
                      .instance
                      .isDarkMode
                      ? "Dark"
                      : "Light",
                ),

                trailing:
                const Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 18,
                ),

                onTap:
                _showThemeSheet,
              ),

              const Divider(),

              // =================================================
              // Log Out
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading: const Icon(
                  Icons.logout,
                ),

                title:
                const Text(
                  "Log Out",
                ),

                trailing:
                const Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 18,
                ),

                onTap: () async {
                  await PreferencesManager
                      .instance
                      .logout();

                  if (!mounted) {
                    return;
                  }

                  Navigator
                      .pushAndRemoveUntil(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                      const WelcomeScreen(),
                    ),

                        (route) => false,
                  );
                },
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}