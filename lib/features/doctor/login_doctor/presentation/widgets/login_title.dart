import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.medical_services_rounded, size: 80, color: Colors.blue),
        const SizedBox(height: 16),
        Text(
          'welcome'.tr(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'doctor_login'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
