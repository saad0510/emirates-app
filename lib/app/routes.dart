import 'package:flutter/material.dart';

import '../core/errors/exceptions.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/registration_screen.dart';
import '../features/auth/presentation/screens/setup_screen.dart';
import '../features/flights/data/entities/ticket.dart';
import '../features/flights/presentation/controllers/booking/booking_controller.dart';
import '../features/flights/presentation/screens/boarding_pass_screen.dart';
import '../features/flights/presentation/screens/booking_screen.dart';
import '../features/flights/presentation/screens/choose_seats_screen.dart';
import '../features/flights/presentation/screens/order_summary_screen.dart';
import '../features/flights/presentation/screens/payment_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/notification_screen.dart';

class AppRoutes {
  static const initial = setup;

  static const setup = "setupScreen";
  static const onboard = "onboardScreen";
  static const auth = "authScreen";
  static const login = "loginScreen";
  static const register = "registerScreen";
  static const home = "homeScreen";
  static const booking = "bookingScreen";
  static const seats = "seatsScreen";
  static const orderSummary = "orderSummaryScreen";
  static const payment = "paymentScreen";
  static const boardingPass = "boardingPassScreen";
  static const popularDestinations = "xScreen";
  static const notification = "notificationScreen";
  // static const x = "xScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case setup:
        return MaterialPageRoute(
          builder: (_) => const SetupScreen(),
        );
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
          builder: (_) => const BookingScreen(),
        );
      case seats:
        return MaterialPageRoute(
          builder: (_) => ChooseSeatsScreen(
            onSelect: settings.arguments as void Function(String),
          ),
        );
      case orderSummary:
        return MaterialPageRoute(
          builder: (_) => OrderSummaryScreen(
            controller: settings.arguments as BookingController,
          ),
        );
      case payment:
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            controller: settings.arguments as BookingController,
          ),
        );
      case boardingPass:
        return MaterialPageRoute(
          builder: (_) => BoardingPassScreen(
            tickets: settings.arguments as List<Ticket>,
          ),
        );

      case notification:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );

      default:
        throw RouteException(settings.name ?? "", "route not found");
    }
  }
}
