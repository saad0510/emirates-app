import '../../data/entities/ticket.dart';
import '../models/ticket_model.dart';

abstract class TicketRemoteSrc {
  Future<void> generateTicket(TicketModel ticket);

  Future<Iterable<TicketModel>> getAllTickets(
    String uid,
    TicketListState state,
  );
}
