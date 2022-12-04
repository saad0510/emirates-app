import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../../common/presentation/widgets/user_image_card.dart';
import '../../../flights/presentation/widgets/booking_screen_field.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalXY,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 100.sp,
                backgroundImage: const NetworkImage(
                  UserImageCard.imageUrl,
                  scale: 10,
                ),
              ),
            ),
            AppSizes.maxY,
            BookingScreenField(label: "Name", title: user.name),
            BookingScreenField(label: "Email", title: user.email),
            BookingScreenField(
              label: "Age",
              title: "${user.age}",
            ),
            BookingScreenField(
              label: "Date of Birth",
              title: "${user.birthDate}".substring(0, 10),
            ),
          ],
        ),
      ),
    );
  }
}
