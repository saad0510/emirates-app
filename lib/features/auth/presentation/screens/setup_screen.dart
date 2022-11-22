import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/auth_state.dart';

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

  void handleState() {
    if (!mounted) return;

    final state = controller.state;
    if (state is AuthLoadedState) {
      context.replaceAll(AppRoutes.home);
    } else if (state is AuthEmptyState) {
      context.replaceAll(AppRoutes.auth);
    }
  }
}