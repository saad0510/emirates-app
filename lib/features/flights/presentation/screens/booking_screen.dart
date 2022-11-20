import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../common/presentation/widgets/circular_logo.dart';
import '../../data/entities/flight.dart';
import '../widgets/booking_screen_field.dart';
import '../widgets/chip_selector.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.flight});

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Booking"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.normalXY,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChipSelector(
                onChanged: (i) {},
                values: const ["One Way", "Round Trip"],
              ),
              AppSizes.normalY,
              Container(
                padding: AppPaddings.smallXY,
                decoration: BoxDecoration(
                  color: context.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSizes.smallY,
                    BookingScreenField(
                      label: "FROM",
                      title: flight.departureCity.name,
                    ),
                    AppSizes.smallY,
                    BookingScreenField(
                      label: "TO",
                      title: flight.arrivalCity.name,
                    ),
                    AppSizes.smallY,
                    BookingScreenField(
                      label: "DATE",
                      title: DateTimeService.dateStr(flight.dateTime),
                    ),
                    AppSizes.smallY,
                    BookingScreenField(
                      label: "DEPARTURE TIME",
                      title: DateTimeService.timeStr(flight.dateTime),
                    ),
                    AppSizes.smallY,
                    BookingScreenField(
                      label: "CLASS",
                      title: flight.flightClass.name,
                    ),
                    AppSizes.maxY,
                    Row(
                      children: [
                        CircularLogo(radius: 22.sp),
                        AppSizes.normalX,
                        AppSizes.normalX,
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.push(AppRoutes.seats, arguments: flight),
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
