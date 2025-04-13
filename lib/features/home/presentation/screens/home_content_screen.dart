// lib/features/home/presentation/screens/home_content_screen.dart

import 'package:flutter/material.dart';
import '../widgets/specialty_chips.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(context),
          const SizedBox(height: 16),
          const Text('التخصصات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const SpecialtyChips(),
          const SizedBox(height: 16),
          _buildNextAppointmentCard(),
          const SizedBox(height: 16),
          _buildRecentDoctors(),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'ابحث عن طبيب، تخصص، أو مرض...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNextAppointmentCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('موعدك القادم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.calendar_today, color: Colors.blue),
            ),
            title: const Text('د. أحمد علي'),
            subtitle: const Text('طبيب قلب - 12:00 مساءً'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentDoctors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('الأطباء الذين زرتهم مؤخرًا', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...List.generate(3, (index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: const Icon(Icons.person, color: Colors.green),
            ),
            title: Text('د. طبيب ${index + 1}'),
            subtitle: const Text('تخصص طبي'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          );
        }),
      ],
    );
  }
}
