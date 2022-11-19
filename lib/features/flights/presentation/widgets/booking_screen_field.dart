import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';

class BookingScreenField extends StatelessWidget {
  const BookingScreenField({
    super.key,
    required this.label,
    required this.title,
  });

  final String label;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.smallY,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: context.textTheme.subtitle1,
          ),
          Text(
            title,
            style: context.textTheme.headline5!.regular,
          ),
          const Divider(
            color: BlackColor.light,
            endIndent: 0,
            indent: 0,
            height: 10,
          ),
        ],
      ),
    );
  }
}
