import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/user_image_card.dart';

class UserDetailHeader extends StatelessWidget {
  const UserDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: UserImageCard(height: 50.h),
        ),
        AppSizes.smallY,
        Text(
          "James Bond",
          style: context.textTheme.headline4,
        ),
        Text(
          "infoabraham12@gmail.com",
          style: context.textTheme.bodyText2,
        ),
      ],
    );
  }
}
