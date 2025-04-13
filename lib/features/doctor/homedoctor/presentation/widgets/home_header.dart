import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final DateTime date;

  const HomeHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      'تاريخ اليوم: ${date.day}/${date.month}/${date.year}',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade700,
      ),
    );
  }
}
