import 'package:doctorapp/features/patient/appointments_booking/presentation/screens/appointment_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
      appBar: AppBar(
        title: Text('book_appointment'.tr()),
        centerTitle: true,
      ),
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
                    _sectionTitle('${'doctor'.tr()}: $doctorName', size: 22),
                    const SizedBox(height: 8),
                    Text(
                      '${'specialty'.tr()}: $specialty',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(height: 32, thickness: 1.2),

                    _sectionTitle('choose_date'.tr()),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
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
                        icon: const Icon(Icons.date_range),
                        label: Text(
                          state.selectedDate == null
                              ? 'select_date'.tr()
                              : '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          backgroundColor: Colors.teal.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    const Divider(height: 32, thickness: 1.2),
                    _sectionTitle('choose_time'.tr()),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: timeSlots.map((slot) {
                        return ChoiceChip(
                          label: Text(slot),
                          selected: state.selectedTimeSlot == slot,
                          onSelected: (_) => bloc.add(SelectTimeSlot(slot)),
                          selectedColor: Colors.teal.shade300,
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: state.selectedTimeSlot == slot ? Colors.white : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),

                    const Divider(height: 32, thickness: 1.2),
                    _sectionTitle('visit_reason'.tr()),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButton<String>(
                        value: state.selectedReason,
                        hint: Text('select_reason'.tr()),
                        isExpanded: true,
                        underline: const SizedBox(),
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
                    ),

                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
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
                                    builder: (_) => AlertDialog(
                                      title: Text('booking_error'.tr()),
                                      content: Text('booking_error_msg'.tr()),
                                    ),
                                  ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.teal.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'confirm_booking'.tr(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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

  Widget _sectionTitle(String title, {double size = 20}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
