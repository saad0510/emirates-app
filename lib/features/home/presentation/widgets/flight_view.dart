import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../flights/data/entities/flight.dart';

class FlightView extends StatelessWidget {
  const FlightView({super.key, required this.flight});

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
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
                  "FLIGHT ID",
                  style: context.textTheme.subtitle2,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateTimeService.dateTimeStr(flight.departureTime),
                style: context.textTheme.subtitle2,
              ),
              Text(
                flight.fid,
                style: context.textTheme.subtitle2,
              ),
            ],
          ),
          AppSizes.smallY,
        ],
      ),
    );
  }
}
