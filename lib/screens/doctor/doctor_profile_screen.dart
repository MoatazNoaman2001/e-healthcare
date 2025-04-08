import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي للطبيب'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: const Center(
        child: Text(
          'تفاصيل الملف الشخصي للطبيب',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
