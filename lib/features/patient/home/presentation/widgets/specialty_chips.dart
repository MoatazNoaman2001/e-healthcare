// lib/features/home/presentation/widgets/specialty_chips.dart

import 'package:flutter/material.dart';

class SpecialtyChips extends StatelessWidget {
  const SpecialtyChips({super.key});

  @override
  Widget build(BuildContext context) {
    final specialties = [
      {'name': 'قلب', 'color': Colors.red.shade400},
      {'name': 'أسنان', 'color': Colors.blue.shade400},
      {'name': 'عظام', 'color': Colors.green.shade400},
      {'name': 'أطفال', 'color': Colors.orange.shade400},
      {'name': 'نساء وتوليد', 'color': Colors.purple.shade400},
      {'name': 'جلدية', 'color': Colors.amber.shade400},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: specialties.map((spec) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Chip(
              label: Text(spec['name'].toString()),
              backgroundColor: (spec['color'] as Color).withOpacity(0.1),
              labelStyle: TextStyle(color: spec['color']as Color),
            ),
          );
        }).toList(),
      ),
    );
  }
}
