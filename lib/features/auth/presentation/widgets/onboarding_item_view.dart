import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../data/entities/onboarding_item.dart';

class OnBoardingItemView extends StatelessWidget {
  const OnBoardingItemView({super.key, required this.item});

  final OnBoardingItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          item.image,
          height: 200.h,
          fit: BoxFit.contain,
        ),
        AppSizes.normalY,
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: context.textTheme.headline1,
        ),
        AppSizes.normalY,
        Text(
          item.subtitle,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyText2!.light,
        ),
      ],
    );
  }
}
