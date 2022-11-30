import 'package:flutter/material.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../data/entities/flight_seats.dart';
import '../../data/entities/seat.dart';

class SeatsSection extends StatelessWidget {
  const SeatsSection({
    super.key,
    required this.seats,
    required this.rowSize,
    required this.onSelected,
  });

  final int rowSize;
  final FlightSeats seats;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${seats.flightClass.name} class',
          textAlign: TextAlign.center,
          style: context.textTheme.subtitle2,
        ),
        AppSizes.normalY,
        ...List.generate(
          seats.rows,
          (row) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              rowSize,
              (col) {
                bool isOccupied = seats.occupied.contains(row * rowSize + col);
                final sid = seats.flightClass.prefix + Seat.getId(row + 1, col + 1);

                return Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: isOccupied ? null : () => onSelected(sid),
                    child: Image.asset(
                      AppAssets.seat,
                      fit: BoxFit.fitWidth,
                      color: isOccupied ? Colors.grey.shade600 : Colors.green.shade600,
                    ),
                  ),
                );
              },
            )..insert(
                rowSize ~/ 2,
                Expanded(
                  flex: 2,
                  child: Text(
                    '${row + 1}',
                    style: context.textTheme.subtitle2!.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ),
        ),
      ],
    );
  }
}
