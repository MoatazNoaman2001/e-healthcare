import 'dart:developer';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _HomeContentScreenState extends State<HomeContentScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  int? _userId;
  int? _patientId;
  bool _isSearching = false;

  final Color _primaryColor = const Color(0xFF006272); // Dark teal
  final Color _accentColor = const Color(0xFFE0F7FA); // Light cyan

  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animations for sections
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOutCubic),
    );
    _animationController!.forward();
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('user_data_error'.tr()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
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
    _animationController?.dispose();
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
                _accentColor.withOpacity(0.8),
                _primaryColor.withOpacity(0.2),
                Colors.white,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // Show error snackbars
                if (state.doctorsError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.doctorsError!),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
                if (state.specializationsError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.specializationsError!),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
                if (state.upcomingAppointmentsError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.upcomingAppointmentsError!),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
                if (state.pastAppointmentsError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.pastAppointmentsError!),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
                if (state.clinicsError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.clinicsError!),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              },
              builder: (context, state) {
                // Check loading state
                final isLoading = state.isDoctorsLoading ||
                    state.isSpecializationsLoading ||
                    state.isUpcomingAppointmentsLoading ||
                    state.isPastAppointmentsLoading ||
                    state.isClinicsLoading;


                log('values: ${state.isDoctorsLoading} ${state.isSpecializationsLoading} ${state.isUpcomingAppointmentsLoading } ${state.isPastAppointmentsLoading} ${state.isClinicsLoading}');

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildHomeContent(context, state, isLoading),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, HomeState state, bool isLoading) {
    final isRtl = context.locale.languageCode == 'ar';

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search Field
        _buildSearchField(context, isRtl),
        const SizedBox(height: 24),

        // Content Sections
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              color: _primaryColor,
              strokeWidth: 3,
              backgroundColor: _accentColor.withOpacity(0.3),
            ),
          )
        else if (state.specializations.isEmpty &&
            state.upcomingAppointments.isEmpty &&
            state.doctors.isEmpty &&
            state.clinics.isEmpty)
          Center(
            child: Text(
              'no_data'.tr(),
              style: GoogleFonts.cairo(
                fontSize: 18,
                color: _primaryColor.withOpacity(0.7),
              ),
            ),
          )
        else
          ...[
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
      ],
    );

    // Apply fade animation
    if (_fadeAnimation != null) {
      content = FadeTransition(opacity: _fadeAnimation!, child: content);
    }

    return content;
  }

  Widget _buildSearchField(BuildContext context, bool isRtl) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: _primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(_isSearching ? 0.25 : 0.15),
            blurRadius: 12,
            spreadRadius: _isSearching ? 5 : 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: TextFormField(
            controller: _searchController,
            textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
            decoration: InputDecoration(
              hintText: 'search_hint'.tr(),
              hintStyle: GoogleFonts.openSans(
                color: _primaryColor.withOpacity(0.5),
                fontSize: 16,
              ),
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
            style: GoogleFonts.openSans(
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
        ),
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {}, // Optional: Add tap functionality if needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    if (!isRtl) Icon(icon, size: 26, color: _primaryColor),
                    if (!isRtl) const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: isRtl ? TextAlign.right : TextAlign.left,
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                    if (isRtl) const SizedBox(width: 12),
                    if (isRtl) Icon(icon, size: 26, color: _primaryColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}