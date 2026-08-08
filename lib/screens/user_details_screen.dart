import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../core/widgets/custom_text_form_field.dart';

// =========================================================
// User Details Screen
// =========================================================

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() =>
      _UserDetailsScreenState();
}

class _UserDetailsScreenState
    extends State<UserDetailsScreen> {

  final _formKey =
  GlobalKey<FormState>();

  final TextEditingController
  userNameController =
  TextEditingController();

  final TextEditingController
  motivationController =
  TextEditingController(
    text:
    "One task at a time. One step closer.",
  );

  // =========================================================
  // Init
  // =========================================================

  @override
  void initState() {
    super.initState();

    userNameController.text =
        PreferencesManager.instance.username;
  }

  // =========================================================
  // Dispose
  // =========================================================

  @override
  void dispose() {
    userNameController.dispose();
    motivationController.dispose();

    super.dispose();
  }

  // =========================================================
  // Save Changes
  // =========================================================

  Future<void> saveChanges() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    await PreferencesManager.instance
        .saveUsername(
      userNameController.text.trim(),
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "User Details",
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(13),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // User Name
                CustomTextFormField(
                  label: "User Name",

                  controller:
                  userNameController,

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return
                        "Please enter your name";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Motivation Quote
                CustomTextFormField(
                  label: "Motivation Quote",

                  controller:
                  motivationController,

                  maxLines: 5,
                ),

                // نخلي الزر تحت
                // مع مساحة حتى يظل شكله قريب من التصميم
                const SizedBox(height: 210),

                SizedBox(
                  width: double.infinity,
                  height: 42,

                  child: ElevatedButton(
                    onPressed: saveChanges,

                    child: const Text(
                      "Save Changes",
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}