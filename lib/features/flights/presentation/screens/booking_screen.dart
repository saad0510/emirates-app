import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../injections.dart';
import '../controllers/booking/booking_controller.dart';
import '../controllers/flight/flight_controller.dart';
import '../widgets/booking_card.dart';
import '../widgets/booking_form.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingController(
        flight: context.watch<FlightController>().bookedFlight,
        repo: Injections.inject(),
      ),

      //
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Book Flight"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: AppPaddings.normalXY,
              child: StatefulBuilder(
                builder: (context, setState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const BookingForm(),
                    AppSizes.normalY,
                    const BookingCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
