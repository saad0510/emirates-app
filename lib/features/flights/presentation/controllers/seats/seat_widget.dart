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
    final occupied = context.select<SeatsController, bool>(
      (c) {
        final state = (c.state as SeatsLoadedState);
        return state.seats.containsKey(seatId);
      },
    );

    print('seat $seatId selected');

    return InkWell(
      onTap: occupied ? null : () => onSelected(seatId),
      child: Image.asset(
        AppAssets.seat,
        fit: BoxFit.fitWidth,
        color: occupied ? Colors.grey.shade600 : Colors.greenAccent.shade700,
      ),
    );
  }
}
