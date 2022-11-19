import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.count = 20,
    this.axis = Axis.horizontal,
  });

  final int count;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          count,
          (index) => const Expanded(
            child: Divider(
              thickness: 0.8,
              endIndent: 3,
              indent: 3,
              color: BlackColor.light,
            ),
          ),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (index) => const Expanded(
          child: VerticalDivider(
            thickness: 0.8,
            endIndent: 3,
            indent: 3,
            color: BlackColor.light,
          ),
        ),
      ),
    );
  }
}
