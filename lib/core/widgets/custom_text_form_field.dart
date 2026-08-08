import 'package:flutter/material.dart';

// =========================================================
// Custom Text Form Field
// =========================================================

// Shared Widget
// بنستخدمه بأكثر من شاشة بدل ما نكرر نفس TextFormField
class CustomTextFormField extends StatelessWidget {

  final String label;

  final String? initialValue;

  final String? hintText;

  final int maxLines;

  final TextEditingController? controller;

  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,

    required this.label,

    this.initialValue,

    this.hintText,

    this.maxLines = 1,

    this.controller,

    this.validator,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          label,

          style:
          Theme.of(context)
              .textTheme
              .bodyMedium,
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,

          initialValue:
          controller == null
              ? initialValue
              : null,

          maxLines: maxLines,

          validator: validator,

          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}