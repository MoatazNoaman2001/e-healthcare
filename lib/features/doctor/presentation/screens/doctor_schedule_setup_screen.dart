import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorScheduleSetupScreen extends StatefulWidget {
  const DoctorScheduleSetupScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScheduleSetupScreen> createState() => _DoctorScheduleSetupScreenState();
}

class _DoctorScheduleSetupScreenState extends State<DoctorScheduleSetupScreen> {
  // Days of the week
  final List<String> _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  // Selected days
  final Map<String, bool> _selectedDays = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': false,
    'Sunday': false,
  };

  // Time slots for each day
  final Map<String, List<TimeSlot>> _timeSlots = {
    'Monday': [TimeSlot(const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0))],
    'Tuesday': [TimeSlot(const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0))],
    'Wednesday': [TimeSlot(const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0))],
    'Thursday': [TimeSlot(const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0))],
    'Friday': [TimeSlot(const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0))],
    'Saturday': [],
    'Sunday': [],
  };

  // Appointment duration (in minutes)
  int _appointmentDuration = 30;

  // Break time between appointments (in minutes)
  int _breakDuration = 10;

  // Available durations
  final List<int> _availableDurations = [15, 20, 30, 45, 60];
  final List<int> _availableBreaks = [0, 5, 10, 15, 20, 30];

  // Date range for schedule validity
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    // Default end date is 3 months from now
    _endDate = DateTime.now().add(const Duration(days: 90));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Schedule'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              _saveSchedule();
            },
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Schedule name and validity period
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Schedule Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Schedule name
                    TextFormField(
                      initialValue: 'Regular Office Hours',
                      decoration: const InputDecoration(
                        labelText: 'Schedule Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.event_note),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Validity period
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(true),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Start Date',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              child: Text(
                                _startDate != null
                                    ? DateFormat('MMM d, yyyy').format(_startDate!)
                                    : 'Select Date',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(false),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'End Date',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              child: Text(
                                _endDate != null
                                    ? DateFormat('MMM d, yyyy').format(_endDate!)
                                    : 'No End Date',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Appointment settings
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appointment Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Appointment duration
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Appointment Duration',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<int>(
                            value: _appointmentDuration,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down),
                            items: _availableDurations.map((duration) {
                              return DropdownMenuItem<int>(
                                value: duration,
                                child: Text('$duration min'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _appointmentDuration = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Break time
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Break Between Appointments',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<int>(
                            value: _breakDuration,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down),
                            items: _availableBreaks.map((duration) {
                              return DropdownMenuItem<int>(
                                value: duration,
                                child: Text('$duration min'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _breakDuration = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Working days selection
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Working Days',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _weekdays.map((day) {
                        final isSelected = _selectedDays[day] ?? false;
                        return FilterChip(
                          selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                          label: Text(day),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDays[day] = selected;
                              if (selected && (_timeSlots[day]?.isEmpty ?? true)) {
                                _timeSlots[day] = [TimeSlot(const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0))];
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Working hours
            ..._weekdays.where((day) => _selectedDays[day] ?? false).map((day) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day header and add time slot button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          setState(() {
                            _timeSlots[day]?.add(TimeSlot(
                              const TimeOfDay(hour: 9, minute: 0),
                              const TimeOfDay(hour: 17, minute: 0),
                            ));
                          });
                        },
                      ),
                    ],
                  ),

                  // Time slots for the day
                  ..._buildTimeSlots(day),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeSlots(String day) {
    final slots = _timeSlots[day] ?? [];

    return slots.asMap().entries.map((entry) {
      final index = entry.key;
      final slot = entry.value;

      return Card(
        margin: const EdgeInsets.only(top: 8),
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectTime(day, index, true),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Start Time',
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(_formatTimeOfDay(slot.startTime)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, size: 20),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => _selectTime(day, index, false),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'End Time',
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(_formatTimeOfDay(slot.endTime)),
                  ),
                ),
              ),
              if (slots.length > 1)
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      _timeSlots[day]?.removeAt(index);
                    });
                  },
                ),
            ],
          ),
        ),
      );
    }).toList();
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  Future<void> _selectTime(String day, int slotIndex, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? _timeSlots[day]![slotIndex].startTime
          : _timeSlots[day]![slotIndex].endTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _timeSlots[day]![slotIndex].startTime = pickedTime;

          // Ensure end time is after start time
          final startDateTime = DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute);
          final endDateTime = DateTime(1, 1, 1,
              _timeSlots[day]![slotIndex].endTime.hour,
              _timeSlots[day]![slotIndex].endTime.minute
          );

          if (endDateTime.isBefore(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime)) {
            final newEndTime = TimeOfDay(
              hour: (pickedTime.hour + 1) % 24,
              minute: pickedTime.minute,
            );
            _timeSlots[day]![slotIndex].endTime = newEndTime;
          }
        } else {
          _timeSlots[day]![slotIndex].endTime = pickedTime;

          // Ensure start time is before end time
          final startDateTime = DateTime(1, 1, 1,
              _timeSlots[day]![slotIndex].startTime.hour,
              _timeSlots[day]![slotIndex].startTime.minute
          );
          final endDateTime = DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute);

          if (startDateTime.isAfter(endDateTime) || startDateTime.isAtSameMomentAs(endDateTime)) {
            final newStartTime = TimeOfDay(
              hour: (pickedTime.hour - 1) >= 0 ? (pickedTime.hour - 1) : 23,
              minute: pickedTime.minute,
            );
            _timeSlots[day]![slotIndex].startTime = newStartTime;
          }
        }
      });
    }
  }

  Future<void> _selectDate(bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now().add(const Duration(days: 90)),
      firstDate: isStartDate ? DateTime.now() : _startDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          // If end date is before start date, update it
          if (_endDate != null && _endDate!.isBefore(pickedDate)) {
            _endDate = pickedDate.add(const Duration(days: 30));
          }
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _saveSchedule() {
    // Here you would save the schedule data to your BLoC
    // For now, just show a confirmation and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Schedule saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }
}

class TimeSlot {
  TimeOfDay startTime;
  TimeOfDay endTime;

  TimeSlot(this.startTime, this.endTime);
}