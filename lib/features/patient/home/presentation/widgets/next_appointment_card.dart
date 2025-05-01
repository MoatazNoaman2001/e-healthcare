import 'package:doctorapp/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/home_bloc.dart';

class NextAppointmentCard extends StatefulWidget {
  const NextAppointmentCard({Key? key}) : super(key: key);

  @override
  State<NextAppointmentCard> createState() => _NextAppointmentCardState();
}

class _NextAppointmentCardState extends State<NextAppointmentCard> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  final Color _primaryColor = const Color(0xFF006272); // Dark teal
  final Color _accentColor = const Color(0xFFE0F7FA); // Light cyan

  int? _patientId;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    _animationController!.forward();

    // ✅ حل مشكلة context في getter
    // final prefs = context.read<SharedPreferences>();
    _patientId = prefs.getInt('patient_id') ?? prefs.getInt('user_id');
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        Widget content = _buildContent(context, state);

        if (_fadeAnimation != null) {
          content = FadeTransition(opacity: _fadeAnimation!, child: content);
        }

        return content;
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    final isRtl = context.locale.languageCode == 'ar';

    if (state.isUpcomingAppointmentsLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: CircularProgressIndicator(
            color: _primaryColor,
            backgroundColor: _accentColor.withOpacity(0.3),
            strokeWidth: 3,
          ),
        ),
      );
    }

    if (state.upcomingAppointmentsError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'upcoming_appointments_error'.tr(args: [state.upcomingAppointmentsError!]),
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.red.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  if (_patientId != null) {
                    context.read<HomeBloc>().add(
                      FetchUpcomingAppointmentsEvent(patientId: _patientId!),
                    );
                  }
                },
                child: Text(
                  'retry'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.upcomingAppointments.isEmpty) {
      return Card(
        elevation: 0,
        color: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: _primaryColor.withOpacity(0.15),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: _accentColor,
            child: Icon(Icons.event_busy, color: _primaryColor, size: 20),
          ),
          title: Text(
            'no_upcoming_appointments'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _primaryColor,
            ),
          ),
          subtitle: Text(
            'book_new_appointment'.tr(),
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: _primaryColor.withOpacity(0.7),
            ),
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('book_appointment_not_implemented'.tr()),
                backgroundColor: _primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        ),
      );
    }

    final nextAppointment = state.upcomingAppointments.first;
    final formattedTime = nextAppointment.scheduledDateTime != null
        ? DateFormat('yyyy/MM/dd - hh:mm a', isRtl ? 'ar' : 'en')
            .format(nextAppointment.scheduledDateTime!)
        : 'unknown_time'.tr();

    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: _primaryColor.withOpacity(0.15),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: _accentColor,
          child: Icon(Icons.calendar_today, color: _primaryColor, size: 20),
        ),
        title: Text(
          nextAppointment.doctorName ?? 'unknown_doctor'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _primaryColor,
          ),
        ),
        subtitle: Text(
          '${nextAppointment.specialization ?? 'unknown_specialization'.tr()} - $formattedTime',
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: _primaryColor.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
          size: 16,
          color: _primaryColor,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('appointment_details_not_implemented'.tr()),
              backgroundColor: _primaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        },
      ),
    );
  }
}
