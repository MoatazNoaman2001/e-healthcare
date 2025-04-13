import 'package:flutter/material.dart';

import '../widgets/appointment_card.dart';

class TodaysScheduleScreen extends StatelessWidget {
  const TodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointments = [
      {
        'patientName': 'محمد أحمد',
        'time': '10:00 AM',
        'type': 'استشارة',
        'status': 'waiting',
      },
      {
        'patientName': 'سارة علي',
        'time': '11:30 AM',
        'type': 'متابعة',
        'status': 'in progress',
      },
      {
        'patientName': 'علي حسن',
        'time': '1:00 PM',
        'type': 'حالة طارئة',
        'status': 'completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('جدول اليوم', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCard(
            patientName: appointment['patientName'],
            time: appointment['time'],
            type: appointment['type'],
            status: appointment['status'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AppointmentDetailsScreen(
                    patientName: appointment['patientName'],
                    appointmentTime: appointment['time'],
                    appointmentType: appointment['type'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
