import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../common/presentation/widgets/circular_logo.dart';
import '../controllers/flight/flight_controller.dart';
import '../widgets/booking_screen_field.dart';
import '../widgets/chip_selector.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flight = context.watch<FlightController>().bookedFlight;

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
                      label: "DEPARTURE DATE",
                      title: DateTimeService.dateTimeStr(flight.departureTime),
                    ),
                    BookingScreenField(
                      label: "ARRIVAL DATE",
                      title: DateTimeService.dateTimeStr(flight.arrivalTime),
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
                    AppSizes.normalY,
                    Row(
                      children: [
                        CircularLogo(radius: 22.sp),
                        AppSizes.normalX,
                        AppSizes.normalX,
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => onPressed(context),
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

  void onPressed(BuildContext context) {
    context.push(AppRoutes.seats);
  }
}
