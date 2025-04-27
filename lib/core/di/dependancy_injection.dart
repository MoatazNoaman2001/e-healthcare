import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';

import '../../features/patient/doctor_search/data/datasources/doctor_remote_data_source.dart';
import '../../features/patient/doctor_search/data/repo/doctor_repo_impl.dart';
import '../../features/patient/doctor_search/domain/repo/doctor_repo.dart';
import '../../features/patient/doctor_search/presentation/bloc/search_doctor_bloc.dart';
import '../../features/patient/home/data/datasource/home_remote_data_source.dart';
import '../../features/patient/home/data/repo/home_repo_impl.dart';
import '../../features/patient/home/domain/repo/home_repo.dart';
import '../../features/patient/home/presentation/bloc/home_bloc.dart';
import '../../features/patient/profile/presentation/bloc/profile_bloc.dart';
import '../../features/patient/registerpatient/data/repo/profile_repo_impl.dart';
import '../../features/patient/registerpatient/domain/repo/profile_repo.dart';
import '../../features/patient/edit_profile/presentation/bloc/edit_profile_bloc.dart'; // أضفنا ده
import '../../features/doctor/doctor_profile/data/services/doctor_service.dart';
import '../auth/auth_service.dart';
import '../localization/bloc/language_bloc.dart';

final sl = GetIt.instance;
final eventBus = EventBus();

Future<void> init() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // EventBus
  sl.registerLazySingleton(() => eventBus);

  // Language Bloc
  sl.registerFactory<LanguageBloc>(() => LanguageBloc());

  // AuthService
  sl.registerLazySingleton(() => AuthService(prefs: sl()));

  // Dio setup
  final dio = Dio(BaseOptions(
    baseUrl: 'http://128.140.39.237/api/v1', // غيريه لو عندك API جديد
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Dio Interceptor (to add token)
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

  // Doctor Service
  sl.registerLazySingleton(() => DoctorService());

  // Event Listeners for login/logout
  eventBus.on<UserLoggedInEvent>().listen((event) {
    sl<Dio>().options.headers['Authorization'] = 'Bearer ${event.token}';
    log("Dio token updated: ${event.token}");
  });

  eventBus.on<UserLoggedOutEvent>().listen((_) {
    sl<Dio>().options.headers.remove('Authorization');
    log("Dio token removed");
  });

  // Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // Blocs
  sl.registerFactory(() => HomeBloc(repository: sl()));
  sl.registerFactory(() => DoctorSearchBloc(repository: sl()));
  sl.registerFactory(() => ProfileBloc(profileRepository: sl()));
  sl.registerFactory(() => EditProfileBloc()); // 🛠️ سجلنا EditProfileBloc هنا
}

// Event classes
class UserLoggedInEvent {
  final String token;
  UserLoggedInEvent(this.token);
}

class UserLoggedOutEvent {}
