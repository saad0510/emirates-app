import 'city.dart';

class Flight {
  final String fid;
  final City departureCity;
  final City arrivalCity;
  final DateTime dateTime;

  const Flight({
    required this.fid,
    required this.departureCity,
    required this.arrivalCity,
    required this.dateTime,
  });
}
