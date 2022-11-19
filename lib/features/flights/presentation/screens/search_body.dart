import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../home/presentation/widgets/flight_ticket.dart';
import '../../data/entities/flight.dart';
import '../../data/entities/flight_class.dart';
import '../controllers/city_controller.dart';
import '../widgets/select_city_field.dart';

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
                const SelectCityField(),
                AppSizes.smallY,
                Text(
                  "Arrival City",
                  style: context.textTheme.bodyText1,
                ),
                AppSizes.smallY,
                const SelectCityField(),
                AppSizes.smallY,
                const Divider(height: 50),
                Expanded(
                  child: Column(
                    children: List.generate(
                      3,
                      (i) {
                        final flight = Flight(
                          fid: "AB689",
                          departureCity: CityController.cities.first,
                          arrivalCity: CityController.cities.last,
                          dateTime: DateTime.now(),
                          cost: 500,
                          flightClass: FlightClass.business,
                        );

                        return InkWell(
                          onTap: () => context.push(AppRoutes.booking, arguments: flight),
                          child: Padding(
                            padding: AppPaddings.normalY,
                            child: FlightTicket(flight: flight),
                          ),
                        );
                      },
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
