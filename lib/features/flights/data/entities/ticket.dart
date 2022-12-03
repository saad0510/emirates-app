import 'flight.dart';
import 'flight_class.dart';

enum TicketListState { old, upcoming, all }

class Ticket {
  final String ticketId;
  final String name;
  final String createdBy;
  final String seatId;
  final Flight flight;

  const Ticket({
    required this.ticketId,
    required this.flight,
    required this.seatId,
    required this.name,
    required this.createdBy,
  });

  FlightClass get flightClass => FlightClass.fromId(seatId);
  double get price => flightClass == FlightClass.business //
      ? flight.businesCost
      : flight.economyCost;
}
