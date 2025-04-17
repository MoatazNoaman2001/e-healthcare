import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.medical_services_rounded, size: 80, color: Colors.blue),
        const SizedBox(height: 16),
        Text(
          'مرحباً بك',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'تسجيل الدخول كطبيب',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
