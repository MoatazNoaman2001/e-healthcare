import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/appointment.dart';

class PatientCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;

  const PatientCard({
    Key? key,
    required this.appointment,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: const AssetImage('assets/images/patient_avatar.png') as ImageProvider,
        ),
        title: Text(appointment.patientName),
        subtitle: Text(
          appointment.appointmentType,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat('hh:mm a').format(appointment.startTime),
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'confirmed':
      case 'waiting':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'cancelled':
      case 'no_show':
        return Colors.red;
      case 'rescheduled':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      case 'waiting':
        return 'Waiting';
      case 'in_progress':
        return 'In Progress';
      case 'cancelled':
        return 'Cancelled';
      case 'no_show':
        return 'No Show';
      case 'rescheduled':
        return 'Rescheduled';
      default:
        return 'Pending';
    }
  }
}