import '../models/ticket_model.dart';

abstract class TicketRemoteSrc {
  Future<void> generateTicket(TicketModel ticket);
}
