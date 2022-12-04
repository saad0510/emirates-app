import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../common/presentation/widgets/circular_logo.dart';
import '../controllers/booking/booking_controller.dart';
import 'booking_screen_field.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final flight = context.watch<BookingController>().flight;

    return Container(
      padding: AppPaddings.normalXY,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Flight ${flight.fid}',
                  style: context.textTheme.headline3,
                ),
              ),
              AppSizes.normalX,
              CircularLogo(radius: 22.sp),
            ],
          ),
          AppSizes.smallY,
          BookingScreenField(
            label: "FROM",
            title: flight.departureCity.fullname,
          ),
          BookingScreenField(
            label: "TO",
            title: flight.arrivalCity.fullname,
          ),
          Row(
            children: [
              Expanded(
                child: BookingScreenField(
                  label: "DEPARTURE",
                  title: DateTimeService.dateStr(flight.departureTime),
                ),
              ),
              Expanded(
                child: BookingScreenField(
                  label: "ARRIVAL",
                  title: DateTimeService.dateStr(flight.arrivalTime),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: BookingScreenField(
                  label: "ECONOMY",
                  title: '${flight.economyCost} USD',
                ),
              ),
              Expanded(
                child: BookingScreenField(
                  label: "SEATS",
                  title: '${flight.economySeats}',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: BookingScreenField(
                  label: "BUSINESS",
                  title: '${flight.businesCost} USD',
                ),
              ),
              Expanded(
                child: BookingScreenField(
                  label: "SEATS",
                  title: '${flight.businessSeats}',
                ),
              ),
            ],
          ),
          AppSizes.smallY,
        ],
      ),
    );
  }
}
