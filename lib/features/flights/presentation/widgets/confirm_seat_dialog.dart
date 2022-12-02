import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../data/entities/flight_class.dart';

class ConfirmSeatDialog extends StatelessWidget {
  const ConfirmSeatDialog({
    super.key,
    required this.seatId,
    required this.price,
    required this.flightClass,
    required this.onConfirm,
  });

  final String seatId;
  final double price;
  final FlightClass flightClass;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('CLASS'),
            Text('SEAT'),
            Text('PRICE'),
          ],
        ),
        DefaultTextStyle(
          style: context.textTheme.headline4!.medium,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(flightClass.name),
              Text(seatId),
              Text('\$${price.roundToDouble()}'),
            ],
          ),
        ),
        AppSizes.normalY,
        ElevatedButton(
          onPressed: () {
            context.pop();
            onConfirm();
          },
          child: const Text("Confirm Seat"),
        ),
      ],
    );
  }
}
