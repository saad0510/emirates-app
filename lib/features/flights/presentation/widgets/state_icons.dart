import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';

class NotFoundIcon extends StatelessWidget {
  const NotFoundIcon({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizes.maxY,
        Image.asset(
          AppAssets.noResults,
          width: 400.sp,
        ),
        AppSizes.normalY,
        Text(
          message,
          style: context.textTheme.headline5!.regular,
        ),
      ],
    );
  }
}

class WelcomeIcon extends StatelessWidget {
  const WelcomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizes.normalY,
        Image.asset(
          AppAssets.startTravel,
          width: 250.sp,
        ),
        Text(
          'Start travelling with us!',
          style: context.textTheme.headline5!.regular,
        ),
      ],
    );
  }
}

class ErrorIcon extends StatelessWidget {
  const ErrorIcon({super.key, required this.errorMsg});

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizes.normalY,
        Image.asset(
          AppAssets.error,
          color: context.contrastColor,
          width: 180.sp,
        ),
        AppSizes.normalY,
        Text(
          'An error occured!\n$errorMsg',
          textAlign: TextAlign.center,
          style: context.textTheme.headline5!.regular,
        ),
      ],
    );
  }
}
