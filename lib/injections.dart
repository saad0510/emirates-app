import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/constants.dart';
import 'features/auth/data/repositories/auth_repo.dart';
import 'features/auth/datasources/repositories/auth_repo_imp.dart';
import 'features/auth/datasources/sources/auth_remote_src.dart';
import 'features/auth/datasources/sources/auth_supabase_src.dart';
import 'features/auth/presentation/controllers/auth/auth_controller.dart';
import 'features/auth/presentation/controllers/onboarding_controller.dart';
import 'features/flights/data/repositories/city_repo.dart';
import 'features/flights/data/repositories/flight_repo.dart';
import 'features/flights/data/repositories/ticket_repo.dart';
import 'features/flights/datasources/repositories/city_repo_imp.dart';
import 'features/flights/datasources/repositories/flight_repo_imp.dart';
import 'features/flights/datasources/repositories/ticket_repo_imp.dart';
import 'features/flights/datasources/sources/city_remote_src.dart';
import 'features/flights/datasources/sources/city_supabase_src.dart';
import 'features/flights/datasources/sources/flight_remote_src.dart';
import 'features/flights/datasources/sources/flight_supabase_src.dart';
import 'features/flights/datasources/sources/ticket_remote_src.dart';
import 'features/flights/datasources/sources/ticket_supabase_src.dart';
import 'features/flights/presentation/controllers/city_controller.dart';
import 'features/flights/presentation/controllers/flight/flight_controller.dart';
import 'features/flights/presentation/controllers/ticket/ticket_controller.dart';
import 'features/home/data/entities/notification_data.dart';
import 'features/home/presentation/controllers/notification_controller.dart';

class Injections {
  static final inject = GetIt.instance;

  final appProviders = <ChangeNotifierProvider>[
    ChangeNotifierProvider<OnBoardingController>(
      create: (_) => OnBoardingController(),
    ),
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(repo: inject()),
    ),
    ChangeNotifierProvider<CityController>(
      create: (_) => CityController(repo: inject()),
    ),
    ChangeNotifierProvider<FlightController>(
      create: (_) => FlightController(repo: inject()),
    ),
    ChangeNotifierProvider<TicketController>(
      create: (_) => TicketController(repo: inject()),
    ),
    ChangeNotifierProvider<NotificationController>(
      create: (_) => NotificationController(
        notify: AwesomeNotifications(),
      ),
    ),
  ];

  Future<void> init() async {
    final supabase = await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
    // repos
    inject.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(remoteSrc: inject()),
    );
    inject.registerLazySingleton<CityRepo>(
      () => CityRepoImp(remoteSrc: inject()),
    );
    inject.registerLazySingleton<FlightRepo>(
      () => FlightRepoImp(remoteSrc: inject()),
    );
    inject.registerLazySingleton<TicketRepo>(
      () => TicketRepoImp(remoteSrc: inject()),
    );

    // sources
    inject.registerLazySingleton<AuthRemoteSrc>(
      () => AuthSupabaseSrc(client: supabase.client),
    );
    inject.registerLazySingleton<CityRemoteSrc>(
      () => CitySupabaseSrc(client: supabase.client),
    );
    inject.registerLazySingleton<FlightRemoteSrc>(
      () => FlightSupabaseSrc(client: supabase.client),
    );
    inject.registerLazySingleton<TicketRemoteSrc>(
      () => TicketSupabaseSrc(client: supabase.client),
    );

    // for notifications
    await AwesomeNotifications().initialize(
      "resource://drawable/logo",
      [
        NotificationChannel(
          channelKey: NotificationData.basicChannel,
          channelName: 'Flight notifications',
          channelDescription: 'Notification channel for flight reminders',
          channelShowBadge: true,
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    );
  }
}
