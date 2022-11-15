import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
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
              child: const Center(child: FlightTicket()),
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
