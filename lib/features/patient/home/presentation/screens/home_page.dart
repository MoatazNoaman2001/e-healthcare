import 'package:doctorapp/features/patient/doctor_search/presentation/screens/search_screen.dart';
import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
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

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeContentScreen(),
    SearchDoctorsScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(_getTitle(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
              onPressed: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'مواعيدي'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
      ],
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'بحث';
      case 2:
        return 'مواعيدي';
      case 3:
        return 'الملف الشخصي';
      default:
        return '';
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () => logout(context),
            child: const Text('تأكيد'),
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
