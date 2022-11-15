import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/section_divider.dart';
import '../widgets/social_auth_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: AppPaddings.normalXY,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Center(
                    child: Image.asset(
                      AppAssets.logo,
                      color: context.primaryColor,
                      alignment: Alignment.center,
                      width: 250.sp,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      context.push(AppRoutes.login);
                    },
                    child: const Text("Login"),
                  ),
                  AppSizes.smallY,
                  ElevatedButton(
                    onPressed: () {
                      context.push(AppRoutes.register);
                    },
                    child: const Text("Sign up"),
                  ),
                  Padding(
                    padding: AppPaddings.normalY,
                    child: SectionDivider(text: "or"),
                  ),
                  SocialAuthButton(
                    label: "Continue with Google",
                    iconPath: AppAssets.googleIcon,
                    onPressed: () {},
                  ),
                  AppSizes.smallY,
                  SocialAuthButton(
                    label: "Continue with Facebook",
                    iconPath: AppAssets.facebookIcon,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
