import 'package:flutter/material.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        obscureText: !showPassword,
        decoration: InputDecoration(
          labelText: 'تأكيد كلمة المرور',
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'الرجاء تأكيد كلمة المرور';
          if (value != passwordController.text) return 'كلمة المرور غير متطابقة';
          return null;
        },
      ),
    );
  }
}
