// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';

class SectionDivider extends StatelessWidget {
  SectionDivider({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = context.isDarkMode //
        ? AppColors.white
        : AppColors.primary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(color: color, height: 70),
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: color,
          ),
        ),
        Expanded(
          child: Divider(color: color, height: 70),
        ),
      ],
    );
  }
}
