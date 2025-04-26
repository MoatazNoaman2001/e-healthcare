
import 'package:doctorapp/features/patient/doctor_search/presentation/bloc/search_doctor_bloc.dart';
import 'package:doctorapp/features/patient/doctor_search/presentation/screens/search_screen.dart';
import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/auth/auth_service.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'home_content_screen.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart' as di;
import '../../../appointments/presentation/screens/appointments_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

final List<Widget> _pages = [
  HomeContentScreen(),
  BlocProvider(
    create: (context) => di.sl<DoctorSearchBloc>()
      ..add(const SearchDoctorsEvent())
      ..add(const LoadSpecialtiesEvent()),
    child: const SearchDoctorsScreen(),
  ),
  AppointmentsScreen(),
  ProfileScreen(),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(_getTitle().tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            if (_selectedIndex == 0) ...[
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ],
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'home'.tr()),
        BottomNavigationBarItem(icon: const Icon(Icons.search), label: 'search'.tr()),
        BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: 'appointments'.tr()),
        BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'profile'.tr()),
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
        title: Text('logout'.tr()),
        content: Text('logout_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () => logout(context),
            child: Text('confirm'.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final authService = di.sl<AuthService>();
    await authService.logout();

    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}
