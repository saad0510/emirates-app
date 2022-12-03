import '../../../../../core/utils/base_change_notifier.dart';
import '../../../data/entities/ticket.dart';
import '../../../data/repositories/ticket_repo.dart';
import 'ticket_state.dart';

class TicketController extends BaseChangeNotifier<TicketState> {
  final TicketRepo repo;
  TicketListState listState = TicketListState.all;
  Iterable<Ticket> upcoming = [];
  Iterable<Ticket> history = [];

  TicketController({required this.repo}) : super(TicketEmptyState(), debugMode: true);

  Future<void> generate(Ticket ticket) async {
    state = TicketLoadingState();

    final res = await repo.generateTicket(ticket);

    res.when(
      (failure) => state = TicketErrorState(failure),
      (_) => state = TicketEmptyState(),
    );
  }

  void getTickets(String uid, {bool refresh = false}) async {
    final isEmpty = listState == TicketListState.old //
        ? history.isEmpty
        : upcoming.isEmpty;

    if (refresh || isEmpty) {
      this.refresh(uid);
      return;
    }
    if (listState == TicketListState.old) {
      state = TicketLoadedState(history, listState);
    } else {
      state = TicketLoadedState(upcoming, listState);
    }
  }

  void refresh(String uid) async {
    state = TicketLoadingState();
    final res = await repo.getTickets(uid, listState);
    res.when(
      (failure) => state = TicketErrorState(failure),
      (tickets) {
        if (listState == TicketListState.old) {
          history = tickets;
        } else {
          upcoming = tickets;
        }
        state = TicketLoadedState(tickets, listState);
      },
    );
  }
}
