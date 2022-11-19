import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../app/sizes.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../auth/presentation/widgets/auth_text_field.dart';
import '../../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../../../common/presentation/widgets/section_divider.dart';
import 'flight_filter_class_choice.dart';
import 'flight_filter_cost_selector.dart';

class FlightFilterButton extends StatelessWidget {
  const FlightFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.tune),
      onPressed: () {
        BottomModalSheet.show(
          context,
          child: const FlightFilterSheet(),
        );
      },
    );
  }
}

class FlightFilterSheet extends StatelessWidget {
  const FlightFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            leadingWidth: 15,
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
          AppSizes.normalY,
          const FlightFilterCostSelector(),
          SectionDivider(text: "Departure Date"),
          Row(
            children: [
              const Expanded(
                child: AuthTextField(
                  label: "From",
                  hint: '17/11/2022',
                  keyboardType: TextInputType.datetime,
                ),
              ),
              AppSizes.normalX,
              const Expanded(
                child: AuthTextField(
                  label: "To",
                  hint: '17/11/2022',
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ],
          ),
          SectionDivider(text: "Departure Time"),
          Row(
            children: [
              const Expanded(
                child: AuthTextField(
                  label: "From",
                  hint: '14:20',
                  keyboardType: TextInputType.datetime,
                ),
              ),
              AppSizes.normalX,
              const Expanded(
                child: AuthTextField(
                  label: "To",
                  hint: '00:12',
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onDone() {}
}
