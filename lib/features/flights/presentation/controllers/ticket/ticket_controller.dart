import '../../../../../core/utils/base_change_notifier.dart';
import '../../../data/entities/ticket.dart';
import '../../../data/repositories/ticket_repo.dart';
import 'ticket_state.dart';

class TicketController extends BaseChangeNotifier<TicketState> {
  final TicketRepo repo;
  int upcomingIndex = -1;
  int historyIndex = -1;

  TicketController({required this.repo}) : super(TicketEmptyState());

  Future<void> generate(Ticket ticket) async {
    state = TicketLoadingState();

    final res = await repo.generateTicket(ticket);

    res.when(
      (failure) => state = TicketErrorState(failure),
      (_) {
        upcomingIndex = 0;
        state = TicketUpcomingState([ticket]);
      },
    );
  }

  Ticket get bookedTicket => (state as TicketUpcomingState).tickets.first;
}
