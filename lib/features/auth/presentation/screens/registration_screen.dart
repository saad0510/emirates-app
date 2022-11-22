import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/auth_state.dart';
import '../widgets/register_form.dart';
import '../widgets/text_action_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Registration"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: AppPaddings.normalXY,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create\nAccount",
                    style: context.textTheme.headline1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: AppPaddings.normalY,
                      child: const RegisterForm(),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: AppPaddings.normalY,
                      child: TextActionButton(
                        leading: "Already have an account? ",
                        highlight: "Login",
                        onPressed: () {
                          context.replace(AppRoutes.login);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleState() {
    if (!mounted) return;

    final state = controller.state;
    if (state is AuthLoadedState) {
      context.replaceAll(AppRoutes.home);
    } else if (state is AuthErrorState) {
      context.showErrorSnackBar(message: state.failure.message);
    }
  }
}
