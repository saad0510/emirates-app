import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../widgets/login_form.dart';
import '../widgets/text_action_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
}
