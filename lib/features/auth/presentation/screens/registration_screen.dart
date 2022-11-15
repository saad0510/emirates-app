import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../widgets/register_form.dart';
import '../widgets/text_action_button.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
}
