import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import 'user_details_screen.dart';
import 'welcome_screen.dart';

// =========================================================
// Profile Screen
// =========================================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final userName =
        PreferencesManager.instance.username;

    final isDarkMode =
        PreferencesManager.instance.isDarkMode;

    return Scaffold(

      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "My Profile",
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 14,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

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
                        shape: BoxShape.circle,
                      ),

                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      right: 0,
                      bottom: 0,

                      child: Container(
                        width: 32,
                        height: 32,

                        decoration:
                        BoxDecoration(
                          color:
                          theme.cardColor,
                          shape:
                          BoxShape.circle,
                        ),

                        child: Icon(
                          Icons
                              .camera_alt_outlined,

                          color:
                          theme
                              .iconTheme
                              .color,

                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // =================================================
              // User Name
              // =================================================

              Center(
                child: Text(
                  userName,

                  style:
                  theme
                      .textTheme
                      .titleLarge,
                ),
              ),

              const SizedBox(height: 3),

              Center(
                child: Text(
                  "One task at a time. One step closer.",

                  style:
                  theme
                      .textTheme
                      .bodySmall,
                ),
              ),

              const SizedBox(height: 24),

              // =================================================
              // Profile Info
              // =================================================

              Text(
                "Profile Info",

                style:
                theme
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(height: 8),

              // =================================================
              // User Details
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading: const Icon(
                  Icons.person_outline,
                ),

                title: const Text(
                  "User Details",
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
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

                  // بعد الرجوع
                  // بنعيد بناء الصفحة عشان الاسم يتحدث
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),

              const Divider(),

              // =================================================
              // Dark Mode
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading: const Icon(
                  Icons.nightlight_outlined,
                ),

                title: const Text(
                  "Dark Mode",
                ),

                trailing: Switch(
                  value: isDarkMode,

                  onChanged: (value) async {

                    await PreferencesManager
                        .instance
                        .saveDarkMode(value);

                    if (mounted) {
                      setState(() {});
                    }
                  },

                  activeColor:
                  Colors.white,

                  activeTrackColor:
                  const Color(
                    0xFF20C477,
                  ),
                ),
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

                title: const Text(
                  "Log Out",
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),

                onTap: () async {

                  // نمسح اسم المستخدم
                  await PreferencesManager
                      .instance
                      .logout();

                  if (!mounted) return;

                  // نرجع على Welcome
                  // ونحذف كل الصفحات السابقة
                  Navigator.pushAndRemoveUntil(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                      const WelcomeScreen(),
                    ),

                        (route) => false,
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}