import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import 'dashed_line.dart';
import 'ticket_clipper.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key, this.upper, this.lower});

  final Widget? upper;
  final Widget? lower;

  @override
  Widget build(BuildContext context) {
    final color = context.backgroundColor;
    final padding = EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: upper,
          ),
          ClipPath(
            clipper: TicketClipper(radius: 25.sp),
            child: Container(
              height: 25.h,
              color: color,
              padding: AppPaddings.normalX,
              child: const DashedLine(),
            ),
          ),
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: lower,
          ),
        ],
      ),
    );
  }
}
