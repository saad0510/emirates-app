import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: BlackColor.normal, width: 0.8),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          textStyle: context.textTheme.headline6!.medium,
        ),
        icon: Image.asset(iconPath, width: 25.sp),
        label: Text(" $label"),
      ),
    );
  }
}
