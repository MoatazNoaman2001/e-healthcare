import 'dart:developer';

import 'package:doctorapp/core/auth/auth_service.dart';
import 'package:doctorapp/features/doctor/presentation/screens/doctor_dashboard_page.dart';
import 'package:doctorapp/features/patient/home/presentation/screens/home_page.dart';
import 'package:doctorapp/features/user_selection/presentation/screens/user_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart' as di;
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    // Start the splash animation and check auth after delay
    context.read<SplashBloc>().add(StartSplash());
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800), // Elegant and smooth
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic, // Refined fade
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic, // Gentle scale
      ),
    );
    _controller.forward();
  }

  void _checkAuthAndNavigate() {
    var authService = di.sl<AuthService>();
    log('token: ${authService.token}');
    log('currentUser: ${authService.currentUserType}');
    log('user loggedIn: ${authService.isLoggedIn}');

    // Check if user is authenticated
    if (authService.token != null && authService.isLoggedIn) {
      // Navigate based on user type
      if (authService.currentUserType == 'patient') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else if (authService.currentUserType == 'doctor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorDashboardPage()),
        );
      } else {
        // Fallback for unknown user type or if user type is not set
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserSelectionScreen()),
        );
      }
    } else {
      // User is not authenticated, navigate to user selection screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserSelectionScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashFinished) {
          log("state is SplashFinished");
          _checkAuthAndNavigate();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF3949AB).withOpacity(0.9), // Primary blue
                const Color(0xFF00BCD4).withOpacity(0.8), // Secondary cyan
                const Color(0xFFE1F5FE),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildSplashContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(context),
        const SizedBox(height: 32),
        _buildTitle(context),
        const SizedBox(height: 16),
        _buildSubtitle(),
        const SizedBox(height: 48),
        _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF3949AB).withOpacity(0.9),
            const Color(0xFF00BCD4),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3949AB).withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF00BCD4).withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.medical_services_rounded,
        size: 90,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          const Color(0xFF3949AB),
          const Color(0xFF00BCD4),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        'صحتي',
        style: GoogleFonts.cairo(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 2.5,
          shadows: [
            Shadow(
              color: const Color(0xFF3949AB).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'app_slogan'.tr(),
      style: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.5,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00BCD4).withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00BCD4)),
            strokeWidth: 5,
          ),
        );
      },
    );
  }
}