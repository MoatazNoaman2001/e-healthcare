import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../calendar/presentation/screens/calendar_screen.dart';
import '../../../doctor_profile/presentation/screens/doctor_profile_screen.dart';
import '../../../schedule/presentation/screens/todays_schedule_screen.dart';
import '../widgets/home_header.dart';
import '../widgets/home_card_info.dart';
import '../widgets/home_actions_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DoctorProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(date: today),
            const SizedBox(height: 24),
            const HomeCardInfo(),
            const SizedBox(height: 24),
            HomeActionsRow(
              onScheduleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TodaysScheduleScreen()),
                );
              },
              onCalendarTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CalendarScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
