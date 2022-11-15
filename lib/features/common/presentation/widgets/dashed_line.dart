import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({super.key, this.count = 20});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
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
}
