import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/utils/form_validations.dart';
import 'auth_text_field.dart';
import 'text_action_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthTextField(
            label: "Full Name",
            hint: "Enter your full name",
            validator: FormValidations.name,
          ),
          AppSizes.smallY,
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
          ElevatedButton(
            onPressed: checked ? () {} : null,
            child: const Text("Create account"),
          ),
        ],
      ),
    );
  }
}
