import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../common/presentation/widgets/circular_logo.dart';
import '../../../common/presentation/widgets/ticket_widget.dart';

class FlightTicket extends StatelessWidget {
  const FlightTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      upper: Column(
        children: [
          AppSizes.smallY,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "NYC",
                style: context.textTheme.headline3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Image.asset(AppAssets.planeTrace),
              ),
              Text(
                "SFO",
                style: context.textTheme.headline3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New York City",
                style: context.textTheme.subtitle2,
              ),
              Text(
                "San Fransisco",
                style: context.textTheme.subtitle2,
              ),
            ],
          ),
          AppSizes.smallY,
          Opacity(
            opacity: 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DATE & TIME",
                  style: context.textTheme.subtitle2,
                ),
                Text(
                  "FLIGHT NUMBER",
                  style: context.textTheme.subtitle2,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Feb 25, 11:30pm",
                style: context.textTheme.subtitle2,
              ),
              Text(
                "AB689",
                style: context.textTheme.subtitle2,
              ),
            ],
          ),
        ],
      ),
      lower: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularLogo(radius: 20.sp),
          Text(
            "\$500",
            style: context.textTheme.headline5?.bold,
          ),
        ],
      ),
    );
  }
}
