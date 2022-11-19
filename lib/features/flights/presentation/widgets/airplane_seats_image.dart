import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/plane_clipper.dart';
import '../../data/entities/flight_seats.dart';
import 'booking_seat.dart';

class AirplaneSeatsImage extends StatelessWidget {
  const AirplaneSeatsImage({
    super.key,
    this.child,
    this.windowColor = Colors.white,
    required this.seats,
  });

  final Widget? child;
  final Color windowColor;
  final FlightSeats seats;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: PlaneClipper(),
        child: Container(
          width: 300.sp,
          margin: AppPaddings.normalX,
          color: context.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSizes.normalY,
              Image.asset(AppAssets.planeWindows, color: windowColor),
              AppSizes.normalY,
              Text(
                '${seats.flightClass.name} class',
                textAlign: TextAlign.center,
                style: context.textTheme.subtitle2,
              ),
              AppSizes.normalY,
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(
                      seats.count,
                      (i) => BookingSeat(
                        occupied: seats.occupied.containsKey(i),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
