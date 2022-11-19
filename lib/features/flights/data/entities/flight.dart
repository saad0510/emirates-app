import 'flight_class.dart';

import 'city.dart';

class Flight {
  final String fid;
  final City departureCity;
  final City arrivalCity;
  final DateTime dateTime;
  final double cost;
  final FlightClass flightClass;

  const Flight({
    required this.fid,
    required this.departureCity,
    required this.arrivalCity,
    required this.dateTime,
    required this.cost,
    required this.flightClass,
  });
}
