import 'dart:ui' as ui;

import 'package:doctorapp/features/patient/doctor_search/presentation/bloc/search_doctor_bloc.dart';
import 'package:doctorapp/features/patient/doctor_search/presentation/screens/search_screen.dart';
import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/auth/auth_service.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'home_content_screen.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart' as di;
import '../../../appointments/presentation/screens/appointments_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  // Define colors
 Color primaryColor = Color(0xFF00BCD4); // Cyan
  Color secondaryColor = Color(0xFF3949AB); // Deep blue
   Color textDarkColor = Color(0xFF212121);
  Color textLightColor = Color(0xFF757575);
   Color primaryColorOpacity10 = Color.fromRGBO(0, 188, 212, 0.1);
   Color primaryColorOpacity15 = Color.fromRGBO(0, 188, 212, 0.15);
   Color primaryColorOpacity30 = Color.fromRGBO(0, 188, 212, 0.3);

  final List<Widget> _pages = [
    const HomeContentScreen(),
    BlocProvider(
      create: (context) => di.sl<DoctorSearchBloc>()
        ..add(const SearchDoctorsEvent())
        ..add(const LoadSpecialtiesEvent()),
      child: const SearchDoctorsScreen(),
    ),
    const AppointmentsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(
            _getTitle().tr(),
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: textDarkColor,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColorOpacity10, primaryColorOpacity15],
              ),
            ),
          ),
          actions: [
            if (_selectedIndex == 0) ...[
              IconButton(
                icon: Icon(Icons.filter_list, color: primaryColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('filter_not_implemented'.tr()),
                      backgroundColor: primaryColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                tooltip: 'filter'.tr(),
              ),
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: primaryColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('notifications_not_implemented'.tr()),
                      backgroundColor: primaryColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                tooltip: 'notifications'.tr(),
              ),
            ],
            IconButton(
              icon: Icon(Icons.logout, color: primaryColor),
              onPressed: () => _showLogoutDialog(context),
              tooltip: 'logout'.tr(),
            ),
          ],
        ),
        body: _fadeAnimation != null
            ? FadeTransition(
                opacity: _fadeAnimation!,
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              )
            : IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          if (_animationController != null) {
            _animationController!.reset();
            _animationController!.forward();
          }
        });
      },
      selectedItemColor: primaryColor,
      unselectedItemColor: textLightColor,
      selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.cairo(),
      backgroundColor: Colors.white,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home'.tr(),
          tooltip: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'search'.tr(),
          tooltip: 'search'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'appointments'.tr(),
          tooltip: 'appointments'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'profile'.tr(),
          tooltip: 'profile'.tr(),
        ),
      ],
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'home';
      case 1:
        return 'search';
      case 2:
        return 'appointments';
      case 3:
        return 'profile';
      default:
        return '';
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'logout'.tr(),
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: textDarkColor),
        ),
        content: Text(
          'logout_confirm'.tr(),
          style: GoogleFonts.openSans(color: textLightColor),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'cancel'.tr(),
              style: GoogleFonts.cairo(color: primaryColor),
            ),
          ),
          TextButton(
            onPressed: () => logout(context),
            child: Text(
              'confirm'.tr(),
              style: GoogleFonts.cairo(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    try {
      final authService = di.sl<AuthService>();
      await authService.logout();
      Navigator.pop(context); // Close dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('logout_error'.tr(args: [e.toString()])),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }
}