import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.switchWidget,
    this.isSwitch = false,
  });

  final String label;
  final bool isSwitch;
  final IconData icon;
  final Widget? switchWidget;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            Container(
              width: 50.sp,
              height: 50.sp,
              decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: borderRadius,
              ),
              child: Icon(
                icon,
                size: 32.sp,
                color: context.primaryColor,
              ),
            ),
            AppSizes.normalX,
            Opacity(
              opacity: 0.8,
              child: Text(
                label,
                style: context.textTheme.bodyText1?.regular,
              ),
            ),
            const Spacer(),
            if (isSwitch) switchWidget!,
          ],
        ),
      ),
    );
  }
}
