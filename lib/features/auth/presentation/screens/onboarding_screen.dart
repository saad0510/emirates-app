import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_item_view.dart';
import '../widgets/pagination.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final controller = context.watch<OnBoardingController>();

    void toAuthScreen() => context.replace(AppRoutes.auth);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: toAuthScreen,
            child: const Text("Skip"),
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (i) => controller.to(i),
              itemCount: controller.images.length,
              itemBuilder: (context, i) => SingleChildScrollView(
                child: OnBoardingItemView(
                  item: controller.images[i],
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
      bottomSheet: Padding(
        padding: AppPaddings.normal,
        child: Row(
          children: [
            Pagination(
              active: controller.state,
              count: controller.images.length,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (controller.isLastIndex) {
                  toAuthScreen();
                } else {
                  pageController.nextPage(
                    duration: controller.duration,
                    curve: Curves.easeInOutCubic,
                  );
                }
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
