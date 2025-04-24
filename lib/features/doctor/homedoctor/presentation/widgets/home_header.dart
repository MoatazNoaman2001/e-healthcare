import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeHeader extends StatelessWidget {
  final DateTime date;

  const HomeHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${'today_date'.tr()}: ${date.day}/${date.month}/${date.year}',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade700,
      ),
    );
  }
}
