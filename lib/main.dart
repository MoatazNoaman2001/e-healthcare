import 'dart:io';

import 'package:doctorapp/features/doctor/homedoctor/presentation/screens/home_screen.dart';
import 'package:doctorapp/features/patient/doctors/presentation/screens/doctor_profile_screen.dart';
import 'package:doctorapp/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:doctorapp/features/splash/presentation/screens/splash_screen.dart';
import 'package:doctorapp/features/user_selection/presentation/screens/user_selection_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import the DoctorProfileScreen
// Import the PatientListScreen
// Import the AppointmentDetailsScreen
// Import the PatientsScreen
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'core/di/dependancy_injection.dart' as di;
import 'features/patient/home/presentation/bloc/home_bloc.dart';


Future<void> main() async{
  final Map<String, List<String>> structure = {
    'lib/features/appointments/data': [],
    'lib/features/appointments/domain': [],
    'lib/features/appointments/presentation/bloc': [
      'appointment_booking_bloc.dart',
      'appointment_booking_event.dart',
      'appointment_booking_state.dart',
    ],
    'lib/features/appointments/presentation/screens': [
      'appointment_booking_screen.dart',
    ],
  };


  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (context) => di.sl<HomeBloc>(),)
        // Other blocs...
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طبيبي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF006272),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006272),
          primary: const Color(0xFF006272),
          secondary: const Color(0xFF4CAF50),
          tertiary: const Color(0xFFE3F2FD),
          // ignore: deprecated_member_use
          background: Colors.white,
        ),
        textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006272),
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF006272),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF006272),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFF006272)), // اللون الجديد
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF006272), // اللون الجديد
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        // '/doctor_home_screen': (context) => const HomeScreen(),
        '/doctor_profile_screen':
            (context) => const DoctorProfileScreen(
              doctorName: 'نورا',
              rating: 5,
              specialty: 'gbgg',
              experience: '',
            ),

        //  '/appointment_details_screen':
        //    (context) => AppointmentDetailsScreen(
        //      patientName: 'محمد أحمد',
        //       appointmentTime: '10:00 AM',
        //       appointmentType: 'استشارة',
        //     ),
        '/HomeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
