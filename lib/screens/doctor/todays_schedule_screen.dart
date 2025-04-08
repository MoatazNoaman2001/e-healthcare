import 'package:doctorapp/screens/doctor/appointment_details_screen.dart'
    as details;
import 'package:flutter/material.dart';

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
        title: const Text(
          'جدول اليوم',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    title: Text(
                      appointment['patientName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'الوقت: ${appointment['time']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'النوع: ${appointment['type']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          appointment['status'] == 'waiting'
                              ? Icons.hourglass_empty
                              : appointment['status'] == 'in progress'
                              ? Icons.play_circle_fill
                              : Icons.check_circle,
                          color:
                              appointment['status'] == 'waiting'
                                  ? Colors.orange
                                  : appointment['status'] == 'in progress'
                                  ? Colors.blue
                                  : Colors.green,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          appointment['status'] == 'waiting'
                              ? 'منتظر'
                              : appointment['status'] == 'in progress'
                              ? 'قيد التنفيذ'
                              : 'مكتمل',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => details.AppointmentDetailsScreen(
                                patientName: appointment['patientName'],
                                appointmentTime: appointment['time'],
                                appointmentType: appointment['type'],
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
