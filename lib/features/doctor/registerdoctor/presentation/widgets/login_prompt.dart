import 'package:doctorapp/features/doctor/login_doctor/presentation/screens/login_screen_doctor.dart';
import 'package:flutter/material.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('لديك حساب بالفعل؟'),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreenDoctor()),
            );
          },
          child: Text(
            ' سجل الدخول',
            style: TextStyle(
              color: Colors.teal.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
