import '../../data/entities/seat.dart';

class SeatModel extends Seat {
  const SeatModel({
    required super.flightId,
    required super.seatNo,
  });

  factory SeatModel.fromSeat(Seat seat) {
    return SeatModel(
      flightId: seat.flightId,
      seatNo: seat.seatNo,
    );
  }

  factory SeatModel.fromMap(Map<String, dynamic> map) {
    return SeatModel(
      flightId: map['fid'],
      seatNo: map['seat_no'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid': flightId,
      'seat_no': seatNo,
    };
  }
}
