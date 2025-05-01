import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/auth/auth_service.dart';
import '../../../../core/di/dependancy_injection.dart';
import '../../domain/entities/appointment.dart';
import '../bloc/appointment/appointments_bloc.dart';

class DoctorScheduleScreen extends StatefulWidget {
  const DoctorScheduleScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  late DateTime _selectedDate;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadAppointmentsForDate(_selectedDate);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadAppointmentsForDate(DateTime date) {
    final authService = sl<AuthService>();
    final doctorId = authService.currentUserId.toString();
    context.read<AppointmentBloc>().add(GetAppointmentsEvent(doctorId: doctorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('EEEE, MMMM d').format(_selectedDate),
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => _showDatePicker(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Date selection row
          _buildDateSelector(),

          // Appointment summary
          _buildAppointmentSummary(),

          // Appointment timeline
          Expanded(
            child: BlocBuilder<AppointmentBloc, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentsLoaded) {
                  return _buildAppointmentTimeline(state.appointments);
                } else if (state is AppointmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AppointmentError) {
                  return Center(
                    child: Text('Error: ${state.failure}'),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show bottom sheet for adding new appointment
          _showAddAppointmentBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14, // Two weeks
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index - 3));
          final isSelected = DateUtils.isSameDay(date, _selectedDate);
          final isToday = DateUtils.isSameDay(date, DateTime.now());

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              _loadAppointmentsForDate(date);
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : isToday
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: isToday && !isSelected
                    ? Border.all(color: Theme.of(context).colorScheme.primary)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isToday
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? Colors.white.withOpacity(0.3)
                          : isToday && !isSelected
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isToday
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          int total = 0;
          int waiting = 0;
          int completed = 0;
          int cancelled = 0;

          if (state is TodayAppointmentsLoaded) {
            total = state.appointments.length;
            waiting = state.appointments.where((a) =>
            a.status == AppointmentStatus.completed ||
                a.status == AppointmentStatus.scheduled ||
                a.status == AppointmentStatus.inProgress
            ).length;
            completed = state.appointments.where((a) =>
            a.status == AppointmentStatus.completed
            ).length;
            cancelled = state.appointments.where((a) =>
            a.status == AppointmentStatus.cancelled ||
                a.status == AppointmentStatus.cancelled
            ).length;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                'Total',
                total.toString(),
                Theme.of(context).colorScheme.primary,
              ),
              _buildSummaryItem(
                'Active',
                waiting.toString(),
                Theme.of(context).colorScheme.tertiary,
              ),
              _buildSummaryItem(
                'Completed',
                completed.toString(),
                Colors.green,
              ),
              _buildSummaryItem(
                'Cancelled',
                cancelled.toString(),
                Colors.red,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryItem(String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            count,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentTimeline(List<Appointment> appointments) {
    // Sort appointments by start time
    final sortedAppointments = List<Appointment>.from(appointments);
    sortedAppointments.sort((a, b) => a.startTime.compareTo(b.startTime));

    // Create time slots from 8 AM to 8 PM (12 hours)
    final List<DateTime> timeSlots = [];
    final startTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, 8);
    for (int i = 0; i < 13; i++) {
      timeSlots.add(startTime.add(Duration(hours: i)));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final timeSlot = timeSlots[index];
        final hour = timeSlot.hour;

        // Find appointments that start in this hour
        final hourAppointments = sortedAppointments.where((appointment) =>
        appointment.startTime.hour == hour
        ).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time label
            Row(
              children: [
                Container(
                  width: 60,
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    DateFormat('h a').format(timeSlot),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),
              ],
            ),

            // Appointments for this hour
            if (hourAppointments.isNotEmpty)
              ...hourAppointments.map((appointment) =>
                  _buildAppointmentCard(appointment)
              ).toList()
            else
              SizedBox(height: 30), // Empty space for hour with no appointments
          ],
        );
      },
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    final bool isActive = appointment.status == AppointmentStatus.inProgress;
    final bool isCompleted = appointment.status == AppointmentStatus.completed;
    final bool isCancelled = appointment.status == AppointmentStatus.cancelled ||
        appointment.status == AppointmentStatus.noShow;

    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (isActive) {
      statusColor = Theme.of(context).colorScheme.primary;
      statusIcon = Icons.play_circle;
      statusText = 'In Progress';
    } else if (isCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusText = 'Completed';
    } else if (isCancelled) {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
      statusText = 'Cancelled';
    } else {
      statusColor = Theme.of(context).colorScheme.tertiary;
      statusIcon = Icons.access_time;
      statusText = 'Waiting';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 60, bottom: 8),
      child: Card(
        elevation: isActive ? 4 : 1,
        shadowColor: isActive ? statusColor.withOpacity(0.3) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isActive ? BorderSide(color: statusColor, width: 2) : BorderSide.none,
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/appointment_details',
              arguments: appointment,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time and status row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${DateFormat('h:mm a').format(appointment.startTime)} - ${DateFormat('h:mm a').format(appointment.endTime)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            statusIcon,
                            size: 12,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Patient info
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/patient_avatar.png'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    const SizedBox(width: 12),
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
                          ),
                          const SizedBox(height: 4),
                          Text(
                            appointment.appointmentType,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Display action buttons if appointment is not completed or cancelled
                if (!isCompleted && !isCancelled)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!isActive)
                          OutlinedButton(
                            onPressed: () {
                              // Start appointment
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              minimumSize: const Size(0, 36),
                            ),
                            child: const Text('Start'),
                          )
                        else
                          OutlinedButton(
                            onPressed: () {
                              // Complete appointment
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              minimumSize: const Size(0, 36),
                            ),
                            child: const Text('Complete'),
                          ),

                        const SizedBox(width: 8),

                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            _showAppointmentOptionsBottomSheet(appointment);
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      _loadAppointmentsForDate(pickedDate);
    }
  }

  void _showAddAppointmentBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add New',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(
                  Icons.add_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('New Appointment'),
              subtitle: const Text('Schedule a new patient appointment'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to create appointment screen
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple.shade50,
                child: const Icon(
                  Icons.block,
                  color: Colors.purple,
                ),
              ),
              title: const Text('Block Time'),
              subtitle: const Text('Reserve time for personal or clinic activities'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to block time screen
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAppointmentOptionsBottomSheet(Appointment appointment) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appointment.patientName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(
                  Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('View Details'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/appointment_details',
                  arguments: appointment,
                );
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade50,
                child: const Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
              ),
              title: const Text('Reschedule'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to reschedule screen
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade50,
                child: const Icon(
                  Icons.message,
                  color: Colors.green,
                ),
              ),
              title: const Text('Message Patient'),
              onTap: () {
                Navigator.pop(context);
                // Open messaging screen
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade50,
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
              title: const Text('Cancel Appointment'),
              onTap: () {
                Navigator.pop(context);
                _showCancelConfirmationDialog(appointment);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmationDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
            'Are you sure you want to cancel this appointment? This action cannot be undone.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Cancel appointment logic
              final doctorId = ''; // Get from auth service
              context.read<AppointmentBloc>().add(
                CancelAppointmentEvent(
                  doctorId: doctorId,
                  appointmentId: appointment.id,
                ),
              );
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}