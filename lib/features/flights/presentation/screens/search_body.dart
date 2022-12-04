import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../home/presentation/widgets/flight_view.dart';
import '../../data/entities/city.dart';
import '../controllers/flight/flight_controller.dart';
import '../controllers/flight/flight_state.dart';
import '../widgets/select_city_field.dart';
import '../widgets/state_icons.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  late final controller = context.read<FlightController>();

  City departureCity = const City.empty();
  City arrivalCity = const City.empty();

  @override
  Widget build(BuildContext context) {
    late final state = context.watch<FlightController>().state;

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
                SelectCityField(
                  onSelected: (city) => departureCity = city,
                ),
                AppSizes.smallY,
                Text(
                  "Arrival City",
                  style: context.textTheme.bodyText1,
                ),
                AppSizes.smallY,
                SelectCityField(
                  onSelected: (city) => arrivalCity = city,
                ),
                AppSizes.normalY,
                ElevatedButton(
                  onPressed: () => controller.search(departureCity, arrivalCity),
                  child: const Text("Search"),
                ),
                AppSizes.smallY,
                if (state is FlightEmptyState)
                  const WelcomeIcon()
                else if (state is FlightLoadingState)
                  const Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  )
                else if (state is FlightErrorState)
                  ErrorIcon(errorMsg: state.failure.message)
                else if (state is FlightLoadedState && state.flights.isEmpty)
                  const NotFoundIcon(message: 'No flights found')
                else if (state is FlightLoadedState)
                  Expanded(
                    child: Column(
                      children: List.generate(
                        state.flights.length,
                        (i) {
                          return InkWell(
                            onTap: () => onSelected(i),
                            child: Padding(
                              padding: AppPaddings.smallY,
                              child: FlightView(
                                flight: state.flights.elementAt(i),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                AppSizes.smallY,
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onSelected(int index) {
    controller.bookingIndex = index;
    context.push(AppRoutes.booking);
  }
}
