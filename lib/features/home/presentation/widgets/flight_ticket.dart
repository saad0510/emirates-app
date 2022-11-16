import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../common/presentation/widgets/circular_logo.dart';
import '../../../common/presentation/widgets/ticket_widget.dart';
import '../../../flights/data/entities/flight.dart';

class FlightTicket extends StatelessWidget {
  const FlightTicket({super.key, required this.flight});

  final Flight flight;

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
                flight.departureCity.code,
                style: context.textTheme.headline3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Image.asset(AppAssets.planeTrace),
              ),
              Text(
                flight.arrivalCity.code,
                style: context.textTheme.headline3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                flight.departureCity.name,
                style: context.textTheme.subtitle2,
              ),
              Text(
                flight.arrivalCity.name,
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
                DateTimeService.dateTimeStr(flight.dateTime),
                style: context.textTheme.subtitle2,
              ),
              Text(
                flight.fid,
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
            "\$${flight.cost.roundToDouble()}",
            style: context.textTheme.headline5?.bold,
          ),
        ],
      ),
    );
  }
}
