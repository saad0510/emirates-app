import 'flight_class.dart';

class Ticket {
  final String flightId;
  final String seatId;
  final String name;
  final String createdBy;
  final FlightClass flightClass;

  const Ticket({
    required this.flightId,
    required this.seatId,
    required this.name,
    required this.createdBy,
    required this.flightClass,
  });
}
