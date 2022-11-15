import 'package:flutter/material.dart';

import '../core/errors/exceptions.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/registration_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

class AppRoutes {
  static const initial = onboard;

  static const onboard = "onboardScreen";
  static const auth = "authScreen";
  static const login = "loginScreen";
  static const register = "registerScreen";
  static const home = "homeScreen";
  // static const  = "Screen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboard:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case auth:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegistrationScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      default:
        throw RouteException(settings.name ?? "", "route not found");
    }
  }
}
