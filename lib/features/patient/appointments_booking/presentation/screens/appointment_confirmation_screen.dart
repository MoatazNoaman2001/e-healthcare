// lib/features/appointments/presentation/screens/appointment_confirmation_screen.dart

import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('تأكيد الموعد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "!تم بنجاح",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'تم حجز موعدك بنجاح.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            const Text(
              'التفاصيل:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 15),
            _infoText('الطبيب: $doctorName'),
            _infoText('التخصص: $specialty'),
            _infoText('التاريخ: ${date.day}/${date.month}/${date.year}'),
            _infoText('الوقت: $timeSlot'),
            _infoText('السبب: $reason'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add to calendar logic here
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('إضافة إلى التقويم'),
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
                  child: const Text('العودة إلى الصفحة الرئيسية'),
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
