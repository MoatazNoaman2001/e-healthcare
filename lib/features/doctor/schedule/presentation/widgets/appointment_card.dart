import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String time;
  final String type;
  final String status;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.patientName,
    required this.time,
    required this.type,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    IconData statusIcon;
    Color statusColor;
    String statusText;

    switch (status) {
      case 'waiting':
        statusIcon = Icons.hourglass_empty;
        statusColor = Colors.orange;
        statusText = 'status_waiting'.tr();
        break;
      case 'in progress':
        statusIcon = Icons.play_circle_fill;
        statusColor = Colors.blue;
        statusText = 'status_in_progress'.tr();
        break;
      default:
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        statusText = 'status_completed'.tr();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        title: Text(
          patientName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('${'time'.tr()}: $time', style: const TextStyle(fontSize: 14)),
            Text('${'type'.tr()}: $type', style: const TextStyle(fontSize: 14)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(statusIcon, color: statusColor, size: 28),
            const SizedBox(height: 4),
            Text(statusText, style: const TextStyle(fontSize: 12)),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
