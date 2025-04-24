import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword;
  final VoidCallback onToggle;

  const PasswordField({
    super.key,
    required this.controller,
    required this.showPassword,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        obscureText: !showPassword,
        decoration: InputDecoration(
          labelText: 'password'.tr(),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'enter_password'.tr();
          if (value.length < 6) return 'password_too_short'.tr();
          return null;
        },
      
    );
  }
}
