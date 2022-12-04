import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/constants.dart';
import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/theme.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../widgets/drawer_item.dart';
import '../widgets/user_detail_header.dart';
import 'home_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.page, required this.controller});

  final Scaffold page;
  final AdvancedDrawerController controller;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdvancedDrawer(
        openRatio: 0.7,
        controller: widget.controller,
        animationCurve: Curves.easeInOutCubic,
        backdropColor: Theme.of(context).scaffoldBackgroundColor,
        childDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              color: AppColors.highlight,
            ),
          ],
        ),
        drawer: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    AppSizes.normalY,
                    const UserDetailHeader(),
                    const Spacer(),
                    AppSizes.normalY,
                    DrawerItem(
                      label: "My Profile",
                      icon: Icons.person_outline,
                      onPressed: () {
                        context.replace(AppRoutes.home, arguments: HomeScreen.profileIndex);
                      },
                    ),
                    DrawerItem(
                      label: "My Trips",
                      icon: Icons.calendar_today_outlined,
                      onPressed: () {
                        context.replace(AppRoutes.home, arguments: HomeScreen.tripsIndex);
                      },
                    ),
                    DrawerItem(
                      label: "Book a flight",
                      icon: Icons.flight,
                      onPressed: () {
                        context.replace(AppRoutes.home, arguments: HomeScreen.searchIndex);
                      },
                    ),
                    DrawerItem(
                      label: "Dark Mode",
                      isSwitch: true,
                      icon: Icons.dark_mode_outlined,
                      switchWidget: Switch.adaptive(
                        value: context.isDarkMode,
                        activeColor: context.primaryColor,
                        onChanged: (_) {
                          context.read<AppTheme>().toggleTheme();
                        },
                      ),
                    ),
                    DrawerItem(
                      label: "Share App",
                      icon: Icons.share,
                      onPressed: () {
                        Share.share("Check out this flight booking app on ${AppConstants.playstoreLink}");
                      },
                    ),
                    AppSizes.maxY,
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: AppPaddings.smallX,
                        foregroundColor: context.primaryColor,
                        textStyle: context.textTheme.bodyText2,
                      ),
                      onPressed: logout,
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text("Logout"),
                    ),
                    AppSizes.normalY,
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.page,
            _PageBlurWidget(controller: widget.controller),
          ],
        ),
      ),
    );
  }

  void logout() {
    context.read<AuthController>().logout();
  }
}

class _PageBlurWidget extends StatelessWidget {
  const _PageBlurWidget({required this.controller});

  final AdvancedDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdvancedDrawerValue>(
      valueListenable: controller,
      builder: (_, value, __) {
        return Visibility(
          visible: controller.value.visible,
          replacement: Container(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
