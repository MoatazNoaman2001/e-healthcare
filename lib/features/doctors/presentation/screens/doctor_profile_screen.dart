// lib/features/doctors/presentation/screens/doctor_profile_screen.dart

import 'package:flutter/material.dart';
import '../../../appointments/presentation/screens/appointment_booking_screen.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final double rating;
  final String experience;

  const DoctorProfileScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.rating,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctorName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorHeader(context),
            const SizedBox(height: 16),
            _buildRatingRow(),
            const SizedBox(height: 16),
            Text('الخبرة: $experience', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text(
              'المواعيد المتاحة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        doctorName: doctorName,
                        specialty: specialty,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('احجز موعدًا'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHeader(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/doctor_placeholder.png'),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            doctorName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            specialty,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text('$rating', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildAvailableTimes() {
    // In a real app, make this dynamic or pull from BLoC
    return Wrap(
      spacing: 8,
      children: List.generate(
        5,
        (index) => Chip(label: Text('10:00 AM')),
      ),
    );
  }
}
