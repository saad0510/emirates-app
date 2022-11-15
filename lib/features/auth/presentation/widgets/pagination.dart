import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';

class Pagination extends StatelessWidget {
  const Pagination({super.key, required this.count, this.active = 0});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        count,
        (i) => Padding(
          padding: AppPaddings.extraSmallX,
          child: CircleAvatar(
            radius: 6.sp,
            backgroundColor: i == active ? context.primaryColor : context.highlightColor,
          ),
        ),
      ),
    );
  }
}
