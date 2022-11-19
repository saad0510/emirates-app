import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, this.child, this.onPressed});

  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: context.primaryColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
