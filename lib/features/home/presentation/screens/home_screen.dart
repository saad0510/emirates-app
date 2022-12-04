import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../../auth/presentation/controllers/auth/auth_state.dart';
import '../../../flights/presentation/controllers/ticket/trips_refresh_button.dart';
import '../../../flights/presentation/screens/search_body.dart';
import '../../../flights/presentation/screens/trips_body.dart';
import '../../../flights/presentation/widgets/filters/flight_filter_sheet.dart';
import '../../data/entities/nav_bar_item.dart';
import '../controllers/notification_button.dart';
import 'drawer_screen.dart';
import 'profile_body.dart';
import 'welcome_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.initialIndex});

  final int initialIndex;

  static const welcomeIndex = 0;
  static const searchIndex = 1;
  static const tripsIndex = 2;
  static const profileIndex = 3;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex = widget.initialIndex;
  late final auth = context.read<AuthController>();
  final controller = AdvancedDrawerController();

  @override
  void initState() {
    auth.addListener(handleState);
    super.initState();
  }

  @override
  void dispose() {
    auth.removeListener(handleState);
    super.dispose();
  }

  final navBarItems = [
    NavBarItem(
      index: HomeScreen.welcomeIndex,
      label: "Home",
      icon: Icons.home,
      appBarAction: const NotificationButton(),
      body: const WelcomeBody(),
    ),
    NavBarItem(
      label: "Search",
      index: HomeScreen.searchIndex,
      icon: Icons.search,
      appBarAction: const FlightFilterButton(),
      body: const SearchBody(),
    ),
    NavBarItem(
      index: HomeScreen.tripsIndex,
      label: "Trips",
      icon: Icons.calendar_today,
      appBarAction: const TripsRefreshButton(),
      body: const TripsBody(),
    ),
    NavBarItem(
      index: HomeScreen.profileIndex,
      label: "Profile",
      icon: Icons.person,
      appBarAction: const SizedBox(),
      body: const ProfileBody(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DrawerScreen(
      controller: controller,
      page: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => controller.showDrawer(),
            icon: const Icon(Icons.menu),
          ),
          actions: [
            Padding(
              padding: AppPaddings.extraSmallX,
              child: navBarItems[selectedIndex].appBarAction,
            ),
          ],
        ),
        body: navBarItems[selectedIndex].body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (i) {
            setState(() => selectedIndex = i);
          },
          items: List<BottomNavigationBarItem>.generate(
            navBarItems.length,
            (i) => BottomNavigationBarItem(
              label: navBarItems[i].label,
              backgroundColor: context.isDarkMode ? BlackColor.normal : Colors.transparent,
              icon: Visibility(
                visible: selectedIndex == i,
                replacement: Icon(navBarItems[i].icon),
                child: Chip(
                  label: Text(navBarItems[i].label),
                  visualDensity: VisualDensity.compact,
                  labelStyle: context.textTheme.subtitle2!.light.white,
                  backgroundColor: context.isDarkMode ? BlackColor.dark : context.primaryColor,
                  avatar: Icon(
                    navBarItems[i].icon,
                    color: context.isDarkMode ? AppColors.primary : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleState() {
    if (!mounted) return;

    final state = auth.state;
    if (state is AuthEmptyState) {
      context.replaceAll(AppRoutes.auth);
    } else if (state is AuthErrorState) {
      context.showErrorSnackBar(message: state.failure.message);
    }
  }
}
