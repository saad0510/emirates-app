import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/sizes.dart';
import '../../../../../core/extensions/context_ext.dart';

class FlightFilterClassChoice extends StatefulWidget {
  const FlightFilterClassChoice({super.key});

  @override
  State<FlightFilterClassChoice> createState() => _FlightFilterClassChoiceState();
}

class _FlightFilterClassChoiceState extends State<FlightFilterClassChoice> {
  Map<String, bool> classes = {'Business': false, 'Economy': false};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: classes.entries
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: ChoiceChip(
                selected: e.value,
                padding: AppPaddings.zero,
                label: Text(e.key),
                selectedColor: context.primaryColor,
                backgroundColor: context.backgroundColor,
                onSelected: (v) {
                  setState(() => classes[e.key] = v);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
