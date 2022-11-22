import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_controller.dart';
import 'auth_state.dart';

typedef AuthWidgetBuilder = Widget Function(BuildContext context, AuthController controller);

class AuthWidget extends StatefulWidget {
  const AuthWidget({
    super.key,
    required this.builder,
    this.onLoading,
    this.onError,
  });

  final AuthWidgetBuilder builder;
  final AuthWidgetBuilder? onLoading;
  final AuthWidgetBuilder? onError;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  late final controller = context.watch<AuthController>();

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    if (widget.onLoading != null && state is AuthLoadingState) {
      return widget.onLoading!(context, controller);
    }
    if (widget.onError != null && state is AuthErrorState) {
      return widget.onError!(context, controller);
    }
    return widget.builder(context, controller);
  }
}
