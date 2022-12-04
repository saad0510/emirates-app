import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/sizes.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../auth/presentation/widgets/date_picker_field.dart';
import '../../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../controllers/flight/flight_controller.dart';
import '../../controllers/flight/flight_state.dart';
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

class FlightFilterSheet extends StatefulWidget {
  const FlightFilterSheet({super.key});

  @override
  State<FlightFilterSheet> createState() => _FlightFilterSheetState();
}

class _FlightFilterSheetState extends State<FlightFilterSheet> {
  DateTime? departure;
  DateTime? arrival;
  RangeValues? cost;

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
                onPressed: onDone,
                child: const Text("Done"),
              ),
            ],
          ),
          AppSizes.smallY,
          const FlightFilterClassChoice(),
          AppSizes.normalY,
          FlightFilterCostSelector(onChange: (x) => cost = x),
          AppSizes.normalY,
          DatePickerField(
            title: "Departure Date",
            onChanged: (x) => departure = x,
            controller: TextEditingController(),
          ),
          AppSizes.normalY,
          DatePickerField(
            title: "Arrival Date",
            onChanged: (x) => arrival = x,
            controller: TextEditingController(),
          ),
          AppSizes.normalY,
        ],
      ),
    );
  }

  void onDone() {
    final controller = context.read<FlightController>();
    final state = controller.state;
    if (state is! FlightLoadedState) {
      context.pop();
      return;
    }

    final costFiltered = cost == null //
        ? state.flights
        : state.flights.where(
            (flight) {
              bool minCase = false, maxCase = false;

              minCase = flight.businesCost > cost!.start && flight.economyCost > cost!.start;
              if (!minCase) return false;

              maxCase = flight.businesCost < cost!.end && flight.economyCost < cost!.end;
              return maxCase;
            },
          );

    final dateFiltered = costFiltered.where(
      (flight) {
        final b1 = departure == null || flight.departureTime == departure!;
        final b2 = arrival == null || flight.arrivalTime == arrival!;
        return b1 && b2;
      },
    );
    controller.filterNewFlights(dateFiltered);
    context.pop();
  }
}
