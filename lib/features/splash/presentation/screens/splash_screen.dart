import 'dart:developer';

import 'package:doctorapp/core/auth/auth_service.dart';
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
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
        // Navigate to doctor's home page
        // TODO: Replace with your doctor home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DoctorHomePage()),
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF006272), Color(0xFF004D4D)],
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _buildSplashContent(context),
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
        const SizedBox(height: 24),
        _buildTitle(),
        const SizedBox(height: 8),
        _buildSubtitle(),
        const SizedBox(height: 50),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        Icons.medical_services_rounded,
        size: 80,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

 Widget _buildTitle() {
  return Text(
    'app_name'.tr(),
    style: GoogleFonts.tajawal(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

 Widget _buildSubtitle() {
  return Text(
    'app_slogan'.tr(),
    style: GoogleFonts.tajawal(fontSize: 18, color: Colors.white),
  );
}
}

// TODO: Create this screen or replace with your actual doctor home page
class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
      ),
      body: const Center(
        child: Text('Doctor Home Page'),
      ),
    );
  }
}