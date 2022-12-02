import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/dashed_line.dart';

class FlightTravelLine extends StatelessWidget {
  const FlightTravelLine({
    super.key,
    required this.from,
    required this.to,
    required this.color,
  });

  final String from;
  final String to;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Alignment alignment = Alignment.bottomCenter;

    return Column(
      children: [
        AppSizes.maxY,
        Text(
          from,
          style: context.textTheme.headline2,
        ),
        AppSizes.smallY,
        CircleAvatar(
          radius: 5.sp,
          backgroundColor: context.primaryColor,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 400.h,
              child: const DashedLine(
                count: 30,
                axis: Axis.vertical,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                Future.delayed(
                  Duration.zero,
                  () => setState(() => alignment = Alignment.topCenter),
                );

                return AnimatedAlign(
                  duration: const Duration(seconds: 30),
                  alignment: alignment,
                  heightFactor: 12,
                  child: Icon(Icons.flight, size: 32.sp, color: color),
                );
              },
            ),
          ],
        ),
        CircleAvatar(
          radius: 5.sp,
          backgroundColor: context.primaryColor,
        ),
        Text(
          to,
          style: context.textTheme.headline2,
        ),
      ],
    );
  }
}
