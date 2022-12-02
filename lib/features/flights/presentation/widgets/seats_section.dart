import 'package:flutter/material.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../data/entities/flight_class.dart';

class SeatsSection extends StatelessWidget {
  const SeatsSection({
    super.key,
    required this.rowsNo,
    required this.rowSize,
    required this.flightClass,
    required this.occupied,
    required this.onSelected,
  });

  final int rowSize;
  final int rowsNo;
  final FlightClass flightClass;
  final Set<int> occupied;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${flightClass.name} class',
          textAlign: TextAlign.center,
          style: context.textTheme.subtitle2,
        ),
        AppSizes.normalY,
        ...List.generate(
          rowsNo,
          (row) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              rowSize,
              (col) {
                bool isOccupied = occupied.contains(row * rowSize + col);
                final sid = flightClass.prefix + getId(row + 1, col + 1);

                return Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: isOccupied ? null : () => onSelected(sid),
                    child: Image.asset(
                      AppAssets.seat,
                      fit: BoxFit.fitWidth,
                      color: isOccupied ? Colors.grey.shade600 : Colors.greenAccent.shade700,
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

String getId(int row, int col) {
  row--;
  final row1 = row ~/ 26 + 1;
  final row2 = String.fromCharCode(row % 26 + 65);
  return '$row1$row2$col';
}
