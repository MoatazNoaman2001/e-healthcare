import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'register_title'.tr(),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade700,
      ),
      textAlign: TextAlign.center,
    );
  }
}
