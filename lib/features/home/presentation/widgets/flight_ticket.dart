import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../common/presentation/widgets/circular_logo.dart';
import '../../../common/presentation/widgets/ticket_widget.dart';
import '../../../flights/data/entities/ticket.dart';

class FlightTicket extends StatelessWidget {
  const FlightTicket({super.key, required this.ticket});

  final Ticket ticket;

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
                ticket.flight.departureCity.code,
                style: context.textTheme.headline3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Image.asset(AppAssets.planeTrace),
              ),
              Text(
                ticket.flight.arrivalCity.code,
                style: context.textTheme.headline3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.flight.departureCity.name,
                style: context.textTheme.subtitle2,
              ),
              Text(
                ticket.flight.arrivalCity.name,
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
                  "NAME",
                  style: context.textTheme.subtitle2,
                ),
                Text(
                  "DEARTURE",
                  style: context.textTheme.subtitle2,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.name,
                style: context.textTheme.subtitle2,
              ),
              Text(
                DateTimeService.dateStr(ticket.flight.departureTime),
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
            "\$${ticket.price}",
            style: context.textTheme.headline5?.bold,
          ),
        ],
      ),
    );
  }
}
