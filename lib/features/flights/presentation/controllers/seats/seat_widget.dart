import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/assets.dart';
import 'seats_controller.dart';
import 'seats_state.dart';

class SeatWidget extends StatelessWidget {
  const SeatWidget({
    super.key,
    required this.seatId,
    required this.onSelected,
  });

  final String seatId;
  final void Function(String sid) onSelected;

  @override
  Widget build(BuildContext context) {
    final bool? occupied = context.select<SeatsController, bool?>(
      (c) {
        final state = (c.state as SeatsLoadedState);
        if (state.lock) return null;
        return state.seats.containsKey(seatId);
      },
    );

    Color color = Colors.blueAccent;
    if (occupied == true) color = Colors.grey.shade600;
    if (occupied == false) color = Colors.greenAccent.shade700;

    return InkWell(
      onTap: occupied == null || occupied ? null : () => onSelected(seatId),
      child: Image.asset(
        AppAssets.seat,
        fit: BoxFit.fitWidth,
        color: color,
      ),
    );
  }
}
