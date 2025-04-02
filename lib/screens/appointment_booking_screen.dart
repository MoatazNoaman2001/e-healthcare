import 'package:doctorapp/screens/appointment_confirmation_screen.dart';
import 'package:flutter/material.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;

  const AppointmentBookingScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
  });

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  DateTime? selectedDate;
  String? selectedTimeSlot;
  String? selectedReason;

  final List<String> timeSlots = ['10:00 AM', '11:00 AM', '2:00 PM', '4:00 PM'];
  final List<String> reasons = ['استشارة', 'متابعة', 'حالة طارئة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('حجز موعد')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الطبيب: ${widget.doctorName}',
                style: const TextStyle(
                  fontSize: 22, // Increased font size
                  fontWeight: FontWeight.w600, // Adjusted font weight
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'التخصص: ${widget.specialty}',
                style: const TextStyle(
                  fontSize: 20, // Increased font size
                  color: Colors.grey,
                ),
              ),
              const Divider(height: 30, thickness: 1),
              const Text(
                'اختر التاريخ:',
                style: TextStyle(
                  fontSize: 20, // Increased font size
                  fontWeight: FontWeight.w600, // Adjusted font weight
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? 'اختر التاريخ'
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  ),
                ),
              ),
              const Divider(height: 30, thickness: 1),
              const Text(
                'اختر الوقت:',
                style: TextStyle(
                  fontSize: 20, // Increased font size
                  fontWeight: FontWeight.w600, // Adjusted font weight
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children:
                    timeSlots.map((slot) {
                      return ChoiceChip(
                        label: Text(slot),
                        selected: selectedTimeSlot == slot,
                        onSelected: (selected) {
                          setState(() {
                            selectedTimeSlot = selected ? slot : null;
                          });
                        },
                      );
                    }).toList(),
              ),
              const Divider(height: 30, thickness: 1),
              const Text(
                'سبب الزيارة:',
                style: TextStyle(
                  fontSize: 20, // Increased font size
                  fontWeight: FontWeight.w600, // Adjusted font weight
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedReason,
                hint: const Text(
                  'اختر السبب',
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size for dropdown hint
                  ),
                ),
                isExpanded: true,
                items:
                    reasons.map((reason) {
                      return DropdownMenuItem(
                        value: reason,
                        child: Text(reason),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed:
                      selectedDate != null &&
                              selectedTimeSlot != null &&
                              selectedReason != null
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AppointmentConfirmationScreen(
                                      doctorName: widget.doctorName,
                                      specialty: widget.specialty,
                                      date: selectedDate!,
                                      timeSlot: selectedTimeSlot!,
                                      reason: selectedReason!,
                                    ),
                              ),
                            );
                          }
                          : () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('خطأ'),
                                    content: const Text(
                                      'يرجى اختيار التاريخ، الوقت، والسبب قبل تأكيد الحجز.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('حسناً'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                  child: const Text(
                    'تأكيد الحجز',
                    style: TextStyle(
                      fontSize: 18, // Adjusted font size for button text
                      fontWeight: FontWeight.w500, // Adjusted font weight
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
