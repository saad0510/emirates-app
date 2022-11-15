import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

extension CopyWithExt on TextStyle {
  TextStyle get colored => copyWith(color: AppColors.primary);

  TextStyle get white => copyWith(color: AppColors.white);

  TextStyle get black => copyWith(color: BlackColor.dark);

  TextStyle get grayDark => copyWith(color: BlackColor.medium);

  TextStyle get gray => copyWith(color: BlackColor.normal);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
}
