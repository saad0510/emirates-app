import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../data/entities/flight.dart';
import '../../data/entities/flight_seats.dart';
import '../widgets/airplane_seats_image.dart';

class ChooseSeatsScreen extends StatelessWidget {
  const ChooseSeatsScreen({super.key, required this.flight});

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    final color = context.isDarkMode ? BlackColor.light : context.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Seats'),
      ),
      body: Column(
        children: [
          AppSizes.maxY,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: AirplaneSeatsImage(
                    windowColor: color,
                    seats: FlightSeats(
                      count: 30,
                      flightClass: flight.flightClass,
                      occupied: {1: true, 2: true, 8: true, 9: true, 5: true},
                    ),
                  ),
                ),
                const Spacer(),
                // Expanded(
                //   child: FlightTravelLine(
                //     color: color,
                //     flight: flight,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
