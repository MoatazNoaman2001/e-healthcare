import 'package:flutter/material.dart';

class DoctorLoginScreen extends StatelessWidget {
  const DoctorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل دخول الطبيب')),
      body: Center(
        child: Text(
          'شاشة تسجيل دخول الطبيب',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
