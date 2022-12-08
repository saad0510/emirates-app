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
          BookingScreenField(
            label: "DEPARTURE",
            title: DateTimeService.dateTimeStr(flight.departureTime, full: true),
          ),
          BookingScreenField(
            label: "ARRIVAL",
            title: DateTimeService.dateTimeStr(flight.arrivalTime, full: true),
          ),
          Row(
            children: [
              Expanded(
                child: BookingScreenField(
                  label: "ECONOMY",
                  title: '\$ ${flight.economyCost}',
                ),
              ),
              Expanded(
                child: BookingScreenField(
                  label: "BUSINESS",
                  title: '\$ ${flight.businesCost}',
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
