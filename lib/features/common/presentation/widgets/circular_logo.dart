import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/theme/colors.dart';

class CircularLogo extends StatelessWidget {
  const CircularLogo({this.radius, super.key});

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 30.sp,
      backgroundColor: AppColors.primary,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 1,
        child: Image.asset(
          AppAssets.logo,
          color: AppColors.white,
        ),
      ),
    );
  }
}
