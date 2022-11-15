import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/form_validations.dart';
import 'auth_text_field.dart';
import 'text_action_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  void submit() {
    context.replaceAll(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthTextField(
            label: "Email",
            hint: "Enter your email",
            validator: FormValidations.email,
          ),
          AppSizes.smallY,
          const AuthTextField(
            label: "Password",
            hint: "Enter your password",
            obscure: true,
            validator: FormValidations.password,
          ),
          AppSizes.smallY,
          Align(
            alignment: Alignment.centerRight,
            child: TextActionButton(
              highlight: "Forgot Password?",
              underline: false,
              onPressed: () {},
            ),
          ),
          AppSizes.normalY,
          const Spacer(),
          ElevatedButton(
            onPressed: submit,
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
