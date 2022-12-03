import '../../../../../core/errors/failures.dart';
import '../../../data/entities/ticket.dart';

abstract class TicketState {}

class TicketEmptyState extends TicketState {}

class TicketLoadingState extends TicketState {}

class TicketLoadedState extends TicketState {
  final TicketListState state;
  final Iterable<Ticket> tickets;

  TicketLoadedState(this.tickets, this.state);
}

class TicketErrorState extends TicketState {
  final TicketFailure failure;

  TicketErrorState(this.failure);
}
