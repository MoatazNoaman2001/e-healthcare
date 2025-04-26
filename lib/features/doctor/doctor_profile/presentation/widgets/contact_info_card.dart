import 'package:doctorapp/features/doctor/doctor_profile/domain/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key, required Doctor doctor});

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      title: 'contact_info'.tr(),
      children: [
        const _InfoRow(icon: Icons.phone, text: '0123456789'),
        const _InfoRow(icon: Icons.email, text: 'doctor@example.com'),
        _InfoRow(icon: Icons.location_on, text: 'location'.tr()),
        _InfoRow(icon: Icons.access_time, text: 'working_hours'.tr()),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
