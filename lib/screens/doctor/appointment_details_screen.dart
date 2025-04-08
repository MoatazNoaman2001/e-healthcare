import 'package:flutter/material.dart';

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
            const SizedBox(height: 16),
            const Text(
              'ملاحظات الموعد:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'أدخل ملاحظات الموعد هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle completing the appointment
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إكمال الموعد')),
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('إكمال الموعد'),
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
                      // Handle rescheduling the appointment
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('إعادة جدولة الموعد')),
                      );
                    },
                    icon: const Icon(Icons.edit_calendar),
                    label: const Text('إعادة الجدولة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
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
      builder:
          (context) => AppointmentDetailsScreen(
            patientName: patientName,
            appointmentTime: appointmentTime,
            appointmentType: appointmentType,
          ),
    ),
  );
}
