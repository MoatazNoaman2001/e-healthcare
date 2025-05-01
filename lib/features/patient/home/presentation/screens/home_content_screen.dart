import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/home_bloc.dart';
import '../widgets/doctor_list.dart';
import '../widgets/recent_doctor.dart';
import '../widgets/specialty_chips.dart';
import '../widgets/next_appointment_card.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({Key? key}) : super(key: key);

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _userId;
  int? _patientId;
  bool _isSearching = false;

  final Color _primaryColor = const Color(0xFF006272);
  final Color _accentColor = const Color(0xFFE0F7FA);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('user_id');
      _patientId = prefs.getInt('patient_id') ?? _userId;
    });

    if (_userId != null && _patientId != null) {
      _fetchInitialData();
    }
  }

  void _fetchInitialData() {
    context.read<HomeBloc>().add(const FetchSpecializationsEvent());
    if (_patientId != null) {
      context.read<HomeBloc>().add(FetchUpcomingAppointmentsEvent(patientId: _patientId!));
      context.read<HomeBloc>().add(FetchPastAppointmentsEvent(patientId: _patientId!));
    }
    context.read<HomeBloc>().add(const FetchClinicsEvent());
    context.read<HomeBloc>().add(const FetchDoctorsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';
    
    return Directionality(
      textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _accentColor.withOpacity(0.6),
                _primaryColor.withOpacity(0.1),
                Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildHomeContent(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchField(context, isRtl),
        const SizedBox(height: 24),
        if (!_isSearching) ...[
          _buildSection(
            context,
            title: 'specialties'.tr(),
            icon: Icons.medical_services_outlined,
            child: const SpecialtyChips(),
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'next_appointment'.tr(),
            icon: Icons.calendar_today_outlined,
            child: const NextAppointmentCard(),
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'recent_doctors'.tr(),
            icon: Icons.people_outline,
            child: const RecentDoctors(),
          ),
        ] else ...[
          _buildSection(
            context,
            title: 'search_results'.tr(),
            icon: Icons.search_outlined,
            child: const DoctorsList(),
          ),
        ],
      ],
    );
  }

  Widget _buildSearchField(BuildContext context, bool isRtl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: _primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
      ),
      child: TextFormField(
        controller: _searchController,
        textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          hintText: 'search_hint'.tr(),
          hintStyle: TextStyle(color: _primaryColor.withOpacity(0.5)),
          prefixIcon: Icon(Icons.search, color: _primaryColor, size: 24),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: _primaryColor, size: 24),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _isSearching = false;
                    });
                    context.read<HomeBloc>().add(const FetchDoctorsEvent());
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        style: TextStyle(
          color: _primaryColor,
          fontSize: 16,
        ),
        onChanged: (value) {
          setState(() {
            _isSearching = value.isNotEmpty;
          });
          context.read<HomeBloc>().add(FetchDoctorsEvent(searchQuery: value));
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final isRtl = context.locale.languageCode == 'ar';
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
         child: Row(
  children: [
    if (!isRtl) Icon(icon, size: 24, color: _primaryColor),
    if (!isRtl) const SizedBox(width: 8),
    Expanded(
      child: Text(
        title,
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _primaryColor,
        ),
      ),
    ),
    if (isRtl) const SizedBox(width: 8),
    if (isRtl) Icon(icon, size: 24, color: _primaryColor),
  ],
),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: child,
          ),
        ],
      ),
    );
  }
}