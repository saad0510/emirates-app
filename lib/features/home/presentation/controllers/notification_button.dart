import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../core/extensions/context_ext.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.push(AppRoutes.notification),
      icon: const Icon(Icons.notifications),
    );
  }
}
