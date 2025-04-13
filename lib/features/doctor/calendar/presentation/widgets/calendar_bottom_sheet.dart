import 'package:flutter/material.dart';

class CalendarBottomSheet extends StatelessWidget {
  const CalendarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.add, color: Colors.teal),
            title: const Text('إضافة وقت غير متاح'),
            onTap: () {
              // إضافة وقت غير متاح
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_calendar, color: Colors.teal),
            title: const Text('إعادة جدولة موعد'),
            onTap: () {
              // إعادة جدولة
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
