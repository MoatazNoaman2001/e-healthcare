import 'package:flutter/material.dart';

class AppointmentInfoSection extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentType;

  const AppointmentInfoSection({
    super.key,
    required this.patientName,
    required this.appointmentTime,
    required this.appointmentType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المريض: $patientName',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'الوقت: $appointmentTime',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          'النوع: $appointmentType',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class AppointmentNotesInput extends StatelessWidget {
  const AppointmentNotesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'أدخل ملاحظات الموعد هنا...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
