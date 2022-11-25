import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../../common/presentation/widgets/user_image_card.dart';

class UserDetailHeader extends StatelessWidget {
  const UserDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

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
          user.name,
          style: context.textTheme.headline4,
        ),
        Text(
          user.email,
          style: context.textTheme.bodyText2,
        ),
      ],
    );
  }
}
