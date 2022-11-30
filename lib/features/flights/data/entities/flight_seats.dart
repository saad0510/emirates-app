import 'flight_class.dart';

class FlightSeats {
  final int rows;
  final FlightClass flightClass;
  final Set<int> occupied;

  FlightSeats({
    required this.rows,
    required this.flightClass,
    required this.occupied,
  });
}
