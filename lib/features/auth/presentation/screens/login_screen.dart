import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/auth_state.dart';
import '../widgets/login_form.dart';
import '../widgets/text_action_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        title: const Text("Login"),
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
                    "Welcome\nBack!",
                    style: context.textTheme.headline1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: AppPaddings.normalY,
                      child: const LoginForm(),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: AppPaddings.normalY,
                      child: TextActionButton(
                        leading: "Don't have an account? ",
                        highlight: "Sign up",
                        onPressed: () {
                          context.replace(AppRoutes.register);
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
