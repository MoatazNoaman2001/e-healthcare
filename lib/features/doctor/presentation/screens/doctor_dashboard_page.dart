import 'package:doctorapp/features/patient/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/auth/auth_service.dart';
import '../../../../core/di/dependancy_injection.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '../bloc/appointment/appointments_bloc.dart';
import '../bloc/doctor/doctor_bloc.dart';
import '../bloc/schedule/schedule_bloc.dart';
import '../widgets/appointment_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/next_appointment_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/shimmer_effect.dart';

class DoctorDashboardPage extends StatefulWidget {
  const DoctorDashboardPage({Key? key}) : super(key: key);

  @override
  State<DoctorDashboardPage> createState() => _DoctorDashboardPageState();
}

class _DoctorDashboardPageState extends State<DoctorDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadDashboardData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadDashboardData() {
    //load doctor data
    final authService = sl<AuthService>();

    // Load profile data
    context.read<DoctorBloc>().add(GetMyProfileEvent());

    // Load today's appointments
    final doctorId = authService.currentUserId.toString(); // Get from authentication service
    context
        .read<AppointmentBloc>()
        .add(GetTodayAppointmentsEvent(doctorId: doctorId));

    // Load upcoming appointments
    context
        .read<AppointmentBloc>()
        .add(GetUpcomingAppointmentsEvent(doctorId: doctorId));

    // Load past appointments for history tab
    context
        .read<AppointmentBloc>()
        .add(GetPastAppointmentsEvent(doctorId: doctorId));

    // Load schedule
    context.read<ScheduleBloc>().add(GetSchedulesEvent(doctorId: doctorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _loadDashboardData();
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverPersistentHeader(
                delegate: CustomAppBarDelegate(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      BlocBuilder<DoctorBloc, DoctorState>(
                        builder: (context, state) {
                          return Text(
                            'Dr. ${state == MyProfileLoaded? (state as MyProfileLoaded).doctor.firstName: "Smith"}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Text('JS', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                  expandedHeight: 200,
                  collapsedHeight: 80,
                  backgroundColor: Colors.blue, // Optional custom color
                ),
                floating: true,
                pinned: true,
              ),
              // Dashboard content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today's date
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('EEEE, MMMM d, yyyy')
                                  .format(DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Stats row
                      BlocBuilder<AppointmentBloc, AppointmentState>(
                        builder: (context, state) {
                          int todayAppointmentsCount = 0;
                          int waitingCount = 0;

                          if (state is TodayAppointmentsLoaded) {
                            todayAppointmentsCount = state.appointments.length;
                            waitingCount = state.appointments
                                .where((a) =>
                                    a.status == 'confirmed' ||
                                    a.status == 'waiting')
                                .length;
                          }

                          return Row(
                            children: [
                              StatCard(
                                title: 'Today\'s\nAppointments',
                                value: todayAppointmentsCount.toString(),
                                backgroundColor: Colors.blue.shade50,
                                iconColor:
                                    Theme.of(context).colorScheme.primary,
                                icon: Icons.calendar_today,
                              ),
                              const SizedBox(width: 16),
                              StatCard(
                                title: 'Waiting\nPatients',
                                value: waitingCount.toString(),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.1),
                                iconColor:
                                    Theme.of(context).colorScheme.tertiary,
                                icon: Icons.people,
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Next appointment card
                      Text(
                        'Next Appointment',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<AppointmentBloc, AppointmentState>(
                        builder: (context, state) {
                          if (state is UpcomingAppointmentsLoaded &&
                              state.appointments.isNotEmpty) {
                            // Get the next appointment
                            final nextAppointment = state.appointments.first;
                            return NextAppointmentCard(
                                appointment: nextAppointment);
                          } else if (state is AppointmentLoading) {
                            return ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            );
                          }

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Icon(
                                    Icons.event_available,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No upcoming appointments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.grey.shade600,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Quick actions
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            QuickActionButton(
                              icon: Icons.calendar_month,
                              label: 'Schedule',
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1A6FEE), Color(0xFF6BA5F7)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/today_schedule');
                              },
                            ),
                            QuickActionButton(
                              icon: Icons.people,
                              label: 'Patients',
                              gradient: const LinearGradient(
                                colors: [Color(0xFF42C3A7), Color(0xFF8EE9D4)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/patient_list');
                              },
                            ),
                            QuickActionButton(
                              icon: Icons.calendar_today,
                              label: 'Calendar',
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFA800), Color(0xFFFFD980)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/calendar');
                              },
                            ),
                            QuickActionButton(
                              icon: Icons.person,
                              label: 'Profile',
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF6B6B), Color(0xFFFF9E9E)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/doctor_profile');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tabs for Today, Upcoming, History
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Today'),
                      Tab(text: 'Upcoming'),
                      Tab(text: 'History'),
                    ],
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                  ),
                ),
                pinned: true,
              ),

              // Tab content
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Today's Appointments
                    _buildTodayAppointments(),

                    // Upcoming Appointments
                    _buildUpcomingAppointments(),

                    // Appointment History
                    _buildAppointmentHistory(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAppointmentOptions();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, '/today_schedule');
              break;
            case 2:
              Navigator.pushNamed(context, '/patient_list');
              break;
            case 3:
              Navigator.pushNamed(context, '/doctor_profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildTodayAppointments() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is TodayAppointmentsLoaded) {
          if (state.appointments.isEmpty) {
            return _buildEmptyState('No appointments for today');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.appointments.length,
            itemBuilder: (context, index) {
              final appointment = state.appointments[index];
              return AppointmentCard(
                appointment: appointment,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/appointment_details',
                    arguments: appointment,
                  );
                },
              );
            },
          );
        }

        if (state is AppointmentLoading) {
          return _buildLoadingSkeleton();
        }

        if (state is AppointmentError) {
          return _buildErrorState(state.failure.message);
        }

        return _buildLoadingSkeleton();
      },
    );
  }

  Widget _buildUpcomingAppointments() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is UpcomingAppointmentsLoaded) {
          if (state.appointments.isEmpty) {
            return _buildEmptyState('No upcoming appointments');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.appointments.length,
            itemBuilder: (context, index) {
              final appointment = state.appointments[index];
              return AppointmentCard(
                appointment: appointment,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/appointment_details',
                    arguments: appointment,
                  );
                },
              );
            },
          );
        }

        if (state is AppointmentLoading) {
          return _buildLoadingSkeleton();
        }

        if (state is AppointmentError) {
          return _buildErrorState(state.failure.message);
        }

        return _buildLoadingSkeleton();
      },
    );
  }

  Widget _buildAppointmentHistory() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is PastAppointmentsLoaded) {
          if (state.appointments.isEmpty) {
            return _buildEmptyState('No appointment history');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.appointments.length,
            itemBuilder: (context, index) {
              final appointment = state.appointments[index];
              return AppointmentCard(
                appointment: appointment,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/appointment_details',
                    arguments: appointment,
                  );
                },
              );
            },
          );
        }

        if (state is AppointmentLoading) {
          return _buildLoadingSkeleton();
        }

        if (state is AppointmentError) {
          return _buildErrorState(state.failure.message);
        }

        return _buildLoadingSkeleton();
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              _showAddAppointmentOptions();
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Appointment"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ShimmerLoading(
            isLoading: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Patient row shimmer
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 80,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _loadDashboardData();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showAddAppointmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Add New',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  // Navigate to create appointment
                  Navigator.pushNamed(context, '/create_appointment');
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
                subtitle: const Text(
                    'Reserve time for personal or clinic activities'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to block time
                  Navigator.pushNamed(context, '/block_time');
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade50,
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.orange,
                  ),
                ),
                title: const Text('Register New Patient'),
                subtitle: const Text('Add a new patient to the system'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to add new patient
                  Navigator.pushNamed(context, '/register_patient');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
