import 'package:flutter/material.dart';

class FlightFilterCostSelector extends StatefulWidget {
  const FlightFilterCostSelector({super.key});

  @override
  State<FlightFilterCostSelector> createState() => _FlightFilterCostSelectorState();
}

class _FlightFilterCostSelectorState extends State<FlightFilterCostSelector> {
  RangeValues values = const RangeValues(2, 10);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: values,
      min: 1,
      max: 100,
      divisions: 100,
      labels: RangeLabels(
        '\$${values.start.round()}',
        '\$${values.end.round()}',
      ),
      onChanged: (x) => setState(() => values = x),
    );
  }
}
