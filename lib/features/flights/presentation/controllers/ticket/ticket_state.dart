import '../../../../../core/errors/failures.dart';
import '../../../data/entities/ticket.dart';

abstract class TicketState {}

class TicketEmptyState extends TicketState {}

class TicketLoadingState extends TicketState {}

class TicketErrorState extends TicketState {
  final TicketFailure failure;

  TicketErrorState(this.failure);
}

class TicketUpcomingState extends TicketState {
  final Iterable<Ticket> tickets;

  TicketUpcomingState(this.tickets);
}

class TicketHistoryState extends TicketState {
  final Iterable<Ticket> tickets;

  TicketHistoryState(this.tickets);
}
