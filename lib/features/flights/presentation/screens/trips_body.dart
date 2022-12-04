import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../../home/presentation/widgets/flight_ticket.dart';
import '../../data/entities/ticket.dart';
import '../controllers/ticket/ticket_controller.dart';
import '../controllers/ticket/ticket_state.dart';
import '../widgets/chip_selector.dart';
import '../widgets/state_icons.dart';

class TripsBody extends StatefulWidget {
  const TripsBody({super.key});

  @override
  State<TripsBody> createState() => _TripsBodyState();
}

class _TripsBodyState extends State<TripsBody> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => onChanged(0),
    );
    super.initState();
  }

  void onChanged(int selected) {
    final uid = context.read<AuthController>().user.uid;
    final controller = context.read<TicketController>();

    controller.listState = selected == 0 //
        ? TicketListState.upcoming
        : TicketListState.old;
    controller.getTickets(uid);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketController>().state;

    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalX,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChipSelector(
              onChanged: onChanged,
              values: const ['Upcoming trips', 'Past trips'],
            ),
            AppSizes.normalY,
            if (state is TicketEmptyState) //
              const Center(
                heightFactor: 1.5,
                child: WelcomeIcon(),
              )
            else if (state is TicketLoadingState)
              const Center(
                heightFactor: 10,
                child: CircularProgressIndicator(),
              )
            else if (state is TicketErrorState)
              Center(
                heightFactor: 1.5,
                child: ErrorIcon(errorMsg: state.failure.message),
              )
            else if (state is TicketLoadedState)
              ...state.tickets.map<Widget>(
                (ticket) => InkWell(
                  onTap: () => context.push(
                    AppRoutes.boardingPass,
                    arguments: [ticket],
                  ),
                  child: Padding(
                    padding: AppPaddings.normalY.copyWith(top: 0),
                    child: FlightTicket(ticket: ticket),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
