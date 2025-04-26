import 'package:doctorapp/features/doctor/doctor_profile/domain/models/doctor_model.dart';
import 'package:flutter/material.dart';


class DoctorInfoHeader extends StatelessWidget {
  final Doctor doctor;

  const DoctorInfoHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: doctor.imageUrl != null
              ? NetworkImage(doctor.imageUrl!)
              : const AssetImage('assets/doctor_placeholder.png') as ImageProvider,
        ),
        const SizedBox(height: 12),
        Text(
          '${doctor.firstName} ${doctor.lastName}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          doctor.specialization,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
