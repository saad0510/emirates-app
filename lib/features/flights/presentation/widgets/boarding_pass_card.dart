import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../common/presentation/widgets/dashed_line.dart';
import '../../../common/presentation/widgets/ticket_widget.dart';
import '../../data/entities/flight_class.dart';
import '../../data/entities/ticket.dart';

class BoardingPassCard extends StatelessWidget {
  const BoardingPassCard({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final flight = ticket.flight;

    return TicketWidget(
      lower: Center(
        child: BarcodeWidget(
          barcode: Barcode.code128(),
          data: ticket.ticketId,
          color: context.contrastColor,
          drawText: false,
          height: 100.h,
          padding: AppPaddings.smallXY,
        ),
      ),
      upper: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.logo,
            color: context.primaryColor,
            alignment: Alignment.center,
            width: 130.sp,
          ),
          AppSizes.smallY,
          DefaultTextStyle(
            style: context.textTheme.headline2!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(flight.departureCity.code),
                const Spacer(),
                CircleAvatar(
                  radius: 4.sp,
                  backgroundColor: context.primaryColor,
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const DashedLine(count: 10),
                      Icon(Icons.flight_takeoff, color: context.primaryColor),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 4.sp,
                  backgroundColor: context.primaryColor,
                ),
                const Spacer(),
                Text(flight.arrivalCity.code),
              ],
            ),
          ),
          DefaultTextStyle(
            style: context.textTheme.subtitle2!,
            child: Row(
              children: [
                Text(flight.departureCity.name),
                const Spacer(),
                Text(flight.arrivalCity.name),
              ],
            ),
          ),
          const Divider(height: 40),
          Opacity(
            opacity: 0.5,
            child: DefaultTextStyle(
              style: context.textTheme.subtitle2!,
              child: Row(
                children: const [
                  Text("FULLNAME"),
                  Spacer(),
                  Text("FLIGHT ID"),
                ],
              ),
            ),
          ),
          DefaultTextStyle(
            style: context.textTheme.bodyText1!,
            child: Row(
              children: [
                Text(ticket.name),
                const Spacer(),
                Text(flight.fid),
              ],
            ),
          ),
          AppSizes.smallY,
          Opacity(
            opacity: 0.5,
            child: DefaultTextStyle(
              style: context.textTheme.subtitle2!,
              child: Row(
                children: const [
                  Text("SEAT NUMBER"),
                  Spacer(),
                  Text("CLASS"),
                ],
              ),
            ),
          ),
          DefaultTextStyle(
            style: context.textTheme.bodyText1!,
            child: Row(
              children: [
                Text(ticket.seatId),
                const Spacer(),
                Text(FlightClass.business.name),
              ],
            ),
          ),
          AppSizes.smallY,
          Opacity(
            opacity: 0.5,
            child: DefaultTextStyle(
              style: context.textTheme.subtitle2!,
              child: Row(
                children: const [
                  Text("DEPARTURE"),
                  Spacer(),
                  Text("ARRIVAL"),
                ],
              ),
            ),
          ),
          DefaultTextStyle(
            style: context.textTheme.bodyText1!,
            child: Row(
              children: [
                Text(DateTimeService.dateTimeStr(flight.departureTime)),
                const Spacer(),
                Text(DateTimeService.dateTimeStr(flight.arrivalTime)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
