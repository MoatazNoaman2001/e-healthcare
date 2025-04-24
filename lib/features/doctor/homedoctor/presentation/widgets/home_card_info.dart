import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeCardInfo extends StatelessWidget {
  const HomeCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          title: 'appointments_today'.tr(),
          value: '5', // Replace with dynamic
          color: Colors.teal,
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'waiting_patients'.tr(),
          value: '3', // Replace with dynamic
          color: Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'next_appointment'.tr(),
          subtitle: '10:30 AM - محمد أحمد', // Replace with dynamic
          isSubtitle: true,
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    String? value,
    String? subtitle,
    Color? color,
    bool isSubtitle = false,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: isSubtitle
            ? null
            : Text(
                value ?? '',
                style: TextStyle(color: color, fontSize: 18),
              ),
        subtitle: isSubtitle
            ? Text(
                subtitle ?? '',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              )
            : null,
      ),
    );
  }
}
