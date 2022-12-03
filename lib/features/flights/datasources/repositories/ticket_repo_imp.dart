import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../data/entities/ticket.dart';
import '../../data/repositories/ticket_repo.dart';
import '../models/ticket_model.dart';
import '../sources/ticket_remote_src.dart';

class TicketRepoImp implements TicketRepo {
  final TicketRemoteSrc remoteSrc;

  TicketRepoImp({required this.remoteSrc});

  @override
  Future<Result<TicketFailure, Void>> generateTicket(Ticket ticket) async {
    try {
      await remoteSrc.generateTicket(
        TicketModel.fromTicket(ticket),
      );
      return const Success(success);
    } on TicketException catch (e) {
      return Error(TicketFailure(e.tid, e.message));
    }
  }

  @override
  Future<Result<TicketFailure, Iterable<Ticket>>> getTickets(
    String uid,
    TicketListState state,
  ) async {
    try {
      final tickets = await remoteSrc.getAllTickets(uid, state);
      return Success(tickets);
    } on TicketException catch (e) {
      return Error(TicketFailure(e.tid, e.message));
    }
  }
}
