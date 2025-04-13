import 'package:flutter/material.dart';

class HomeActionsRow extends StatelessWidget {
  final VoidCallback onScheduleTap;
  final VoidCallback onCalendarTap;

  const HomeActionsRow({
    super.key,
    required this.onScheduleTap,
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: onScheduleTap,
          icon: const Icon(Icons.schedule),
          label: const Text('جدول اليوم'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onCalendarTap,
          icon: const Icon(Icons.calendar_today),
          label: const Text('التقويم'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
