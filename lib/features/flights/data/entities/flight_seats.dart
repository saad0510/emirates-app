import 'flight_class.dart';

class FlightSeats {
  final int count;
  final FlightClass flightClass;
  final Map<int, bool> occupied;

  FlightSeats({
    required this.count,
    required this.flightClass,
    required this.occupied,
  });
}
