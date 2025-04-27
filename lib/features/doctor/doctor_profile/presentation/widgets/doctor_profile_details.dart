import 'package:doctorapp/features/doctor/doctor_profile/domain/models/doctor_model.dart';
import 'package:flutter/material.dart';


class DoctorProfileDetails extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfileDetails({super.key, required this.doctor});

  Widget buildInfoCard({required IconData icon, required String title, required String value}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5, // ظل خفيف جدًا
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.teal.shade400, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100, // خلفية هادئة جدًا
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 52,
                backgroundImage: doctor.imageUrl != null
                    ? NetworkImage(doctor.imageUrl!)
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${doctor.firstName} ${doctor.lastName}'.trim().isNotEmpty
                  ? '${doctor.firstName} ${doctor.lastName}'
                  : 'اسم الطبيب غير متوفر',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildInfoCard(
                    icon: Icons.medical_services_outlined,
                    title: 'التخصص',
                    value: doctor.specialization.isNotEmpty ? doctor.specialization : 'غير محدد',
                  ),
                  buildInfoCard(
                    icon: Icons.email_outlined,
                    title: 'البريد الإلكتروني',
                    value: doctor.email.isNotEmpty ? doctor.email : 'غير متوفر',
                  ),
                  buildInfoCard(
                    icon: Icons.phone_outlined,
                    title: 'رقم الهاتف',
                    value: doctor.phone ?? 'غير متوفر',
                  ),
                  buildInfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'الموقع',
                    value: 'لم يتم تحديد الموقع بعد',
                  ),
                  buildInfoCard(
                    icon: Icons.access_time_outlined,
                    title: 'ساعات العمل',
                    value: 'لم يتم تحديد ساعات العمل بعد',
                  ),
                  buildInfoCard(
                    icon: Icons.school_outlined,
                    title: 'التعليم',
                    value: doctor.bio ?? 'لا توجد بيانات تعليمية متوفرة',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
