import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../core/extensions/text_ext.dart';
import '../../core/utils/base_change_notifier.dart';
import '../sizes.dart';
import 'colors.dart';
import 'fonts.dart';

class AppTheme extends BaseChangeNotifier<Brightness> {
  AppTheme() : super(SchedulerBinding.instance.window.platformBrightness);

  @override
  Future<void> init() {
    updateColors();
    addListener(updateColors);
    return super.init();
  }

  ThemeData get theme {
    return isDark ? darkTheme : lightTheme;
  }

  void toggleTheme() {
    state = isDark ? Brightness.light : Brightness.dark;
  }

  void setPlatformTheme() {
    state = SchedulerBinding.instance.window.platformBrightness;
  }

  bool get isDark => state == Brightness.dark;

  void updateColors() {
    contrastColor = isDark ? AppColors.white : BlackColor.normal;
    highlightColor = isDark ? BlackColor.light : AppColors.highlight;
    backgroundColor = isDark ? BlackColor.medium : AppColors.highlight;
  }

  Color contrastColor = AppColors.white;
  Color highlightColor = BlackColor.light;
  Color backgroundColor = BlackColor.medium;

  late final basetheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),
    fontFamily: AppFonts.fontFamily,
    errorColor: ErrorColor.normal,
    elevatedButtonTheme: elevatedButton,
    inputDecorationTheme: inputField,
    checkboxTheme: const CheckboxThemeData(
      checkColor: MaterialStatePropertyAll(Colors.white),
      fillColor: MaterialStatePropertyAll(AppColors.primary),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 1,
      indent: 5,
      endIndent: 5,
      color: BlackColor.light,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(color: BlackColor.light),
    drawerTheme: const DrawerThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    listTileTheme: const ListTileThemeData(
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    chipTheme: const ChipThemeData(
      labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    ),
    bottomNavigationBarTheme: navBar,
  );

  late final lightTheme = basetheme.copyWith(
    brightness: Brightness.light,
    textTheme: textThemeLight,
    appBarTheme: appBar.copyWith(
      foregroundColor: BlackColor.normal,
      titleTextStyle: AppFonts.headline6.gray,
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle.copyWith(
        foregroundColor: MaterialStateProperty.all(BlackColor.dark),
      ),
    ),
    inputDecorationTheme: inputField.copyWith(
      fillColor: AppColors.highlight,
      hintStyle: AppFonts.body2.light.copyWith(
        color: BlackColor.normal,
        letterSpacing: 0,
      ),
    ),
  );

  late final darkTheme = basetheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: BlackColor.dark,
    textTheme: textThemeDark,
    appBarTheme: appBar.copyWith(
      foregroundColor: AppColors.white,
      titleTextStyle: AppFonts.headline6.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle.copyWith(
        foregroundColor: MaterialStateProperty.all(AppColors.white),
      ),
    ),
    inputDecorationTheme: inputField.copyWith(
      fillColor: BlackColor.medium,
      hintStyle: AppFonts.body2.light.copyWith(
        color: BlackColor.light,
        letterSpacing: 0,
      ),
    ),
  );

  late final elevatedButton = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.all(AppFonts.body1),
      padding: MaterialStateProperty.all(AppPaddings.smallXY),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          return states.contains(MaterialState.disabled) //
              ? Colors.black54
              : AppColors.white;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          return states.contains(MaterialState.disabled) //
              ? Colors.black12
              : AppColors.primary;
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  late final textButtonStyle = TextButton.styleFrom(
    elevation: 0,
    padding: AppPaddings.smallXY,
    textStyle: AppFonts.body2.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  late final appBar = const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
  );

  late final inputField = InputDecorationTheme(
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: BlackColor.light),
    ),
    contentPadding: AppPaddings.normalX,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  late final navBar = const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: BlackColor.light,
  );

  late final textThemeDark = TextTheme(
    headline1: AppFonts.headline1.white,
    headline2: AppFonts.headline2,
    headline3: AppFonts.headline3,
    headline4: AppFonts.headline4,
    headline5: AppFonts.headline5,
    headline6: AppFonts.headline6.white,
    bodyText1: AppFonts.body1.white,
    bodyText2: AppFonts.body2,
    subtitle1: AppFonts.subtitle1,
    subtitle2: AppFonts.subtitle2,
  );

  late final textThemeLight = TextTheme(
    headline1: AppFonts.headline1.grayDark,
    headline2: AppFonts.headline2.gray,
    headline3: AppFonts.headline3.grayDark,
    headline4: AppFonts.headline4.black,
    headline5: AppFonts.headline5.black,
    headline6: AppFonts.headline6.gray,
    bodyText1: AppFonts.body1.gray,
    bodyText2: AppFonts.body2.gray,
    subtitle1: AppFonts.subtitle1,
    subtitle2: AppFonts.subtitle2.grayDark,
  );
}
