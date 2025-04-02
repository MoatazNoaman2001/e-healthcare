import 'package:doctorapp/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'appointments_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContentScreen(), // الصفحة الرئيسية
    const SearchScreen(), // صفحة البحث
    const AppointmentsScreen(), // صفحة المواعيد
    const ProfileScreen(), // صفحة البروفايل
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _getTitle(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            if (_selectedIndex == 0)
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // فتح فلتر البحث
                },
              ),
            if (_selectedIndex == 0)
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // فتح الإشعارات
                },
              ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تسجيل الخروج'),
                    content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('تأكيد'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'تسجيل الخروج',
            ),
          ],
        ),
        body: _pages[_selectedIndex], // ربط الصفحات بالـ BottomNavigationBar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'بحث',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_today),
                  label: 'مواعيدي',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'حسابي',
                ),
              ],
            ),
          ),
        ),
      ),
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
        return 'طبيبي';
    }
  }
}

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'ابحث عن طبيب، تخصص، أو مرض...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'التخصصات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: _buildSpecialtyChips()),
          ),
          const SizedBox(height: 16),
          const Text(
            'موعدك القادم',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.calendar_today, color: Colors.blue),
              ),
              title: const Text('د. أحمد علي'),
              subtitle: const Text('طبيب قلب - 12:00 مساءً'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // عرض تفاصيل الموعد
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'الأطباء الذين زرتهم مؤخرًا',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: List.generate(3, (index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(Icons.person, color: Colors.green),
                ),
                title: Text('د. طبيب ${index + 1}'),
                subtitle: const Text('تخصص طبي'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // عرض تفاصيل الطبيب
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSpecialtyChips() {
    final List<Map<String, dynamic>> specialties = [
      {'name': 'قلب', 'color': Colors.red.shade400},
      {'name': 'أسنان', 'color': Colors.blue.shade400},
      {'name': 'عظام', 'color': Colors.green.shade400},
      {'name': 'أطفال', 'color': Colors.orange.shade400},
      {'name': 'نساء وتوليد', 'color': Colors.purple.shade400},
      {'name': 'جلدية', 'color': Colors.amber.shade400},
    ];

    return specialties.map((specialty) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Chip(
          label: Text(specialty['name']),
          backgroundColor: specialty['color'].withOpacity(0.1),
          labelStyle: TextStyle(color: specialty['color']),
        ),
      );
    }).toList();
  }
}
