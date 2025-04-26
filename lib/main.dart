import 'dart:io';
import 'package:doctorapp/core/localization/bloc/language_bloc.dart';
import 'package:doctorapp/features/doctor/homedoctor/presentation/screens/home_screen.dart';
import 'package:doctorapp/features/patient/appointments/presentation/screens/appointments_screen.dart';
import 'package:doctorapp/features/patient/appointments_booking/presentation/screens/appointment_booking_screen.dart';
import 'package:doctorapp/features/patient/doctors/presentation/screens/doctor_profile_screen.dart';
import 'package:doctorapp/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:doctorapp/features/splash/presentation/screens/splash_screen.dart';
import 'package:doctorapp/features/user_selection/presentation/screens/user_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/di/dependancy_injection.dart' as di;
import 'features/patient/home/presentation/bloc/home_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (context) => di.sl<HomeBloc>()),
          BlocProvider(create: (context) => di.sl<LanguageBloc>()),
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
      theme: ThemeData(
        primaryColor: const Color(0xFF006272),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006272),
          primary: const Color(0xFF006272),
          secondary: const Color(0xFF4CAF50),
          tertiary: const Color(0xFFE3F2FD),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          iconTheme: IconThemeData(color: Color(0xFF006272)),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF006272),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/doctor_profile_screen': (context) => const DoctorProfileScreen(
              
            ),
        '/HomeScreen': (context) => const HomeScreen(),
         '/book-appointment': (context) => const DoctorProfileScreen(),
  // '/doctor-details': (context) => const DoctorDetailsScreen()
      },
    );
  }
}
