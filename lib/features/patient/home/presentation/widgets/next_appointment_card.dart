import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/home_bloc.dart';

class NextAppointmentCard extends StatelessWidget {
  const NextAppointmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isUpcomingAppointmentsLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('موعدك القادم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }

        if (state.upcomingAppointmentsError != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('موعدك القادم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('خطأ: ${state.upcomingAppointmentsError}'),
                ),
              ),
            ],
          );
        }

        if (state.upcomingAppointments.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('موعدك القادم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.event_busy, color: Colors.white),
                  ),
                  title: Text('لا توجد مواعيد قادمة'),
                  subtitle: Text('يمكنك حجز موعد جديد'),
                ),
              ),
            ],
          );
        }

        final nextAppointment = state.upcomingAppointments.first;
        final formattedTime = DateFormat('yyyy/MM/dd - hh:mm a', 'ar').format(nextAppointment.scheduledDateTime);

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
                title: Text(nextAppointment.doctorName ?? 'طبيب'),
                subtitle: Text('${nextAppointment.specialization ?? 'تخصص'} - $formattedTime'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to appointment details
                },
              ),
            ),
          ],
        );
      },
    );
  }
}