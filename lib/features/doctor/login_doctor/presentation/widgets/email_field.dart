import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: 'البريد الإلكتروني',
          floatingLabelAlignment: FloatingLabelAlignment.start,
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) return 'الرجاء إدخال البريد الإلكتروني';
          if (!value.contains('@')) return 'بريد إلكتروني غير صالح';
          return null;
        },
      ),
    );
  }
}
