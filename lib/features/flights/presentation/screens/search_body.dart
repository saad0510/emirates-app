import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../home/presentation/widgets/flight_ticket.dart';
import '../../data/entities/flight.dart';
import '../controllers/city_controller.dart';
import '../widgets/select_airport_field.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: AppPaddings.normalX,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Departure City",
                  style: context.textTheme.bodyText1,
                ),
                AppSizes.smallY,
                const SelectAirportField(),
                AppSizes.smallY,
                Text(
                  "Arrival City",
                  style: context.textTheme.bodyText1,
                ),
                AppSizes.smallY,
                const SelectAirportField(),
                AppSizes.smallY,
                const Divider(height: 50),
                Expanded(
                  child: Column(
                    children: List.generate(
                      3,
                      (i) => Padding(
                        padding: AppPaddings.normalY,
                        child: FlightTicket(
                          flight: Flight(
                            fid: "AB689",
                            departureCity: CityController.cities.first,
                            arrivalCity: CityController.cities.last,
                            dateTime: DateTime.now(),
                            cost: 500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
