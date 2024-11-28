import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pet_style_mobile/core/services/firebase_messaging_services.dart';
import 'package:pet_style_mobile/core/services/interceptors/auth_interceptor.dart';
import 'package:pet_style_mobile/core/services/media_services.dart';
import 'package:pet_style_mobile/core/services/socket_service.dart';
import 'package:pet_style_mobile/src/data/repository/appointment_repository_impl.dart';
import 'package:pet_style_mobile/src/data/repository/auth_repository_impl.dart';
import 'package:pet_style_mobile/src/data/repository/device_repository_impl.dart';
import 'package:pet_style_mobile/src/data/repository/otp_repository_impl.dart';
import 'package:pet_style_mobile/src/data/repository/pet_repository_impl.dart';
import 'package:pet_style_mobile/src/data/repository/user_repository_impl.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/device_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/otp_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/pet_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DependencyInjector {
  static final GetIt _getIt = GetIt.instance;

  static void setup(Talker talker) {
    final dio = Dio();
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestData: false,
        ),
      ),
    );

    _getIt.registerSingleton<Dio>(
      dio,
    );

    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dio: dio),
    );

    _getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(dio: dio),
    );

    _getIt.registerLazySingleton<PetRepository>(
      () => PetRepositoryImpl(dio: dio),
    );

    _getIt.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(dio: dio),
    );

    _getIt.registerLazySingleton<OtpRepository>(
      () => OtpRepositoryImpl(dio: dio),
    );

    _getIt.registerLazySingleton<DeviceRepository>(
      () => DeviceRepositoryImpl(dio: dio),
    );

    _getIt.registerLazySingleton<InternetConnection>(
      () => InternetConnection(),
    );

    _getIt.registerLazySingleton<SocketService>(
      () => SocketService(),
    );

    _getIt.registerSingleton<MediaServices>(
      MediaServices(),
    );

    _getIt.registerSingleton<FirebaseMessagingServices>(
      FirebaseMessagingServices(dio: dio),
    );

    dio.interceptors.add(AuthInterceptor(dio: dio));
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
