import 'package:flutter/material.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Class",
          style: context.textTheme.bodyText1,
        ),
        AppSizes.smallY,
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: classes.entries
              .map(
                (e) => ChoiceChip(
                  selected: e.value,
                  padding: AppPaddings.zero,
                  label: Text(e.key),
                  selectedColor: context.primaryColor,
                  backgroundColor: context.backgroundColor,
                  onSelected: (v) {
                    setState(() => classes[e.key] = v);
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
