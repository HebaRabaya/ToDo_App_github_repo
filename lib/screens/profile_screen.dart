// =========================================================
// Profile Screen
// =========================================================
//
// هاي الشاشة مسؤولة عن إعدادات المستخدم.
//
// بتعرض:
// - معلومات المستخدم
// - User Details
// - Dark Mode
// - Logout
//
// Provider مسؤول عن جلب البيانات
// وتحديث الشاشة عند تغييرها.
//
// =========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/preferences_manager.dart';
import '../core/theme/theme_controller.dart';
import 'user_details_screen.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  // =======================================================
  // Open User Details
  // =======================================================

  Future<void> _openUserDetails(
      BuildContext context,
      ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const UserDetailsScreen(),
      ),
    );
  }

  // =======================================================
  // Logout
  // =======================================================

  Future<void> _logout(
      BuildContext context,
      ) async {
    final shouldLogout =
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final theme =
        Theme.of(dialogContext);

        return AlertDialog(
          backgroundColor:
          theme.cardColor,

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              18,
            ),
          ),

          title: const Text(
            "Logout?",
          ),

          content: const Text(
            "Are you sure you want to logout?",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                "Logout",
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) {
      return;
    }

    await context
        .read<PreferencesManager>()
        .logout();

    if (!context.mounted) return;

    // بنرجع لشاشة Welcome
    // وبنمسح الشاشات القديمة من الـ navigation stack.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const WelcomeScreen(),
      ),
          (route) => false,
    );
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    return Consumer2<
        PreferencesManager,
        ThemeController>(
      builder: (
          context,
          manager,
          themeController,
          child,
          ) {
        final theme =
        Theme.of(context);

        final isDark =
            themeController.themeMode ==
                ThemeMode.dark;

        final displayName =
        manager.username.isEmpty
            ? "User"
            : manager.username;

        return Scaffold(
          backgroundColor:
          theme.scaffoldBackgroundColor,

          // =================================================
          // App Bar
          // =================================================

          appBar: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),

          // =================================================
          // Body
          // =================================================

          body: ListView(
            padding:
            const EdgeInsets.all(
              15,
            ),

            children: [
              // =================================================
              // User Information Card
              // =================================================

              Container(
                padding:
                const EdgeInsets.all(
                  17,
                ),

                decoration:
                BoxDecoration(
                  color:
                  theme.cardColor,

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  border:
                  Border.all(
                    color: theme
                        .dividerColor
                        .withValues(
                      alpha: 0.15,
                    ),
                  ),
                ),

                child: Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 60,
                      height: 60,

                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                          14,
                        ),

                        border:
                        Border.all(
                          color:
                          const Color(
                            0xFF9747FF,
                          ),
                          width: 2,
                        ),
                      ),

                      child:
                      ClipRRect(
                        borderRadius:
                        BorderRadius
                            .circular(
                          12,
                        ),

                        child:
                        Image.asset(
                          "assets/images/profile.png",
                          fit:
                          BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 13,
                    ),

                    // User Name
                    Expanded(
                      child:
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          Text(
                            displayName,

                            maxLines: 1,

                            overflow:
                            TextOverflow
                                .ellipsis,

                            style: theme
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight:
                              FontWeight
                                  .w600,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          Text(
                            "Tasky User",

                            style: theme
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // =================================================
              // Account Section
              // =================================================

              Text(
                "Account",
                style: theme
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // User Details
              ListTile(
                tileColor:
                theme.cardColor,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),

                leading:
                const Icon(
                  Icons.person_outline,
                ),

                title:
                const Text(
                  "User Details",
                ),

                subtitle:
                const Text(
                  "Update your information",
                ),

                trailing:
                const Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 15,
                ),

                onTap: () =>
                    _openUserDetails(
                      context,
                    ),
              ),

              const SizedBox(
                height: 10,
              ),

              // =================================================
              // Appearance Section
              // =================================================

              Text(
                "Appearance",
                style: theme
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              SwitchListTile(
                tileColor:
                theme.cardColor,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),

                secondary:
                const Icon(
                  Icons
                      .dark_mode_outlined,
                ),

                title:
                const Text(
                  "Dark Mode",
                ),

                subtitle:
                Text(
                  isDark
                      ? "Dark theme is enabled"
                      : "Light theme is enabled",
                ),

                value:
                isDark,

                onChanged:
                    (value) {
                  themeController
                      .setTheme(
                    value
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  );
                },
              ),

              const SizedBox(
                height: 18,
              ),

              // =================================================
              // Logout
              // =================================================

              Text(
                "Account Actions",
                style: theme
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              ListTile(
                tileColor:
                theme.cardColor,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),

                leading:
                const Icon(
                  Icons.logout_rounded,
                ),

                title:
                const Text(
                  "Logout",
                ),

                subtitle:
                const Text(
                  "Sign out of your account",
                ),

                onTap: () =>
                    _logout(context),
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}