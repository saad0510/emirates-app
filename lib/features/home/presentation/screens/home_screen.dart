import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../flights/presentation/screens/search_body.dart';
import '../../../flights/presentation/screens/trips_body.dart';
import '../../../flights/presentation/widgets/filters/flight_filter_sheet.dart';
import 'drawer_screen.dart';
import 'profile_body.dart';
import 'welcome_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final controller = AdvancedDrawerController();
  final labels = ["Home", "Search", "Trips", "Profile"];
  final icons = [Icons.home, Icons.search, Icons.calendar_today, Icons.person];
  final bodies = [
    const WelcomeBody(),
    const SearchBody(),
    const TripsBody(),
    const ProfileBody(),
  ];
  final actions = [
    const SizedBox(),
    const FlightFilterButton(),
    const SizedBox(),
    const SizedBox(),
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
              child: actions[selectedIndex],
            ),
          ],
        ),
        body: bodies[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (i) {
            setState(() => selectedIndex = i);
          },
          items: List<BottomNavigationBarItem>.generate(
            labels.length,
            (i) => BottomNavigationBarItem(
              label: labels[i],
              backgroundColor: context.isDarkMode ? BlackColor.normal : Colors.transparent,
              icon: Visibility(
                visible: selectedIndex == i,
                replacement: Icon(icons[i]),
                child: Chip(
                  label: Text(labels[i]),
                  visualDensity: VisualDensity.compact,
                  labelStyle: context.textTheme.subtitle2!.light.white,
                  backgroundColor: context.isDarkMode ? BlackColor.dark : context.primaryColor,
                  avatar: Icon(
                    icons[i],
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
}
