// lib/features/appointments/presentation/screens/appointments_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/appointments_bloc.dart';
import '../bloc/appointments_event.dart';
import '../bloc/appointments_state.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentsBloc(LoadAppointmentsUseCase())..add(LoadAppointmentsEvent()),
      child: const AppointmentsTabView(),
    );
  }
}

class AppointmentsTabView extends StatefulWidget {
  const AppointmentsTabView({super.key});

  @override
  State<AppointmentsTabView> createState() => _AppointmentsTabViewState();
}

class _AppointmentsTabViewState extends State<AppointmentsTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsBloc, AppointmentsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: 'قادمة'),
                Tab(text: 'منتهية'),
                Tab(text: 'ملغاة'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(state.upcoming),
                  _buildList(state.completed),
                  _buildList(state.cancelled),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(List appointments) {
    if (appointments.isEmpty) {
      return const Center(child: Text('لا توجد مواعيد'));
    }
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (_, index) {
        final a = appointments[index];
        return ListTile(
          leading: const Icon(Icons.calendar_today),
          title: Text(a.doctor),
          subtitle: Text('${a.date} - ${a.time}'),
        );
      },
    );
  }
}
