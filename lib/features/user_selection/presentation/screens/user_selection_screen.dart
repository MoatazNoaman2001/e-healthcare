import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../doctor/login_doctor/presentation/screens/login_screen_doctor.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  double _patientCardScale = 1.0; // For tap animation
  double _doctorCardScale = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Smooth and professional
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic, // Refined fade
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic, // Gentle scale
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Original colors
    const Color primaryColor = Color(0xFF3949AB); // Deep blue
    const Color secondaryColor = Color(0xFF00BCD4); // Cyan
    const Color accentColor = Color(0xFFFF4081); // Bright pink
    const Color textDarkColor = Color(0xFF212121);
    const Color textLightColor = Color(0xFF757575);
    const Color backgroundColor = Color(0xFFF5F7FA);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor,
              Color(0xFFE1F5FE),
              Color(0xFFE8EAF6),
            ],
            stops: [0.0, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Professional logo
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [primaryColor, secondaryColor],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.12),
                            blurRadius: 25,
                            spreadRadius: 3,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.medical_services_rounded,
                        size: 65,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Clean app title
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'app_name'.tr(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: textDarkColor,
                          letterSpacing: 1.5,
                          fontFamily: 'Inter',
                        ),
                  ),
                ),

                const SizedBox(height: 20),

                // Subtle slogan
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'slogan'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: textLightColor,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.3,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 56),

                // Professional prompt text
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'select_user_type'.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          letterSpacing: 1.0,
                          fontFamily: 'Inter',
                        ),
                  ),
                ),

                const SizedBox(height: 40),

                // User type buttons
                Row(
                  children: [
                    // Patient button
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
                            ),
                          );
                          return Transform.scale(
                            scale: _patientCardScale * animation.value,
                            child: Opacity(
                              opacity: animation.value,
                              child: GestureDetector(
                                onTapDown: (_) => setState(() => _patientCardScale = 0.94),
                                onTapUp: (_) {
                                  setState(() => _patientCardScale = 1.0);
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, animation, __) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: const LoginScreen(),
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 600),
                                    ),
                                  );
                                },
                                onTapCancel: () => setState(() => _patientCardScale = 1.0),
                                child: _buildUserTypeCard(
                                  context,
                                  title: 'patient'.tr(),
                                  icon: Icons.person_rounded,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 24),

                    // Doctor button
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.3, 0.9, curve: Curves.easeOutCubic),
                            ),
                          );
                          return Transform.scale(
                            scale: _doctorCardScale * animation.value,
                            child: Opacity(
                              opacity: animation.value,
                              child: GestureDetector(
                                onTapDown: (_) => setState(() => _doctorCardScale = 0.94),
                                onTapUp: (_) {
                                  setState(() => _doctorCardScale = 1.0);
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, animation, __) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: const LoginScreenDoctor(),
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 600),
                                    ),
                                  );
                                },
                                onTapCancel: () => setState(() => _doctorCardScale = 1.0),
                                child: _buildUserTypeCard(
                                  context,
                                  title: 'doctor'.tr(),
                                  icon: Icons.medical_services_rounded,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                // Elegant footer
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      'user_type_change_later'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textLightColor.withOpacity(0.85),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.4,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Refined icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 20),
          // Professional title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 0.8,
                  fontFamily: 'Inter',
                ),
          ),
          const SizedBox(height: 16),
          // Subtle button text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Text(
              'tap_to_continue'.tr(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Open Sans',
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}