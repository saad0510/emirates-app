import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../widgets/popular_destinations_list.dart';
import '../widgets/view_all_section.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalX,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Hello! ${user.name}",
              style: context.textTheme.bodyText1?.colored,
            ),
            Text(
              "Where are you going?",
              style: context.textTheme.headline1,
            ),
            const Divider(height: 50),
            Container(
              height: 360.h,
              margin: AppPaddings.normalY,
              child: ViewAllSection(
                title: "Popular Places",
                onPressed: () => context.push(AppRoutes.popularDestinations),
                child: const Expanded(
                  child: PopularDestinationsList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
