import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/utils/form_validations.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/auth_widget.dart';
import 'auth_text_field.dart';
import 'text_action_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String pass = '';

  void submit(AuthController auth) {
    if (!mounted) return;
    final validated = formKey.currentState!.validate();
    if (!validated) return;
    formKey.currentState!.save();
    auth.login(email, pass);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            label: "Email",
            hint: "Enter your email",
            onSubmit: (x) => email = x,
            validator: FormValidations.email,
            keyboardType: TextInputType.emailAddress,
          ),
          AppSizes.smallY,
          AuthTextField(
            label: "Password",
            hint: "Enter your password",
            obscure: true,
            onSubmit: (x) => pass = x,
            validator: FormValidations.password,
            keyboardType: TextInputType.visiblePassword,
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
          AuthWidget(
            onLoading: (_, auth) => const Center(child: CircularProgressIndicator()),
            builder: (_, auth) => ElevatedButton(
              onPressed: () => submit(auth),
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
