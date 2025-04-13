import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final DateTime? selectedDay;
  final Map<DateTime, List<String>> events;

  const EventsList({
    super.key,
    required this.selectedDay,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final selectedEvents = selectedDay != null ? events[selectedDay] : null;

    if (selectedEvents == null || selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد مواعيد لهذا اليوم',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.teal),
            title: Text(event),
          ),
        );
      },
    );
  }
}
