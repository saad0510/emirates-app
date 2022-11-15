import 'package:provider/provider.dart';

import 'features/auth/presentation/controllers/onboarding_controller.dart';

final appProviders = [
  ChangeNotifierProvider(
    create: (_) => OnBoardingController(),
  ),
];
