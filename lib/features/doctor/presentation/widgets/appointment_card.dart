import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;
  final bool showActions;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onTap,
    this.showActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(appointment.status, context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: appointment.status == AppointmentStatus.inProgress
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: appointment.status == AppointmentStatus.inProgress ? 2 : 0,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Time badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('hh:mm a').format(appointment.startTime),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Duration
                  Text(
                    '${appointment.endTime.difference(appointment.startTime).inMinutes} min',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),

                  const Spacer(),

                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusInfo.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          statusInfo.icon,
                          size: 14,
                          color: statusInfo.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusInfo.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: statusInfo.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Patient info
              Row(
                children: [
                  // Patient avatar
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade200,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/patient_avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Patient name and appointment type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.patientName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _getAppointmentTypeColor(appointment.appointmentType),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              appointment.appointmentType,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Actions if needed
              if (showActions)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildActionButtons(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    final List<Widget> actions = [];

    // Don't show actions for completed or cancelled appointments
    if (appointment.status == AppointmentStatus.completed ||
        appointment.status == AppointmentStatus.cancelled ||
        appointment.status == AppointmentStatus.noShow) {
      return actions;
    }

    // Message button
    actions.add(
      IconButton(
        icon: Icon(
          Icons.message_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          // Message action
        },
      ),
    );

    // Different buttons based on status
    if (appointment.status == AppointmentStatus.confirmed ||
        appointment.status == AppointmentStatus.inProgress) {
      // Start button
      actions.add(
        ElevatedButton.icon(
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            // Start appointment
          },
        ),
      );
    } else if (appointment.status == AppointmentStatus.inProgress) {
      // Complete button
      actions.add(
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: const Text('Complete'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            // Complete appointment
          },
        ),
      );
    }

    return actions;
  }

  Color _getAppointmentTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'check-up':
      case 'checkup':
        return Colors.blue;
      case 'follow-up':
      case 'followup':
        return Colors.green;
      case 'consultation':
        return Colors.purple;
      case 'new patient':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  StatusInfo _getStatusInfo(AppointmentStatus status, BuildContext context) {
    switch (status) {
      case AppointmentStatus.completed:
        return StatusInfo(
          text: 'Completed',
          color: Colors.green,
          icon: Icons.check_circle,
        );
      case AppointmentStatus.confirmed:
        return StatusInfo(
          text: 'Confirmed',
          color: Colors.blue,
          icon: Icons.check,
        );
      // case AppointmentStatus.waiting:
      //   return StatusInfo(
      //     text: 'Waiting',
      //     color: Colors.orange,
      //     icon: Icons.access_time,
      //   );
      case AppointmentStatus.inProgress:
        return StatusInfo(
          text: 'In Progress',
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.play_circle,
        );
      case AppointmentStatus.cancelled:
        return StatusInfo(
          text: 'Cancelled',
          color: Colors.red,
          icon: Icons.cancel,
        );
      case AppointmentStatus.noShow:
        return StatusInfo(
          text: 'No Show',
          color: Colors.red,
          icon: Icons.person_off,
        );
      case AppointmentStatus.rescheduled:
        return StatusInfo(
          text: 'Rescheduled',
          color: Colors.purple,
          icon: Icons.event_repeat,
        );
      default:
        return StatusInfo(
          text: 'Pending',
          color: Colors.grey,
          icon: Icons.pending,
        );
    }
  }
}

class StatusInfo {
  final String text;
  final Color color;
  final IconData icon;

  StatusInfo({
    required this.text,
    required this.color,
    required this.icon,
  });
}