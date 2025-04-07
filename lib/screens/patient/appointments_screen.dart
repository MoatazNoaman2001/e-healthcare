import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointments App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AppointmentsScreen(),
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // بيانات تجريبية للمواعيد
  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'id': '1',
      'doctor': 'د. أحمد محمد',
      'specialty': 'أخصائي طب باطني',
      'image': 'doctor1.jpg',
      'date': DateTime.now().add(const Duration(days: 2)),
      'time': '04:30 م',
      'status': 'confirmed',
      'clinicAddress': 'شارع التحرير، ميدان الدقي، الجيزة',
    },
    {
      'id': '2',
      'doctor': 'د. سارة علي',
      'specialty': 'أخصائية أمراض نساء وتوليد',
      'image': 'doctor2.jpg',
      'date': DateTime.now().add(const Duration(days: 5)),
      'time': '06:00 م',
      'status': 'confirmed',
      'clinicAddress': 'شارع جامعة الدول العربية، المهندسين، الجيزة',
    },
  ];

  final List<Map<String, dynamic>> _completedAppointments = [
    {
      'id': '3',
      'doctor': 'د. محمود حسن',
      'specialty': 'أخصائي طب أطفال',
      'image': 'doctor3.jpg',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'time': '05:15 م',
      'status': 'completed',
      'clinicAddress': 'شارع الهرم، الجيزة',
      'review': 4.5,
    },
  ];

  final List<Map<String, dynamic>> _cancelledAppointments = [
    {
      'id': '4',
      'doctor': 'د. خالد محمد',
      'specialty': 'أخصائي جراحة عظام',
      'image': 'doctor5.jpg',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'time': '07:00 م',
      'status': 'cancelled',
      'clinicAddress': 'شارع شبرا، القاهرة',
      'cancelReason': 'اعتذر الطبيب لظروف طارئة',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // أزرار التبويب
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 16),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
              insets: const EdgeInsets.symmetric(horizontal: 40),
            ),
            tabs: const [
              Tab(text: 'قادمة'),
              Tab(text: 'منتهية'),
              Tab(text: 'ملغاة'),
            ],
          ),
        ),

        // محتوى التبويبات
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAppointmentsList(_upcomingAppointments, 'upcoming'),
              _buildAppointmentsList(_completedAppointments, 'completed'),
              _buildAppointmentsList(_cancelledAppointments, 'cancelled'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentsList(
    List<Map<String, dynamic>> appointments,
    String type,
  ) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getEmptyIcon(type), size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              _getEmptyText(type),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getEmptySubtext(type),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _buildAppointmentCard(context, appointment, type);
      },
    );
  }

  IconData _getEmptyIcon(String type) {
    switch (type) {
      case 'upcoming':
        return Icons.calendar_today;
      case 'completed':
        return Icons.check_circle_outline;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.calendar_today;
    }
  }

  String _getEmptyText(String type) {
    switch (type) {
      case 'upcoming':
        return 'لا توجد مواعيد قادمة';
      case 'completed':
        return 'لا توجد مواعيد منتهية';
      case 'cancelled':
        return 'لا توجد مواعيد ملغاة';
      default:
        return 'لا توجد مواعيد';
    }
  }

  String _getEmptySubtext(String type) {
    switch (type) {
      case 'upcoming':
        return 'ستظهر مواعيدك القادمة هنا بعد حجز موعد مع طبيب';
      case 'completed':
        return 'ستظهر مواعيدك المنتهية هنا بعد إتمام الزيارة الطبية';
      case 'cancelled':
        return 'ستظهر مواعيدك الملغاة هنا في حالة إلغاء أي موعد';
      default:
        return 'ستظهر مواعيدك هنا قريباً';
    }
  }

  Widget _buildAppointmentCard(
    BuildContext context,
    Map<String, dynamic> appointment,
    String type,
  ) {
    final date = appointment['date'] as DateTime;

    // Ensure locale data is initialized
    if (Intl.defaultLocale == null || !Intl.defaultLocale!.contains('ar')) {
      initializeDateFormatting('ar', null);
      Intl.defaultLocale = 'ar';
    }

    final dateFormatter = DateFormat.yMMMd('ar');
    final formattedDate = dateFormatter.format(date);
    final dayName = _getDayName(date.weekday);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            type == 'upcoming'
                ? const BorderSide(color: Color(0xFF1E88E5), width: 1)
                : type == 'completed'
                ? const BorderSide(color: Color(0xFF4CAF50), width: 1)
                : const BorderSide(color: Colors.red, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات الطبيب
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['doctor'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment['specialty'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      appointment['status'],
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(appointment['status']),
                    style: TextStyle(
                      color: _getStatusColor(appointment['status']),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // معلومات الموعد
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'التاريخ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(
                          '$dayName، $formattedDate',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'الوقت',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(
                          appointment['time'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // عنوان العيادة
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'العنوان',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment['clinicAddress'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // التقييم للمواعيد المنتهية
            if (type == 'completed')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تقييمك للزيارة',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (appointment['review'] ?? 0).floor()
                                ? Icons.star
                                : index < (appointment['review'] ?? 0)
                                ? Icons.star_half
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),

            // سبب الإلغاء للمواعيد الملغاة
            if (type == 'cancelled' && appointment.containsKey('cancelReason'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 24),
                  Text(
                    'سبب الإلغاء:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment['cancelReason'],
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),

            // أزرار للمواعيد القادمة
            if (type == 'upcoming')
              Column(
                children: [
                  const Divider(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // إلغاء الموعد
                            _showCancellationConfirmationDialog(
                              context,
                              appointment,
                            );
                          },
                          icon: const Icon(Icons.cancel_outlined, size: 18),
                          label: const Text('إلغاء'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // إعادة جدولة الموعد
                          },
                          icon: const Icon(Icons.edit_calendar, size: 18),
                          label: const Text('تعديل'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const List<String> days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[weekday - 1];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return const Color(0xFF1E88E5);
      case 'completed':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'confirmed':
        return 'مؤكد';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      default:
        return '';
    }
  }

  void _showCancellationConfirmationDialog(
    BuildContext context,
    Map<String, dynamic> appointment,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('إلغاء الموعد'),
            content: const Text(
              'هل أنت متأكد من رغبتك في إلغاء هذا الموعد؟ لا يمكن التراجع عن هذا الإجراء.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('تراجع'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // حذف الموعد من القادمة وإضافته للملغاة
                  setState(() {
                    _upcomingAppointments.removeWhere(
                      (a) => a['id'] == appointment['id'],
                    );
                    _cancelledAppointments.add({
                      ...appointment,
                      'status': 'cancelled',
                      'cancelReason': 'ألغي بواسطة المريض',
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('تم إلغاء الموعد بنجاح'),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('تأكيد الإلغاء'),
              ),
            ],
          ),
    );
  }
}
