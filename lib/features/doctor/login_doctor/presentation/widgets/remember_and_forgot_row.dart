import 'package:doctorapp/features/forgot/presentation/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class RememberAndForgotRow extends StatelessWidget {
  final bool remember;
  final ValueChanged<bool?> onChanged;

  const RememberAndForgotRow({
    super.key,
    required this.remember,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: remember, onChanged: onChanged),
            const Text('تذكرني'),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
            );
          },
          child: Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(color: Colors.teal.shade700),
          ),
        ),
      ],
    );
  }
}
