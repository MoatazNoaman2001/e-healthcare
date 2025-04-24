import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class QualificationCard extends StatelessWidget {
  const QualificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      title: 'qualifications_title'.tr(),
      children: const [
        _QualificationItem(titleKey: 'degree_1', subtitleKey: 'degree_1_sub'),
        _QualificationItem(titleKey: 'degree_2', subtitleKey: 'degree_2_sub'),
        _QualificationItem(titleKey: 'degree_3', subtitleKey: 'degree_3_sub'),
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
  final String titleKey;
  final String subtitleKey;

  const _QualificationItem({required this.titleKey, required this.subtitleKey});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.medical_information, color: Colors.teal),
      title: Text(titleKey.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitleKey.tr(), style: const TextStyle(color: Colors.grey)),
    );
  }
}
