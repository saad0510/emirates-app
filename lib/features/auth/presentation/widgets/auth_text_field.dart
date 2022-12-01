import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.validator,
    this.keyboardType,
    required this.onSubmit,
    this.controller,
  });

  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String) onSubmit;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: context.textTheme.bodyText1,
        ),
        AppSizes.smallY,
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscure && show,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          style: context.textTheme.bodyText2?.copyWith(
            color: context.contrastColor.withOpacity(0.9),
            letterSpacing: widget.obscure && show ? 3 : null,
          ),
          validator: widget.validator,
          onSaved: (x) => widget.onSubmit(x?.trim() ?? ''),
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: !widget.obscure
                ? null
                : IconButton(
                    splashRadius: 1,
                    icon: Icon(
                      show //
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () => setState(() => show = !show),
                  ),
          ),
        ),
      ],
    );
  }
}
