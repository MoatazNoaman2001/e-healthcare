import 'package:flutter/material.dart';

class HomeCardInfo extends StatelessWidget {
  const HomeCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          title: 'عدد المواعيد اليوم',
          value: '5', // Replace with dynamic
          color: Colors.teal,
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'عدد المرضى المنتظرين',
          value: '3', // Replace with dynamic
          color: Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'الموعد القادم',
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
