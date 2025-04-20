import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/home_bloc.dart';

class RecentDoctors extends StatelessWidget {
  const RecentDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isPastAppointmentsLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('الأطباء الذين زرتهم مؤخرًا',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

        if (state.pastAppointmentsError != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('الأطباء الذين زرتهم مؤخرًا',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('خطأ: ${state.pastAppointmentsError}'),
                ),
              ),
            ],
          );
        }

        if (state.pastAppointments.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('الأطباء الذين زرتهم مؤخرًا',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('لم تقم بزيارة أي طبيب بعد'),
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('الأطباء الذين زرتهم مؤخرًا',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...state.pastAppointments.take(3).map((appointment) {
              String formattedDate = DateFormat('yyyy/MM/dd', 'ar')
                  .format(appointment.scheduledDateTime);

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(Icons.person, color: Colors.green),
                ),
                title: Text(appointment.doctorName ?? 'طبيب'),
                subtitle: Row(
                  children: [
                    Flexible(child: Text(appointment.specialization ?? 'تخصص')),
                    const SizedBox(width: 8),
                    Text(formattedDate),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to doctor details
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }
}