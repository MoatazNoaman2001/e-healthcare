import 'package:doctorapp/features/patient/appointments_booking/presentation/screens/appointment_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/appointment_booking_bloc.dart';
import '../bloc/appointment_booking_event.dart';
import '../bloc/appointment_booking_state.dart';


class AppointmentBookingScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;

  const AppointmentBookingScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> timeSlots = ['10:00 AM', '11:00 AM', '2:00 PM', '4:00 PM'];
    final List<String> reasons = ['استشارة', 'متابعة', 'حالة طارئة'];

    return Scaffold(
      appBar: AppBar(title: const Text('حجز موعد')),
      body: BlocProvider(
        create: (_) => AppointmentBookingBloc(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AppointmentBookingBloc, AppointmentBookingState>(
            builder: (context, state) {
              final bloc = context.read<AppointmentBookingBloc>();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الطبيب: $doctorName', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Text('التخصص: $specialty', style: const TextStyle(fontSize: 20, color: Colors.grey)),
                    const Divider(height: 30),

                    const Text('اختر التاريخ:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 30)),
                          );
                          if (pickedDate != null) {
                            bloc.add(SelectDate(pickedDate));
                          }
                        },
                        child: Text(
                          state.selectedDate == null
                              ? 'اختر التاريخ'
                              : '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
                        ),
                      ),
                    ),

                    const Divider(height: 30),
                    const Text('اختر الوقت:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: timeSlots.map((slot) {
                        return ChoiceChip(
                          label: Text(slot),
                          selected: state.selectedTimeSlot == slot,
                          onSelected: (_) => bloc.add(SelectTimeSlot(slot)),
                        );
                      }).toList(),
                    ),

                    const Divider(height: 30),
                    const Text('سبب الزيارة:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: state.selectedReason,
                      hint: const Text('اختر السبب'),
                      isExpanded: true,
                      items: reasons.map((reason) {
                        return DropdownMenuItem(
                          value: reason,
                          child: Text(reason),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) bloc.add(SelectReason(value));
                      },
                    ),

                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: state.isValid
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AppointmentConfirmationScreen(
                                      doctorName: doctorName,
                                      specialty: specialty,
                                      date: state.selectedDate!,
                                      timeSlot: state.selectedTimeSlot!,
                                      reason: state.selectedReason!,
                                    ),
                                  ),
                                );
                              }
                            : () => showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    title: Text('خطأ'),
                                    content: Text('يرجى اختيار التاريخ، الوقت، والسبب قبل تأكيد الحجز.'),
                                  ),
                                ),
                        child: const Text('تأكيد الحجز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
