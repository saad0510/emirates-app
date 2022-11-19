import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../flights/data/entities/flight.dart';
import '../../../flights/data/entities/flight_class.dart';
import '../../../flights/presentation/controllers/city_controller.dart';
import '../widgets/flight_ticket.dart';
import '../widgets/popular_destinations_short_list.dart';
import '../widgets/view_all_section.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalX,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Hello! James",
              style: context.textTheme.bodyText1?.colored,
            ),
            Text(
              "Where are you going?",
              style: context.textTheme.headline1,
            ),
            const Divider(height: 50),
            ViewAllSection(
              title: "Upcoming flights",
              onPressed: () {},
              child: Center(
                child: FlightTicket(
                  flight: Flight(
                    fid: "AB689",
                    departureCity: CityController.cities.first,
                    arrivalCity: CityController.cities.last,
                    dateTime: DateTime.now(),
                    cost: 500.9,
                    flightClass: FlightClass.business,
                  ),
                ),
              ),
            ),
            Container(
              height: 360.h,
              margin: AppPaddings.normalY,
              child: ViewAllSection(
                title: "Popular Places",
                onPressed: () {},
                child: const Expanded(
                  child: PopularDestinationsShortList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
