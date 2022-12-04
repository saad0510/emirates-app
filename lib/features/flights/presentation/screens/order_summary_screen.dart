import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../controllers/booking/booking_controller.dart';
import '../widgets/tickets_summary.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key, required this.controller});

  final BookingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.normalXY,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Review your\nBookings",
                style: context.textTheme.headline1,
              ),
              Image.asset(
                AppAssets.confirmOrder,
                height: 300.sp,
              ),
              TicketsSummary(
                tickets: controller.tickets,
              ),
              AppSizes.normalY,
              ElevatedButton(
                onPressed: () {
                  controller.confirmBooking();
                  context.pop();
                },
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
