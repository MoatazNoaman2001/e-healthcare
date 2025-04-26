import 'package:doctorapp/features/patient/appointments_booking/presentation/screens/appointment_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../doctor_search/domain/models/doctor_model.dart'; // Import DoctorModel

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as DoctorModel;

    return Scaffold(
      appBar: AppBar(title: Text(doctor.fullName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorHeader(doctor),
            const SizedBox(height: 16),
            _buildRatingRow(doctor.rating),
            const SizedBox(height: 16),
            Text(
              '${'experience'.tr()}: ${doctor.experience != null ? '${doctor.experience} سنوات' : 'غير محددة'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'available_appointments'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildAvailableTimes(),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AppointmentBookingScreen(
                        doctorName: doctor.fullName,
                        specialty: doctor.specialization,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text('book_appointment'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHeader(DoctorModel doctor) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: doctor.imageUrl != null
                ? NetworkImage(doctor.imageUrl!)
                : const AssetImage('assets/doctor_placeholder.png')
                    as ImageProvider,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            doctor.fullName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            doctor.specialization,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow(double? rating) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text('${rating ?? 0.0}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildAvailableTimes() {
    return Wrap(
      spacing: 8,
      children: List.generate(
        5,
        (index) => const Chip(label: Text('10:00 AM')),
      ),
    );
  }
}
