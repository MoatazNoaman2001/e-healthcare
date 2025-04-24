import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final DateTime date;
  final String timeSlot;
  final String reason;

  const AppointmentConfirmationScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.timeSlot,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('confirmation_title'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'success_title'.tr(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'success_message'.tr(),
                style: const TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'details'.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 15),
            _infoText('${'doctor'.tr()}: $doctorName'),
            _infoText('${'specialty'.tr()}: $specialty'),
            _infoText('${'date'.tr()}: ${date.day}/${date.month}/${date.year}'),
            _infoText('${'time'.tr()}: $timeSlot'),
            _infoText('${'reason'.tr()}: $reason'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add to calendar logic here
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text('add_to_calendar'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text('back_home'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
    );
  }
}
