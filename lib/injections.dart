import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/repositories/auth_repo.dart';
import 'features/auth/datasources/repositories/auth_repo_imp.dart';
import 'features/auth/datasources/sources/auth_remote_src.dart';
import 'features/auth/datasources/sources/auth_supabase_src.dart';
import 'features/auth/presentation/controllers/auth/auth_controller.dart';
import 'features/auth/presentation/controllers/onboarding_controller.dart';

class Injections {
  static const supabaseUrl = "https://owquxhlxmutcrcifvfsy.supabase.co";
  static const supabaseAnonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im93cXV4aGx4bXV0Y3JjaWZ2ZnN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjkxMDMwOTUsImV4cCI6MTk4NDY3OTA5NX0._hxo7zlCRr1FPYSu19l61sAva6KTEQuWv7VwDEbAsk8";

  static final inject = GetIt.instance;

  final appProviders = <ChangeNotifierProvider>[
    ChangeNotifierProvider<OnBoardingController>(
      create: (_) => OnBoardingController(),
    ),
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(repo: inject()),
    ),
  ];

  Future<void> init() async {
    final supabase = await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );

    // repos
    inject.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(remoteSrc: inject()),
    );

    // sources
    inject.registerLazySingleton<AuthRemoteSrc>(
      () => AuthSupabaseSrc(client: supabase.client),
    );

    // third-party
  }
}
