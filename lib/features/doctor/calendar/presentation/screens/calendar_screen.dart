import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/calendar_view.dart';
import '../widgets/events_list.dart';
import '../widgets/calendar_bottom_sheet.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _events = {
    DateTime.now(): ['استشارة - 10:00 AM', 'متابعة - 2:00 PM'],
    DateTime.now().add(const Duration(days: 1)): ['حالة طارئة - 1:00 PM'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calendar'.tr()),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          CalendarView(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            events: _events,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: EventsList(
              selectedDay: _selectedDay,
              events: _events,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => const CalendarBottomSheet(),
          );
        },
        backgroundColor: Colors.teal.shade700,
        child: const Icon(Icons.add),
      ),
    );
  }
}
