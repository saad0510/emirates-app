import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../data/entities/flight.dart';
import '../../data/entities/flight_class.dart';
import '../../data/entities/flight_seats.dart';
import '../../data/entities/seat.dart';
import '../widgets/airplane_seats_image.dart';
import '../widgets/confirm_seat_dialog.dart';
import '../widgets/flight_travel_line.dart';
import '../widgets/seats_section.dart';

class ChooseSeatsScreen extends StatelessWidget {
  const ChooseSeatsScreen({super.key, required this.flight});

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    final color = context.isDarkMode ? BlackColor.light : context.primaryColor;
    const rowSize = 4;

    void onSelected(String sid, FlightClass flightClass) {
      BottomModalSheet.show(
        context,
        child: ConfirmSeatDialog(
          seat: Seat(
            seatId: sid,
            price: flightClass == FlightClass.business ? 500 : 200,
            flightClass: flightClass,
          ),
          onConfirm: () {
            context.pop();
            context.pop();
            context.push(AppRoutes.payment, arguments: 1234.56);
          },
        ),
      );
    }

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
                  flex: 3,
                  child: AirplaneSeatsImage(
                    windowColor: color,
                    children: [
                      SeatsSection(
                        rowSize: rowSize,
                        onSelected: (s) => onSelected(s, FlightClass.business),
                        seats: FlightSeats(
                          rows: 4,
                          flightClass: FlightClass.business,
                          occupied: {1, 2, 8, 9, 5},
                        ),
                      ),
                      AppSizes.normalY,
                      SeatsSection(
                        rowSize: rowSize,
                        onSelected: (s) => onSelected(s, FlightClass.economy),
                        seats: FlightSeats(
                          rows: 8,
                          flightClass: FlightClass.economy,
                          occupied: {29, 4, 14, 3},
                        ),
                      ),
                      AppSizes.normalY,
                    ],
                  ),
                ),
                Expanded(
                  child: FlightTravelLine(
                    color: color,
                    flight: flight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
