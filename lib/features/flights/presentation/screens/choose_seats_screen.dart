import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../injections.dart';
import '../../data/entities/flight_class.dart';
import '../controllers/flight/flight_controller.dart';
import '../controllers/seats/seats_controller.dart';
import '../widgets/airplane_seats_image.dart';
import '../widgets/flight_travel_line.dart';
import '../widgets/seats_section.dart';

class ChooseSeatsScreen extends StatelessWidget {
  const ChooseSeatsScreen({super.key, required this.onSelect});

  final void Function(String seatId) onSelect;

  @override
  Widget build(BuildContext context) {
    final flight = context.watch<FlightController>().bookedFlight;
    final color = context.isDarkMode ? BlackColor.light : context.primaryColor;

    return ChangeNotifierProvider(
      create: (_) => SeatsController(
        fid: flight.fid,
        repo: Injections.inject(),
      ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
                            price: flight.businesCost,
                            rowsNo: flight.businessRows,
                            flightClass: FlightClass.business,
                            onConfirm: (sid) {
                              onSelect(sid);
                              context.pop();
                            },
                          ),
                          AppSizes.normalY,
                          SeatsSection(
                            rowSize: flight.rowSize,
                            price: flight.economyCost,
                            rowsNo: flight.economyRows,
                            flightClass: FlightClass.economy,
                            onConfirm: (sid) {
                              onSelect(sid);
                              context.pop();
                            },
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
