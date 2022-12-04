import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../home/presentation/controllers/notification_controller.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/auth_state.dart';
import '../controllers/onboarding_controller.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  late final controller = context.read<AuthController>();

  @override
  void initState() {
    controller.addListener(handleState);
    final notify = context.read<NotificationController>();

    notify.requestPermission();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.ignoreAction,
      onNotificationDisplayedMethod: notify.onNotificationDisplayed,
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(handleState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void handleState() async {
    if (!mounted) return;

    final onboard = context.read<OnBoardingController>();
    if (!await onboard.isSeen) {
      context.replaceAll(AppRoutes.onboard);
      onboard.markAsSeen();
      return;
    }

    final state = controller.state;
    if (state is AuthLoadedState) {
      context.replaceAll(AppRoutes.home);
      return;
    }

    if (state is AuthEmptyState) {
      context.replaceAll(AppRoutes.auth);
    }
  }
}
