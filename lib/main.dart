import 'package:doctorapp/core/theme/theme.dart';
import 'package:doctorapp/features/doctor/presentation/bloc/appointment/appointments_bloc.dart';
import 'package:doctorapp/features/doctor/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:doctorapp/features/doctor/presentation/bloc/doctor/get_me_doctor_bloc.dart';
import 'package:doctorapp/features/doctor/presentation/bloc/schedule/schedule_bloc.dart';
import 'package:doctorapp/features/doctor/presentation/screens/doctor_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:io';
import 'package:doctorapp/core/localization/bloc/language_bloc.dart';
import 'package:doctorapp/features/patient/appointments/presentation/screens/appointments_screen.dart';
import 'package:doctorapp/features/patient/appointments_booking/presentation/screens/appointment_booking_screen.dart';
import 'package:doctorapp/features/patient/doctors/presentation/screens/doctor_profile_screen.dart' as pdp;
import 'package:doctorapp/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:doctorapp/features/splash/presentation/screens/splash_screen.dart';
import 'package:doctorapp/features/user_selection/presentation/screens/user_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/dependancy_injection.dart' as di;
import 'features/doctor/presentation/screens/doctor_profile.dart';
import 'features/patient/home/presentation/bloc/home_bloc.dart';
late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();
  prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      useOnlyLangCode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (context) => di.sl<HomeBloc>()),
          BlocProvider(create: (context) => di.sl<LanguageBloc>()),
          BlocProvider(create: (context) => di.sl<DoctorBloc>()),
          BlocProvider(create: (context) => di.sl<GetMeDoctorBloc>()),
          BlocProvider(create: (context) => di.sl<AppointmentBloc>()),
          BlocProvider(create: (context) => di.sl<ScheduleBloc>()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صحتي',
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.lightTheme(),
      // darkTheme: AppTheme.darkTheme(),

      // theme: ThemeData(
      //   primaryColor: const Color(0xFF006272),
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color(0xFF006272),
      //     primary: const Color(0xFF006272),
      //     secondary: const Color(0xFF4CAF50),
      //     tertiary: const Color(0xFFE3F2FD),
      //     background: Colors.white,
      //   ),
      //   textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: const Color(0xFF006272),
      //       foregroundColor: Colors.white,
      //       elevation: 2,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       padding: const EdgeInsets.symmetric(vertical: 12),
      //     ),
      //   ),
      //   inputDecorationTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.grey.shade50,
      //     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       borderSide: BorderSide(color: Colors.grey.shade300),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       borderSide: BorderSide(color: Colors.grey.shade300),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
      //     ),
      //   ),
      //   scaffoldBackgroundColor: Colors.white,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.white,
      //     foregroundColor: Color(0xFF006272),
      //     elevation: 0,
      //     centerTitle: true,
      //     titleTextStyle: TextStyle(
      //       color: Color(0xFF006272),
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     iconTheme: IconThemeData(color: Color(0xFF006272)),
      //   ),
      //   cardTheme: CardTheme(
      //     elevation: 2,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //     shadowColor: Colors.black.withOpacity(0.1),
      //   ),
      //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //     selectedItemColor: Color(0xFF006272),
      //     unselectedItemColor: Colors.grey,
      //     showUnselectedLabels: true,
      //     type: BottomNavigationBarType.fixed,
      //     elevation: 8,
      //   ),
      //   useMaterial3: true,
      // ),
      home: const SplashScreen(),
      routes: {
        '/doctor_profile_screen': (context) => const DoctorProfileScreen(

        ),
        '/HomeScreen': (context) => const DoctorDashboardPage(),
        '/book-appointment': (context) => const pdp.DoctorProfileScreen(),
        // '/doctor-details': (context) => const DoctorDetailsScreen()
      },
    );
  }
}
//
// class DoctorDashboardApp extends StatelessWidget {
//   const DoctorDashboardApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Doctor Dashboard',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         primaryColor: const Color(0xFF3F51B5),
//         scaffoldBackgroundColor: const Color(0xFFF5F5F5),
//       ),
//       home: MainDashboard(),
//     );
//   }
// }
//
// class MainDashboard extends StatefulWidget {
//   @override
//   _MainDashboardState createState() => _MainDashboardState();
// }
//
// class _MainDashboardState extends State<MainDashboard> {
//   int _selectedIndex = 0;
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: [
//           DoctorDashboardScreen(),
//           TodayScheduleScreen(),
//           CalendarScreen(),
//           PatientListScreen(),
//           DoctorProfileScreen(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             _pageController.animateToPage(
//               index,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           });
//         },
//         selectedItemColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule),
//             label: 'Schedule',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Calendar',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Patients',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 1. Doctor Dashboard Screen
// class DoctorDashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Doctor info card
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage: NetworkImage('https://via.placeholder.com/60'),
//                       ),
//                       SizedBox(width: 16),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Dr. Jane Smith',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Cardiologist',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           Text(
//                             DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
//                             style: TextStyle(
//                               color: Colors.blue[700],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//
//               // Stats Row
//               Row(
//                 children: [
//                   _buildStatCard(
//                     context,
//                     Icons.event,
//                     '12',
//                     'Appointments',
//                     Colors.blue[700]!,
//                   ),
//                   SizedBox(width: 16),
//                   _buildStatCard(
//                     context,
//                     Icons.people,
//                     '4',
//                     'Waiting',
//                     Colors.orange,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24),
//
//               // Next appointment
//               Text(
//                 'Next Appointment',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               _buildNextAppointmentCard(),
//               SizedBox(height: 24),
//
//               // Quick actions
//               Text(
//                 'Quick Actions',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildQuickActionButton(
//                     context,
//                     Icons.add,
//                     'New Appointment',
//                     Colors.green,
//                   ),
//                   _buildQuickActionButton(
//                     context,
//                     Icons.message,
//                     'Messages',
//                     Colors.blue,
//                   ),
//                   _buildQuickActionButton(
//                     context,
//                     Icons.phone,
//                     'Call Patient',
//                     Colors.purple,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard(BuildContext context, IconData icon, String value, String label, Color color) {
//     return Expanded(
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Icon(
//                 icon,
//                 color: color,
//                 size: 32,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNextAppointmentCard() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage('https://via.placeholder.com/50'),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Sarah Johnson',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text('Annual Check-up'),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '10:30 AM',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[700],
//                       ),
//                     ),
//                     Text(
//                       'In 15 min',
//                       style: TextStyle(
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 OutlinedButton.icon(
//                   icon: Icon(Icons.call),
//                   label: Text('Call'),
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                   ),
//                 ),
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.check),
//                   label: Text('Start Session'),
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickActionButton(BuildContext context, IconData icon, String label, Color color) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           padding: EdgeInsets.all(12),
//           child: Icon(
//             icon,
//             color: color,
//             size: 24,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey[800],
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // 2. Today's Schedule Screen
// class TodayScheduleScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Today\'s Schedule'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {},
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Column(
//         children: [
//           // Date selector
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 8.0),
//             color: Colors.white,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: List.generate(7, (index) {
//                   final date = DateTime.now().add(Duration(days: index));
//                   final isToday = index == 0;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: DateBubble(
//                       date: date,
//                       isSelected: isToday,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//           Divider(height: 1),
//
//           // Schedule stats
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildScheduleStat('12', 'Total'),
//                 _verticalDivider(),
//                 _buildScheduleStat('4', 'Waiting'),
//                 _verticalDivider(),
//                 _buildScheduleStat('7', 'Completed'),
//               ],
//             ),
//           ),
//           Divider(height: 1),
//
//           // Timeline and appointments
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16.0),
//               children: [
//                 _buildTimelineAppointment(
//                   '09:00 AM',
//                   'Michael Brown',
//                   'Follow-up',
//                   'completed',
//                 ),
//                 _buildTimelineAppointment(
//                   '10:30 AM',
//                   'Sarah Johnson',
//                   'Annual Check-up',
//                   'in-progress',
//                 ),
//                 _buildTimelineAppointment(
//                   '11:15 AM',
//                   'Robert Davis',
//                   'New Patient',
//                   'waiting',
//                 ),
//                 _buildTimelineAppointment(
//                   '01:00 PM',
//                   'Jennifer Wilson',
//                   'Lab Results',
//                   'upcoming',
//                 ),
//                 _buildTimelineAppointment(
//                   '02:30 PM',
//                   'David Thompson',
//                   'Follow-up',
//                   'upcoming',
//                 ),
//                 _buildTimelineAppointment(
//                   '03:45 PM',
//                   'Amanda Garcia',
//                   'Consultation',
//                   'upcoming',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildScheduleStat(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue[700],
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _verticalDivider() {
//     return Container(
//       height: 30,
//       width: 1,
//       color: Colors.grey[300],
//     );
//   }
//
//   Widget _buildTimelineAppointment(String time, String patientName, String appointmentType, String status) {
//     Color statusColor;
//     String statusText;
//
//     switch (status) {
//       case 'completed':
//         statusColor = Colors.green;
//         statusText = 'Completed';
//         break;
//       case 'in-progress':
//         statusColor = Colors.blue;
//         statusText = 'In Progress';
//         break;
//       case 'waiting':
//         statusColor = Colors.orange;
//         statusText = 'Waiting';
//         break;
//       case 'upcoming':
//       default:
//         statusColor = Colors.grey;
//         statusText = 'Upcoming';
//         break;
//     }
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Time column
//           SizedBox(
//             width: 80,
//             child: Text(
//               time,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ),
//           // Timeline line
//           Column(
//             children: [
//               Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: statusColor,
//                 ),
//               ),
//               Container(
//                 width: 2,
//                 height: 80,
//                 color: Colors.grey[300],
//               ),
//             ],
//           ),
//           SizedBox(width: 16),
//           // Appointment card
//           Expanded(
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             patientName,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: statusColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             statusText,
//                             style: TextStyle(
//                               color: statusColor,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Text(appointmentType),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             child: Text('Reschedule'),
//                             onPressed: () {},
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.blue,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: ElevatedButton(
//                             child: Text('Start'),
//                             onPressed: status == 'upcoming' || status == 'waiting' ? () {} : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               foregroundColor: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateBubble extends StatelessWidget {
//   final DateTime date;
//   final bool isSelected;
//
//   const DateBubble({
//     Key? key,
//     required this.date,
//     this.isSelected = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
//         ),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Column(
//         children: [
//           Text(
//             DateFormat('E').format(date),
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey[700],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             DateFormat('d').format(date),
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 3. Calendar Screen
// class CalendarScreen extends StatefulWidget {
//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }
//
// class _CalendarScreenState extends State<CalendarScreen> {
//   DateTime _selectedDate = DateTime.now();
//   List<String> _viewOptions = ['Month', 'Week', 'Day'];
//   String _currentView = 'Month';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calendar'),
//         actions: [
//           PopupMenuButton<String>(
//             icon: Icon(Icons.filter_list),
//             onSelected: (value) {
//               setState(() {
//                 _currentView = value;
//               });
//             },
//             itemBuilder: (context) {
//               return _viewOptions.map((option) {
//                 return PopupMenuItem(
//                   value: option,
//                   child: Text(option),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {},
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Column(
//         children: [
//           // Month selector
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.chevron_left),
//                   onPressed: () {
//                     setState(() {
//                       if (_currentView == 'Month') {
//                         _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
//                       } else if (_currentView == 'Week') {
//                         _selectedDate = _selectedDate.subtract(Duration(days: 7));
//                       } else {
//                         _selectedDate = _selectedDate.subtract(Duration(days: 1));
//                       }
//                     });
//                   },
//                 ),
//                 Text(
//                   _currentView == 'Month'
//                       ? DateFormat('MMMM yyyy').format(_selectedDate)
//                       : _currentView == 'Week'
//                       ? 'Week of ${DateFormat('MMM d').format(_selectedDate)}'
//                       : DateFormat('EEE, MMM d').format(_selectedDate),
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.chevron_right),
//                   onPressed: () {
//                     setState(() {
//                       if (_currentView == 'Month') {
//                         _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
//                       } else if (_currentView == 'Week') {
//                         _selectedDate = _selectedDate.add(Duration(days: 7));
//                       } else {
//                         _selectedDate = _selectedDate.add(Duration(days: 1));
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // Calendar grid or timeline depending on view
//           Expanded(
//             child: _currentView == 'Month'
//                 ? _buildMonthView()
//                 : _currentView == 'Week'
//                 ? _buildWeekView()
//                 : _buildDayView(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMonthView() {
//     // Calculate first day of grid (might be in previous month)
//     final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
//     final firstDayOfGrid = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
//
//     return Column(
//       children: [
//         // Weekday headers
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
//               return Expanded(
//                 child: Center(
//                   child: Text(
//                     day,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: 8),
//
//         // Calendar grid
//         Expanded(
//           child: GridView.builder(
//             padding: EdgeInsets.all(16),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 7,
//               childAspectRatio: 1,
//             ),
//             itemCount: 42, // 6 weeks
//             itemBuilder: (context, index) {
//               final date = firstDayOfGrid.add(Duration(days: index));
//               final isCurrentMonth = date.month == _selectedDate.month;
//               final isToday = date.year == DateTime.now().year &&
//                   date.month == DateTime.now().month &&
//                   date.day == DateTime.now().day;
//
//               // Sample appointment data - in real app, this would come from your data source
//               final hasAppointments = date.day % 3 == 0 && isCurrentMonth;
//               final appointmentCount = hasAppointments ? (date.day % 5) + 1 : 0;
//
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedDate = date;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                     color: isToday ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
//                     borderRadius: BorderRadius.circular(8),
//                     border: isToday
//                         ? Border.all(color: Theme.of(context).primaryColor)
//                         : null,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '${date.day}',
//                         style: TextStyle(
//                           color: isCurrentMonth ? Colors.black : Colors.grey[400],
//                           fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                       if (appointmentCount > 0)
//                         Container(
//                           margin: EdgeInsets.only(top: 4),
//                           padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[100],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             '$appointmentCount',
//                             style: TextStyle(
//                               fontSize: 10,
//                               color: Colors.blue[800],
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildWeekView() {
//     // Get start of week (Sunday)
//     final startOfWeek = _selectedDate.subtract(Duration(days: _selectedDate.weekday % 7));
//
//     return Column(
//       children: [
//         // Day headers
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             children: List.generate(7, (index) {
//               final date = startOfWeek.add(Duration(days: index));
//               final isToday = date.year == DateTime.now().year &&
//                   date.month == DateTime.now().month &&
//                   date.day == DateTime.now().day;
//
//               return Expanded(
//                 child: Column(
//                   children: [
//                     Text(
//                       DateFormat('E').format(date),
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: isToday ? Theme.of(context).primaryColor : null,
//                       ),
//                       padding: EdgeInsets.all(8),
//                       child: Text(
//                         '${date.day}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: isToday ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: 16),
//
//         // Week schedule
//         Expanded(
//           child: ListView(
//             padding: EdgeInsets.all(16),
//             children: [
//               _buildTimeSlot('9:00 AM', 'Sarah Johnson', 'Annual Check-up', Colors.blue),
//               _buildTimeSlot('10:30 AM', 'Michael Brown', 'Follow-up', Colors.green),
//               _buildTimeSlot('1:00 PM', 'Emily Wilson', 'New Patient', Colors.orange),
//               _buildTimeSlot('2:30 PM', 'James Miller', 'Consultation', Colors.purple),
//               _buildTimeSlot('4:00 PM', 'Lisa Thompson', 'Lab Results', Colors.teal),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDayView() {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         // Morning
//         _buildDaySection('Morning'),
//         _buildTimeSlot('9:00 AM', 'Sarah Johnson', 'Annual Check-up', Colors.blue),
//         _buildTimeSlot('10:30 AM', 'Michael Brown', 'Follow-up', Colors.green),
//         _buildTimeSlot('11:45 AM', 'David Wilson', 'Vaccination', Colors.orange),
//
//         // Afternoon
//         _buildDaySection('Afternoon'),
//         _buildTimeSlot('1:00 PM', 'Emily Wilson', 'New Patient', Colors.orange),
//         _buildTimeSlot('2:30 PM', 'James Miller', 'Consultation', Colors.purple),
//         _buildTimeSlot('4:00 PM', 'Lisa Thompson', 'Lab Results', Colors.teal),
//
//         // Evening
//         _buildDaySection('Evening'),
//         _buildTimeSlot('5:15 PM', 'Robert Davis', 'Follow-up', Colors.blue),
//       ],
//     );
//   }
//
//   Widget _buildDaySection(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Row(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Divider(
//               color: Colors.grey[300],
//               thickness: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimeSlot(String time, String patientName, String appointmentType, Color color) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border(
//             left: BorderSide(color: color, width: 4),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     time,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     appointmentType,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       patientName,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.access_time,
//                           size: 14,
//                           color: Colors.grey[600],
//                         ),
//                         SizedBox(width: 4),
//                         Text(
//                           '30 min',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.more_vert),
//                 onPressed: () {},
//                 color: Colors.grey[600],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // 4. Patient List Screen
// class PatientListScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> patients = [
//     {
//       'name': 'Sarah Johnson',
//       'age': 42,
//       'condition': 'Hypertension',
//       'lastVisit': '2 weeks ago',
//       'nextAppointment': 'Today, 10:30 AM',
//     },
//     {
//       'name': 'Michael Brown',
//       'age': 35,
//       'condition': 'Diabetes Type 2',
//       'lastVisit': '1 month ago',
//       'nextAppointment': 'Tomorrow, 9:00 AM',
//     },
//     {
//       'name': 'Emily Wilson',
//       'age': 28,
//       'condition': 'Pregnancy',
//       'lastVisit': '3 days ago',
//       'nextAppointment': 'Next week',
//     },
//     {
//       'name': 'Robert Davis',
//       'age': 52,
//       'condition': 'Heart Disease',
//       'lastVisit': '2 months ago',
//       'nextAppointment': 'Today, 11:15 AM',
//     },
//     {
//       'name': 'Jennifer Thompson',
//       'age': 45,
//       'condition': 'Arthritis',
//       'lastVisit': '3 weeks ago',
//       'nextAppointment': 'Friday, 2:30 PM',
//     },
//     {
//       'name': 'David Miller',
//       'age': 61,
//       'condition': 'COPD',
//       'lastVisit': '1 week ago',
//       'nextAppointment': 'Tomorrow, 3:45 PM',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Patients'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {},
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Column(
//         children: [
//           // Search bar
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search patients...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: Colors.grey[300]!,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: Colors.grey[300]!,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//           ),
//
//           // Filter chips
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 _buildFilterChip('All Patients', true),
//                 _buildFilterChip('Recent', false),
//                 _buildFilterChip('Upcoming', false),
//                 _buildFilterChip('Critical', false),
//                 _buildFilterChip('New', false),
//               ],
//             ),
//           ),
//           SizedBox(height: 8),
//
//           // Patient list
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: patients.length,
//               itemBuilder: (context, index) {
//                 final patient = patients[index];
//                 return _buildPatientCard(context, patient);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilterChip(String label, bool isSelected) {
//     return Container(
//       margin: EdgeInsets.only(right: 8),
//       child: FilterChip(
//         label: Text(label),
//         selected: isSelected,
//         onSelected: (bool selected) {},
//         backgroundColor: Colors.grey[200],
//         selectedColor: Colors.blue[100],
//         checkmarkColor: Colors.blue[700],
//         labelStyle: TextStyle(
//           color: isSelected ? Colors.blue[700] : Colors.grey[700],
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPatientCard(BuildContext context, Map<String, dynamic> patient) {
//     final bool hasAppointmentToday = patient['nextAppointment'].toString().contains('Today');
//
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage('https://via.placeholder.com/50'),
//                   radius: 25,
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         patient['name'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         '${patient['age']} years • ${patient['condition']}',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.more_vert),
//                   onPressed: () {},
//                   color: Colors.grey[600],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Last Visit',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         patient['lastVisit'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Next Appointment',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         patient['nextAppointment'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: hasAppointmentToday ? Colors.blue[700] : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     icon: Icon(Icons.history),
//                     label: Text('History'),
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.blue,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: Icon(Icons.calendar_today),
//                     label: Text('Schedule'),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 5. Appointment Details Screen
// class AppointmentDetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointment Details'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Appointment status card
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Status',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.orange.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             'Waiting',
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Date',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'April 27, 2025',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'Time',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               '10:30 AM',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Divider(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Duration',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               '30 minutes',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'Type',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'Annual Check-up',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Patient information
//             Text(
//               'Patient Information',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: NetworkImage('https://via.placeholder.com/50'),
//                           radius: 25,
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Sarah Johnson',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 '42 years • Female',
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         OutlinedButton.icon(
//                           icon: Icon(Icons.visibility),
//                           label: Text('View'),
//                           onPressed: () {},
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(height: 24),
//                     _buildInfoRow('Phone', '(123) 456-7890'),
//                     SizedBox(height: 12),
//                     _buildInfoRow('Email', 'sarah.johnson@example.com'),
//                     SizedBox(height: 12),
//                     _buildInfoRow('Address', '123 Main St, Anytown, CA 94567'),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Notes section
//             Text(
//               'Notes',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       maxLines: 5,
//                       decoration: InputDecoration(
//                         hintText: 'Add appointment notes here...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         OutlinedButton.icon(
//                           icon: Icon(Icons.camera_alt),
//                           label: Text('Add Image'),
//                           onPressed: () {},
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: Colors.grey[700],
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         OutlinedButton.icon(
//                           icon: Icon(Icons.attach_file),
//                           label: Text('Attach File'),
//                           onPressed: () {},
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: Colors.grey[700],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Action buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     icon: Icon(Icons.calendar_today),
//                     label: Text('Reschedule'),
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.blue,
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: Icon(Icons.check_circle),
//                     label: Text('Complete'),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 80,
//           child: Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // 6. Doctor Profile Screen
// class DoctorProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text('Doctor Profile'),
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Container(
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 40,
//                           backgroundImage: NetworkImage('https://via.placeholder.com/80'),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Dr. Jane Smith',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Cardiologist',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.8),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.settings),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Professional details
//                   _buildSectionTitle('Professional Details'),
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           _buildProfileInfoRow('Specialization', 'Cardiology'),
//                           SizedBox(height: 12),
//                           _buildProfileInfoRow('Experience', '15 years'),
//                           SizedBox(height: 12),
//                           _buildProfileInfoRow('Education', 'MD, Harvard Medical School'),
//                           SizedBox(height: 12),
//                           _buildProfileInfoRow('License No.', 'MED12345678'),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 24),
//
//                   // Practice details
//                   _buildSectionTitle('Practice Details'),
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           _buildProfileInfoRow('Hospital', 'City General Hospital'),
//                           SizedBox(height: 12),
//                           _buildProfileInfoRow('Address', '456 Medical Plaza, Suite 302, Anytown, CA 94567'),
//                           SizedBox(height: 12),
//                           _buildProfileInfoRow('Phone', '(123) 456-7890'),
//                           SizedBox(height: 12),
//                           _buildProfileInfoRow('Email', 'dr.smith@cityhospital.org'),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 24),
//
//                   // Working hours
//                   _buildSectionTitle('Working Hours'),
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           _buildWorkingHoursRow('Monday', '9:00 AM - 5:00 PM'),
//                           _buildWorkingHoursRow('Tuesday', '9:00 AM - 5:00 PM'),
//                           _buildWorkingHoursRow('Wednesday', '9:00 AM - 1:00 PM'),
//                           _buildWorkingHoursRow('Thursday', '9:00 AM - 5:00 PM'),
//                           _buildWorkingHoursRow('Friday', '9:00 AM - 5:00 PM'),
//                           _buildWorkingHoursRow('Saturday', 'Closed'),
//                           _buildWorkingHoursRow('Sunday', 'Closed'),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 24),
//
//                   // Account settings
//                   _buildSectionTitle('Account Settings'),
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       children: [
//                         _buildSettingsItem(
//                           context,
//                           'Security',
//                           'Password, 2FA authentication',
//                           Icons.security,
//                         ),
//                         Divider(height: 1),
//                         _buildSettingsItem(
//                           context,
//                           'Notifications',
//                           'Configure alert preferences',
//                           Icons.notifications,
//                         ),
//                         Divider(height: 1),
//                         _buildSettingsItem(
//                           context,
//                           'Privacy',
//                           'Manage data sharing settings',
//                           Icons.privacy_tip,
//                         ),
//                         Divider(height: 1),
//                         _buildSettingsItem(
//                           context,
//                           'Help & Support',
//                           'Get assistance, report issues',
//                           Icons.help,
//                         ),
//                         Divider(height: 1),
//                         _buildSettingsItem(
//                           context,
//                           'Log Out',
//                           '',
//                           Icons.logout,
//                           textColor: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileInfoRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 100,
//           child: Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildWorkingHoursRow(String day, String hours) {
//     final bool isClosed = hours == 'Closed';
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             day,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             hours,
//             style: TextStyle(
//               color: isClosed ? Colors.red : Colors.green,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSettingsItem(
//       BuildContext context,
//       String title,
//       String subtitle,
//       IconData icon, {
//         Color? textColor,
//       }) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: textColor ?? Colors.grey[700],
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: textColor,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
//       trailing: Icon(Icons.chevron_right),
//       onTap: () {},
//     );
//   }
// }