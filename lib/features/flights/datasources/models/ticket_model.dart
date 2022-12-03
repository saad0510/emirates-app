import '../../data/entities/ticket.dart';
import 'flight_model.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.ticketId,
    required super.flight,
    required super.seatId,
    required super.name,
    required super.createdBy,
  });

  factory TicketModel.fromTicket(Ticket ticket) {
    return TicketModel(
      ticketId: ticket.ticketId,
      flight: ticket.flight,
      seatId: ticket.seatId,
      name: ticket.name,
      createdBy: ticket.createdBy,
    );
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      ticketId: map['ticket_id'],
      flight: FlightModel.fromMap(map['flight_data']),
      seatId: map['seat_no'],
      createdBy: map['created_by'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid': flight.fid,
      'seat_no': seatId,
      'created_by': createdBy,
      'name': name,
    };
  }
}
