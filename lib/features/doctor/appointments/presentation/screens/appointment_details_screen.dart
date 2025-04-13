import 'package:flutter/material.dart';
import '../widgets/appointment_info_section.dart';
import '../widgets/appointment_action_buttons.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentType;

  const AppointmentDetailsScreen({
    super.key,
    required this.patientName,
    required this.appointmentTime,
    required this.appointmentType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الموعد'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppointmentInfoSection(
              patientName: patientName,
              appointmentTime: appointmentTime,
              appointmentType: appointmentType,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ملاحظات الموعد:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const AppointmentNotesInput(),
            const Spacer(),
            const AppointmentActionButtons(),
          ],
        ),
      ),
    );
  }
}

void navigateToAppointmentDetails(
  BuildContext context,
  String patientName,
  String appointmentTime,
  String appointmentType,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AppointmentDetailsScreen(
        patientName: patientName,
        appointmentTime: appointmentTime,
        appointmentType: appointmentType,
      ),
    ),
  );
}
