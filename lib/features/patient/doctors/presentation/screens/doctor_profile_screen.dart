import 'dart:ffi';

import 'package:doctorapp/features/doctor/presentation/screens/doctor_profile.dart';
import 'package:doctorapp/features/patient/appointments_booking/presentation/screens/appointment_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../doctor/data/models/doctor_model.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as DoctorModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.fullName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorHeader(doctor),
            const SizedBox(height: 24),
            _buildRatingRow(double.tryParse(doctor.rating??"0")),
            const SizedBox(height: 16),
            _buildExperienceRow(doctor.yearsOfExperience),
            const SizedBox(height: 24),
            Text(
              'available_appointments'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildAvailableTimes(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AppointmentBookingScreen(
                        doctorName: doctor.fullName,
                        specialty: doctor.specialization??"",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_today,color: Colors.white,),
                label: Text('book_appointment'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            backgroundColor: Colors.blue.shade100,
            backgroundImage:
            doctor.profilePicture != null
                ? NetworkImage(doctor.profilePicture!)
                :
            const AssetImage('assets/doctor_placeholder.png') as ImageProvider,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            doctor.fullName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            doctor.specialization?? "",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow(double? rating) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 24),
        const SizedBox(width: 6),
        Text(
          '${rating?.toStringAsFixed(1) ?? '0.0'}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildExperienceRow(int? experience) {
    return Row(
      children: [
        const Icon(Icons.work, color: Colors.grey, size: 24),
        const SizedBox(width: 6),
        Text(
          '${'experience'.tr()}: ${experience != null && experience > 0 ? '$experience سنوات' : 'غير محددة'}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildAvailableTimes() {
    final List<String> times = ['10:00 AM', '11:00 AM', '2:00 PM', '4:00 PM', '5:30 PM'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: times.map((time) {
        return Chip(
          label: Text(time),
          backgroundColor: Colors.teal.shade100,
          labelStyle: const TextStyle(color: Colors.black),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }
}
