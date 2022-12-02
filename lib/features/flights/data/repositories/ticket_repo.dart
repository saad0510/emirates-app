import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

abstract class TicketRepo {
  /// generates a new ticket for user after payment
  Future<Result<TicketFailure, Void>> generateTicket(Ticket ticket);
}
