import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/theme/theme.dart';

extension BasicExtOnContext on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isDarkMode => read<AppTheme>().isDark;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get highlightColor => read<AppTheme>().highlightColor;
  Color get contrastColor => read<AppTheme>().contrastColor;
  Color get backgroundColor => read<AppTheme>().backgroundColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension NavExtOnContext on BuildContext {
  Future<void> push(String route, {Object? arguments}) async {
    Navigator.of(this).pushNamed(route, arguments: arguments);
  }

  Future<void> replace(String appRoute) async {
    await Navigator.of(this).pushReplacementNamed(appRoute);
  }

  Future<void> replaceAll(String route, {Object? arguments}) async {
    while (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
    await Navigator.of(this).pushReplacementNamed(route, arguments: arguments);
  }

  Future<void> pop([bool? result]) async {
    return Navigator.of(this).pop(result);
  }

  Future<void> maybePop([bool? result]) async {
    await Navigator.of(this).maybePop(result);
  }

  bool get canPop {
    return Navigator.of(this).canPop();
  }
}

extension WidgetsExtOnContext on BuildContext {
  void snackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
