import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const EmailField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email'.tr(),
        prefixIcon: const Icon(Icons.email),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'enter_email'.tr();
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'invalid_email'.tr();
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
