import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/assets.dart';
import '../../../../core/utils/base_change_notifier.dart';
import '../../data/entities/onboarding_item.dart';

class OnBoardingController extends BaseChangeNotifier<int> {
  static const seenKey = 'seen_key';

  OnBoardingController() : super(0);

  final List<OnBoardingItem> images = [
    const OnBoardingItem(
      title: "Find a relaxing flight\nfor your next trip",
      subtitle: "Try this smart app for\nyour next flight",
      image: AppAssets.onboard1,
    ),
    const OnBoardingItem(
      title: "Ready to take\noff the flight",
      subtitle: "Easy to use app\nfor your next booking",
      image: AppAssets.onboard3,
    ),
    const OnBoardingItem(
      title: "Big world out there!\nGo Explore!",
      subtitle: "Easy to use app\nfor your next booking",
      image: AppAssets.onboard2,
    ),
  ];

  final duration = const Duration(milliseconds: 500);

  void markAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(seenKey, true);
  }

  Future<bool> get isSeen async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(seenKey);
  }

  bool get isLastIndex => state == images.length - 1;

  void to(int pageIndex) => state = pageIndex;
}
