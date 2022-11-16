import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import 'filters/flight_filter_class_choice.dart';
import 'filters/flight_filter_cost_selector.dart';
import 'filters/flight_filter_date_picker.dart';

class FlightFilterButton extends StatelessWidget {
  const FlightFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.tune),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(22),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (_) => const FlightFilterSheet(),
        );
      },
    );
  }
}

class FlightFilterSheet extends StatelessWidget {
  const FlightFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.normalX,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            leadingWidth: 10,
            leading: IconButton(
              padding: AppPaddings.zero,
              icon: const Icon(Icons.close),
              onPressed: () => context.pop(),
            ),
            title: const Text("Filters"),
            actions: [
              CupertinoButton(
                onPressed: () {
                  onDone();
                  context.pop();
                },
                child: const Text("Done"),
              ),
            ],
          ),
          AppSizes.smallY,
          const FlightFilterClassChoice(),
          const Divider(height: 50, thickness: 0.7),
          const FlightFilterDatePicker(),
          AppSizes.smallY,
          const Divider(height: 30, thickness: 0.7),
          Text(
            "COST",
            style: context.textTheme.subtitle2,
          ),
          const FlightFilterCostSelector(),
        ],
      ),
    );
  }

  void onDone() {}
}
