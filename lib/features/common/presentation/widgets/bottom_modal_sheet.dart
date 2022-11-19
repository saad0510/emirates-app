import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';

class BottomModalSheet {
  BottomModalSheet._();

  static Future<void> show(BuildContext context, {Widget? child}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      constraints: BoxConstraints(maxHeight: context.height * 0.8),
      builder: (_) => Padding(
        padding: AppPaddings.normalXY.copyWith(
          bottom: context.keyboardHeight + 20.sp,
        ),
        child: child,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
    );
  }
}
