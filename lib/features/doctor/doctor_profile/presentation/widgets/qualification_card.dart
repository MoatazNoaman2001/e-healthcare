import 'package:flutter/material.dart';

class QualificationCard extends StatelessWidget {
  const QualificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      title: 'التخصص والمؤهلات',
      children: const [
        _QualificationItem(title: 'دكتوراه في الطب الباطني', subtitle: 'جامعة القاهرة - 2015'),
        _QualificationItem(title: 'زمالة الكلية الملكية', subtitle: 'لندن - 2018'),
        _QualificationItem(title: 'بورد أمراض الجهاز الهضمي', subtitle: 'أمريكا - 2020'),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
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
      ),
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
}

class _QualificationItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _QualificationItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.medical_information, color: Colors.teal),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
    );
  }
}
