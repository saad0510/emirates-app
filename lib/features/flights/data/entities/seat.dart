import 'flight_class.dart';

class Seat {
  final String seatId;
  final double price;
  final FlightClass flightClass;

  const Seat({
    required this.seatId,
    required this.price,
    required this.flightClass,
  });

  Seat.fromPosition({
    required int col,
    required int row,
    required this.price,
    required this.flightClass,
  }) : seatId = flightClass.prefix + getId(col, row);

  static String getId(int row, int col) {
    row--;
    final row1 = row ~/ 26 + 1;
    final row2 = String.fromCharCode(row % 26 + 65);
    return '$row1$row2$col';
  }
}
