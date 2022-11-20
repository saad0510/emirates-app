import 'package:flutter/material.dart';

import '../core/errors/exceptions.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/registration_screen.dart';
import '../features/flights/data/entities/flight.dart';
import '../features/flights/presentation/screens/boarding_pass_screen.dart';
import '../features/flights/presentation/screens/booking_screen.dart';
import '../features/flights/presentation/screens/choose_seats_screen.dart';
import '../features/flights/presentation/screens/payment_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/popular_destinations_screen.dart';

class AppRoutes {
  static const initial = onboard;

  static const onboard = "onboardScreen";
  static const auth = "authScreen";
  static const login = "loginScreen";
  static const register = "registerScreen";
  static const home = "homeScreen";
  static const booking = "bookingScreen";
  static const seats = "seatsScreen";
  static const payment = "paymentScreen";
  static const boardingPass = "boardingPassScreen";
  static const popularDestinations = "xScreen";
  // static const x = "xScreen";

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
          builder: (_) => HomeScreen(
            initialIndex: settings.arguments as int? ?? 0,
          ),
        );
      case booking:
        return MaterialPageRoute(
          builder: (_) => BookingScreen(
            flight: settings.arguments as Flight,
          ),
        );
      case seats:
        return MaterialPageRoute(
          builder: (_) => ChooseSeatsScreen(
            flight: settings.arguments as Flight,
          ),
        );
      case payment:
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            amount: settings.arguments as double,
          ),
        );
      case boardingPass:
        return MaterialPageRoute(
          builder: (_) => BoardingPassScreen(
            flight: settings.arguments as Flight,
          ),
        );
      case popularDestinations:
        return MaterialPageRoute(
          builder: (_) => const PopularDestinationsScreen(),
        );

      default:
        throw RouteException(settings.name ?? "", "route not found");
    }
  }
}
