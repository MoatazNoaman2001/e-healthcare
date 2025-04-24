import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
            Checkbox(
              value: remember,
              onChanged: onChanged,
            ),
            Text('remember_me'.tr()),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/ForgotPassword');
          },
          child: Text('forgot_password'.tr()),
        ),
      ],
    );
  }
}
