import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
          '${'patient'.tr()}: $patientName',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '${'time'.tr()}: $appointmentTime',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          '${'type'.tr()}: $appointmentType',
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
        hintText: 'appointment_notes_hint'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
