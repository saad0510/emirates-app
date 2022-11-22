import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/utils/form_validations.dart';
import '../../data/entities/user_data.dart';
import '../controllers/auth/auth_controller.dart';
import 'auth_text_field.dart';
import '../controllers/auth/auth_widget.dart';
import 'text_action_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  bool checked = false;

  String name = '';
  String email = '';
  String password = '';

  void submit(AuthController auth) {
    if (!mounted) return;
    final validated = formKey.currentState!.validate();
    if (!validated) return;
    formKey.currentState!.save();
    auth.register(
      UserData(name: name, email: email),
      password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            label: "Full Name",
            hint: "Enter your full name",
            onSubmit: (x) => name = x,
            validator: FormValidations.name,
          ),
          AppSizes.smallY,
          AuthTextField(
            label: "Email",
            hint: "Enter your email",
            onSubmit: (x) => email = x,
            validator: FormValidations.email,
          ),
          AppSizes.smallY,
          AuthTextField(
            label: "Password",
            hint: "Enter your password",
            obscure: true,
            onSubmit: (x) => password = x,
            validator: FormValidations.password,
          ),
          AppSizes.normalY,
          CheckboxListTile(
            value: checked,
            onChanged: (x) => setState(() => checked = x ?? false),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: TextActionButton(
              leading: "I agree to the ",
              highlight: "Terms & Conditions and Privacy Policy",
              onPressed: () {},
            ),
          ),
          AppSizes.normalY,
          const Spacer(),
          AuthWidget(
            onLoading: (_, auth) => const Center(child: CircularProgressIndicator()),
            builder: (_, auth) => ElevatedButton(
              onPressed: checked ? () => submit(auth) : null,
              child: const Text("Create account"),
            ),
          ),
        ],
      ),
    );
  }
}
