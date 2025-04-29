import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctorapp/core/localization/bloc/language_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/doctor/data/datasources/doctor_remote_datasource.dart';
import '../../features/doctor/data/repositories/doctor_repository_impl.dart';
import '../../features/doctor/domain/repositories/doctor_repository.dart';
import '../../features/doctor/domain/usecases/appointments/cancel_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/complete_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/confirm_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/create_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/delete_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/get_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/get_appointments.dart';
import '../../features/doctor/domain/usecases/appointments/get_past_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/get_today_appointments.dart';
import '../../features/doctor/domain/usecases/appointments/get_upcoming_appointments.dart';
import '../../features/doctor/domain/usecases/appointments/mark_no_show.dart';
import '../../features/doctor/domain/usecases/appointments/reschedule_appointment.dart';
import '../../features/doctor/domain/usecases/appointments/update_appointment.dart';
import '../../features/doctor/domain/usecases/doctor/get_doctor_profile.dart';
import '../../features/doctor/domain/usecases/doctor/get_my_profile.dart';
import '../../features/doctor/domain/usecases/doctor/register_doctor.dart';
import '../../features/doctor/domain/usecases/doctor/update_doctor_profile.dart';
import '../../features/doctor/domain/usecases/schedule/create_schedule.dart';
import '../../features/doctor/domain/usecases/schedule/delete_schedule.dart';
import '../../features/doctor/domain/usecases/schedule/get_schedule.dart';
import '../../features/doctor/domain/usecases/schedule/get_schedules.dart';
import '../../features/doctor/domain/usecases/schedule/get_schedules_by_clinic.dart';
import '../../features/doctor/domain/usecases/schedule/get_schedules_by_doctor.dart';
import '../../features/doctor/domain/usecases/schedule/update_schedule.dart';
import '../../features/doctor/presentation/bloc/appointment/appointments_bloc.dart';
import '../../features/doctor/presentation/bloc/doctor/doctor_bloc.dart';
import '../../features/doctor/presentation/bloc/schedule/schedule_bloc.dart';
import '../../features/patient/doctor_search/data/datasources/doctor_remote_data_source.dart' as pd;
import '../../features/patient/doctor_search/data/repo/doctor_repo_impl.dart' as pd;
import '../../features/patient/doctor_search/domain/repo/doctor_repo.dart' as pd;
import '../../features/patient/doctor_search/presentation/bloc/search_doctor_bloc.dart';
import '../../features/patient/home/data/datasource/home_remote_data_source.dart';
import '../../features/patient/home/data/repo/home_repo_impl.dart';
import '../../features/patient/home/domain/repo/home_repo.dart';
import '../../features/patient/home/presentation/bloc/home_bloc.dart';
import 'package:event_bus/event_bus.dart';

import '../../features/patient/profile/presentation/bloc/profile_bloc.dart';
import '../../features/patient/registerpatient/data/repo/profile_repo_impl.dart';
import '../../features/patient/registerpatient/domain/repo/profile_repo.dart';
import '../api/api_client.dart';
import '../auth/auth_service.dart';

final sl = GetIt.instance;
final eventBus = EventBus();

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => eventBus);
  sl.registerFactory<LanguageBloc>(() => LanguageBloc());
  // Register AuthService
  sl.registerLazySingleton(() => AuthService(prefs: sl()));

  // Dio setup
  final dio = Dio(BaseOptions(
    baseUrl: 'http://128.140.39.237/api/v1',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add auth token interceptor - use the AuthService to get the token
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final authService = sl<AuthService>();
      final token = authService.token;
      log("token: ${token}");
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Token $token';
      }
      return handler.next(options);
    },
  ));

  sl.registerLazySingleton(() => dio);
  // sl.registerLazySingleton(() => DoctorService());
  // Register auth event listeners
  eventBus.on<UserLoggedInEvent>().listen((event) {
    // Update the Dio instance with the new token
    sl<Dio>().options.headers['Authorization'] = 'Bearer ${event.token}';
    log("Dio token updated: ${event.token}");
  });

  eventBus.on<UserLoggedOutEvent>().listen((_) {
    // Remove the auth token from Dio headers
    sl<Dio>().options.headers.remove('Authorization');
    log("Dio token removed");
  });


  //! Data sources
  sl.registerLazySingleton<pd.DoctorRemoteDataSource>(
        () => pd.DoctorRemoteDataSourceImpl(
          dio: sl()
    ),
  );

  //! Core
  sl.registerLazySingleton<ApiClient>(
        () => ApiClient(
      dio: sl(),
      secureStorage: sl(),
    ),
  );

  //! External
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<DoctorRemoteDataSource>(
        () => DoctorRemoteDataSourceImpl(sl()
    ),
  );


  // Repositories
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<pd.DoctorRepository>(
        () => pd.DoctorRepositoryImpl(
      remoteDataSource: sl(),
      // networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<DoctorRepository>(
        () => DoctorRepositoryImpl(
          sl()
    ),
  );

  // Doctor use cases
  sl.registerLazySingleton(() => GetMyProfile(sl()));
  sl.registerLazySingleton(() => GetDoctorProfile(sl()));
  sl.registerLazySingleton(() => UpdateDoctorProfile(sl()));
  sl.registerLazySingleton(() => RegisterDoctor(sl()));

  // Appointment use cases
  sl.registerLazySingleton(() => GetAppointments(sl()));
  sl.registerLazySingleton(() => GetPastAppointments(sl()));
  sl.registerLazySingleton(() => GetTodayAppointments(sl()));
  sl.registerLazySingleton(() => GetUpcomingAppointments(sl()));
  sl.registerLazySingleton(() => GetAppointment(sl()));
  sl.registerLazySingleton(() => CreateAppointment(sl()));
  sl.registerLazySingleton(() => UpdateAppointment(sl()));
  sl.registerLazySingleton(() => DeleteAppointment(sl()));
  sl.registerLazySingleton(() => CancelAppointment(sl()));
  sl.registerLazySingleton(() => CompleteAppointment(sl()));
  sl.registerLazySingleton(() => ConfirmAppointment(sl()));
  sl.registerLazySingleton(() => MarkNoShow(sl()));
  sl.registerLazySingleton(() => RescheduleAppointment(sl()));

  // Schedule use cases
  sl.registerLazySingleton(() => GetSchedules(sl()));
  sl.registerLazySingleton(() => GetSchedulesByClinic(sl()));
  sl.registerLazySingleton(() => GetSchedulesByDoctor(sl()));
  sl.registerLazySingleton(() => GetSchedule(sl()));
  sl.registerLazySingleton(() => CreateSchedule(sl()));
  sl.registerLazySingleton(() => UpdateSchedule(sl()));
  sl.registerLazySingleton(() => DeleteSchedule(sl()));

  // Blocs
  sl.registerFactory(() => HomeBloc(repository: sl()));
  sl.registerFactory(() => DoctorSearchBloc(repository: sl()));
  sl.registerFactory(() => ProfileBloc(profileRepository: sl()));

  // Doctor BLoC
  sl.registerFactory(
        () => DoctorBloc(
      getMyProfile: sl(),
      getDoctorProfile: sl(),
      updateDoctorProfile: sl(),
      registerDoctor: sl(),
    ),
  );

  // Appointment BLoC
  sl.registerFactory(
        () => AppointmentBloc(
      cancelAppointment: sl(),
      completeAppointment: sl(),
      confirmAppointment: sl(),
      createAppointment: sl(),
      deleteAppointment: sl(),
      getAppointment: sl(),
      getPastAppointments: sl(),
      getTodayAppointments: sl(),
      getUpcomingAppointments: sl(),
      markNoShow: sl(),
      rescheduleAppointment: sl(),
      updateAppointment: sl(),
    ),
  );

  // Schedule BLoC
  sl.registerFactory(
        () => ScheduleBloc(
      createSchedule: sl(),
      deleteSchedule: sl(),
      getSchedule: sl(),
      getSchedules: sl(),
      getSchedulesByClinic: sl(),
      getSchedulesByDoctor: sl(),
      updateSchedule: sl(),
    ),
  );
}

// Define event classes if not already defined
class UserLoggedInEvent {
  final String token;
  UserLoggedInEvent(this.token);
}

class UserLoggedOutEvent {}