import '../../data/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.flightId,
    required super.seatId,
    required super.name,
    required super.createdBy,
    required super.flightClass,
  });

  factory TicketModel.fromTicket(Ticket ticket) {
    return TicketModel(
      flightId: ticket.flightId,
      seatId: ticket.seatId,
      name: ticket.name,
      createdBy: ticket.createdBy,
      flightClass: ticket.flightClass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid': flightId,
      'seat_no': seatId,
      'created_by': createdBy,
      'name': name,
      'class': flightClass.name,
    };
  }
}
