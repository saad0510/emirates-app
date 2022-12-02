import 'city.dart';

class Flight {
  final String fid;
  final int rowSize;
  final int economyRows;
  final int businessRows;
  final double economyCost;
  final double businesCost;
  final City arrivalCity;
  final City departureCity;
  final DateTime arrivalTime;
  final DateTime departureTime;

  const Flight({
    required this.fid,
    required this.rowSize,
    required this.economyRows,
    required this.businessRows,
    required this.economyCost,
    required this.businesCost,
    required this.arrivalCity,
    required this.departureCity,
    required this.arrivalTime,
    required this.departureTime,
  });

  int get economySeats => rowSize * economyRows;
  int get businessSeats => rowSize * businessRows;
  int get totalSeats => rowSize * (businessRows + economyRows);
}
