import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
          label: Text('todays_schedule'.tr()),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onCalendarTap,
          icon: const Icon(Icons.calendar_today),
          label: Text('calendar'.tr()),
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
