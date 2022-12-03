import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../auth/presentation/controllers/auth/auth_controller.dart';
import 'ticket_controller.dart';
import 'ticket_state.dart';

class TripsRefreshButton extends StatelessWidget {
  const TripsRefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketController>().state;

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: state is TicketLoadingState //
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      secondChild: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_horiz),
      ),
      firstChild: IconButton(
        onPressed: () {
          final uid = context.read<AuthController>().user.uid;
          context.read<TicketController>().refresh(uid);
        },
        icon: const Icon(Icons.refresh),
      ),
      firstCurve: Curves.decelerate,
      secondCurve: Curves.decelerate,
    );
  }
}
