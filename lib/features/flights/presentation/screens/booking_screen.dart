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
        title: const Text("Book Flight"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.normalXY,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChipSelector(
                onChanged: (i) {},
                values: const ["For me", "Multiple tickets"],
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
                    BookingScreenField(
                      label: "FROM",
                      title: flight.departureCity.fullname,
                    ),
                    BookingScreenField(
                      label: "TO",
                      title: flight.arrivalCity.fullname,
                    ),
                    BookingScreenField(
                      label: "DATE",
                      title: DateTimeService.dateTimeStr(flight.dateTime),
                    ),
                    BookingScreenField(
                      label: "TIME",
                      title: DateTimeService.timeStr(flight.dateTime),
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: BookingScreenField(
                            label: "ECONOMY",
                            title: '200 USD',
                          ),
                        ),
                        Expanded(
                          child: BookingScreenField(
                            label: "REMAINING SEATS",
                            title: '0',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: BookingScreenField(
                            label: "BUSINESS",
                            title: '500 USD',
                          ),
                        ),
                        Expanded(
                          child: BookingScreenField(
                            label: "REMAINING SEATS",
                            title: '15',
                          ),
                        ),
                      ],
                    ),
                    AppSizes.normalY,
                    Row(
                      children: [
                        CircularLogo(radius: 22.sp),
                        AppSizes.normalX,
                        AppSizes.normalX,
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.push(AppRoutes.seats, arguments: flight);
                            },
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
