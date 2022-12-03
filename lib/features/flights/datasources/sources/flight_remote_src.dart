import '../models/city_model.dart';
import '../models/flight_model.dart';
import '../models/seat_model.dart';

abstract class FlightRemoteSrc {
  Future<Iterable<FlightModel>> search(
    CityModel departureCity,
    CityModel arrivalCity,
  );

  Stream<Iterable<SeatModel>> seatsOf(String fid);

  Future<void> reserveSeat(SeatModel seatModel);

  Future<void> cancelSeat(SeatModel seatModel);
}
