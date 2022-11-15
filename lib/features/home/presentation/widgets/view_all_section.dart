import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';

class ViewAllSection extends StatelessWidget {
  const ViewAllSection({
    super.key,
    required this.title,
    required this.child,
    this.onPressed,
  });

  final String title;
  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.headline5,
            ),
            InkWell(
              onTap: onPressed,
              child: const Text(
                "View All",
                style: TextStyle(color: BlackColor.light),
              ),
            ),
          ],
        ),
        AppSizes.normalY,
        child,
      ],
    );
  }
}
