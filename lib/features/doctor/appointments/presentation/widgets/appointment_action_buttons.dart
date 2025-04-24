import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppointmentActionButtons extends StatelessWidget {
  const AppointmentActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('completed_msg'.tr())),
              );
            },
            icon: const Icon(Icons.check_circle),
            label: Text('complete_appointment'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('rescheduled_msg'.tr())),
              );
            },
            icon: const Icon(Icons.edit_calendar),
            label: Text('reschedule_appointment'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
