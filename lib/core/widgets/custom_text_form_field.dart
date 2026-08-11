import 'package:flutter/material.dart';

// =========================================================
// Custom Text Form Field
// =========================================================
//
// هذا Widget بنستخدمه لما نحتاج TextFormField
// بشكل مرتب وموحد.
//
// بدل ما نكرر نفس إعدادات الـ TextField
// بكل شاشة، بنعمل Widget واحد ونستخدمه.
//
// =========================================================

class CustomTextFormField
    extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  final String? labelText;

  final String? Function(String?)? validator;

  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    return TextFormField(
      controller: controller,

      validator: validator,

      maxLines: maxLines,

      style:
      theme.textTheme.bodyMedium,

      decoration:
      InputDecoration(
        hintText: hintText,

        labelText: labelText,
      ),
    );
  }
}