import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final bool showPassword;
  final VoidCallback onToggle;

  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
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
          labelText: 'confirm_password'.tr(),
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'please_confirm_password'.tr();
          if (value != passwordController.text) return 'passwords_not_match'.tr();
          return null;
        },
   
    );
  }
}
