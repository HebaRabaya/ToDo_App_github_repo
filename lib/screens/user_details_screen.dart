// =========================================================
// User Details Screen
// =========================================================
//
// هاي الشاشة مسؤولة عن تعديل معلومات المستخدم.
//
// المستخدم بقدر من هون:
// - يعدل اسمه
// - يحفظ التعديل
//
// البيانات بتنحفظ عن طريق PreferencesManager
// وبما إنه مربوط مع Provider، الاسم بتحدث بباقي التطبيق.
// =========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/preferences_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
  });

  @override
  State<UserDetailsScreen> createState() =>
      _UserDetailsScreenState();
}

class _UserDetailsScreenState
    extends State<UserDetailsScreen> {

  // =========================================================
  // Controller
  // =========================================================

  late TextEditingController _nameController;

  // =========================================================
  // Init
  // =========================================================

  @override
  void initState() {
    super.initState();

    final manager =
        PreferencesManager.instance;

    // بنحط الاسم المحفوظ داخل TextField
    _nameController =
        TextEditingController(
          text: manager.username,
        );
  }

  // =========================================================
  // Dispose
  // =========================================================

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  // =========================================================
  // Save Changes
  // =========================================================

  Future<void> _saveChanges() async {
    final name =
    _nameController.text.trim();

    // إذا الاسم فاضي
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter your name",
          ),
        ),
      );

      return;
    }

    // حفظ الاسم
    await context
        .read<PreferencesManager>()
        .saveUsername(name);

    if (!mounted) return;

    // رسالة نجاح
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "User details updated successfully",
        ),
      ),
    );

    // نرجع للـ Profile
    Navigator.pop(context);
  }

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "User Details",
        ),
      ),

      body: ListView(
        padding:
        const EdgeInsets.all(20),

        children: [

          // ===================================================
          // Profile Image
          // ===================================================

          Center(
            child: Container(
              width: 90,
              height: 90,

              decoration:
              BoxDecoration(
                borderRadius:
                BorderRadius.circular(
                  20,
                ),

                border: Border.all(
                  color:
                  const Color(
                    0xFF9747FF,
                  ),
                  width: 2,
                ),
              ),

              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(
                  18,
                ),

                child: Image.asset(
                  "assets/images/profile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // ===================================================
          // Title
          // ===================================================

          Text(
            "Personal Information",
            style: theme
                .textTheme
                .titleMedium
                ?.copyWith(
              fontWeight:
              FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // ===================================================
          // Full Name
          // ===================================================

          Text(
            "Full Name",
            style: theme
                .textTheme
                .bodySmall,
          ),

          const SizedBox(
            height: 8,
          ),

          TextField(
            controller:
            _nameController,

            textInputAction:
            TextInputAction.done,

            decoration:
            InputDecoration(
              hintText:
              "Enter your full name",

              prefixIcon:
              const Icon(
                Icons.person_outline,
              ),

              filled: true,

              fillColor:
              theme.cardColor,

              border:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                  12,
                ),

                borderSide:
                BorderSide.none,
              ),

              enabledBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                  12,
                ),

                borderSide:
                BorderSide.none,
              ),

              focusedBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                  12,
                ),

                borderSide:
                const BorderSide(
                  color:
                  Color(0xFF52C070),
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // ===================================================
          // Save Button
          // ===================================================

          SizedBox(
            width:
            double.infinity,

            height: 50,

            child:
            ElevatedButton.icon(
              onPressed:
              _saveChanges,

              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),

              label: const Text(
                "Save Changes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                const Color(
                  0xFF52C070,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}