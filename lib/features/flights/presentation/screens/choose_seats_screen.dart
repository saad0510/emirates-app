import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../data/entities/flight_class.dart';
import '../controllers/flight/flight_controller.dart';
import '../widgets/airplane_seats_image.dart';
import '../widgets/confirm_seat_dialog.dart';
import '../widgets/flight_travel_line.dart';
import '../widgets/seats_section.dart';

class ChooseSeatsScreen extends StatelessWidget {
  const ChooseSeatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flight = context.watch<FlightController>().bookedFlight;
    final color = context.isDarkMode ? BlackColor.light : context.primaryColor;

    void onSelected(String sid, FlightClass flightClass) {
      BottomModalSheet.show(
        context,
        child: ConfirmSeatDialog(
          seatId: sid,
          price: flightClass == FlightClass.business ? flight.businesCost : flight.economyCost,
          flightClass: flightClass,
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
                        rowSize: flight.rowSize,
                        onSelected: (s) => onSelected(s, FlightClass.business),
                        rowsNo: flight.businessRows,
                        flightClass: FlightClass.business,
                        occupied: const {1, 2, 8, 9, 5},
                      ),
                      AppSizes.normalY,
                      SeatsSection(
                        rowSize: flight.rowSize,
                        onSelected: (s) => onSelected(s, FlightClass.economy),
                        rowsNo: flight.economyRows,
                        flightClass: FlightClass.economy,
                        occupied: const {29, 4, 14, 3},
                      ),
                      AppSizes.normalY,
                    ],
                  ),
                ),
                Expanded(
                  child: FlightTravelLine(
                    color: color,
                    from: flight.departureCity.code,
                    to: flight.arrivalCity.code,
                  ),
                ),
                // const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
