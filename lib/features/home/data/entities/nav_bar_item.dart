import 'package:flutter/widgets.dart';

class NavBarItem {
  final int index;
  final String label;
  final IconData icon;
  final Widget body;
  final Widget appBarAction;

  NavBarItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.body,
    required this.appBarAction,
  });
}
