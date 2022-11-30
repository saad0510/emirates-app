import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../home/presentation/widgets/flight_ticket.dart';
import '../../data/entities/flight.dart';
import '../controllers/city_controller.dart';
import '../widgets/chip_selector.dart';

class TripsBody extends StatefulWidget {
  const TripsBody({super.key});

  @override
  State<TripsBody> createState() => _TripsBodyState();
}

class _TripsBodyState extends State<TripsBody> {
  final flight = Flight(
    fid: "AB689",
    departureCity: CityController.cities.first,
    arrivalCity: CityController.cities.last,
    dateTime: DateTime.now(),
  );

  late final upcomings = List.filled(3, flight);
  late final past = List.filled(1, flight);
  late final trips = [upcomings, past];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalX,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChipSelector(
              onChanged: (i) => setState(() => selected = i),
              values: const ['Upcoming trips', 'Past trips'],
            ),
            AppSizes.normalY,
            ...trips[selected].map<Widget>(
              (e) => InkWell(
                onTap: () {
                  context.push(AppRoutes.boardingPass, arguments: flight);
                },
                child: Padding(
                  padding: AppPaddings.normalY.copyWith(top: 0),
                  child: const FlightTicket(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
