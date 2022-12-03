import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failures.dart';
import '../entities/city.dart';
import '../entities/flight.dart';
import '../entities/seat.dart';

abstract class FlightRepo {
  /// searches for all flights with given cities endpoints
  Future<Result<FlightFailure, Iterable<Flight>>> search(
    City departureCity,
    City arrivalCity,
  );

  /// opens a stream on seats of given flight id
  Result<FlightFailure, Stream<Iterable<Seat>>> listenSeatsFor(String fid);

  /// reserves given seat
  Future<Result<FlightFailure, Void>> reserveSeat(Seat seat);

  /// cancels given seat
  Future<Result<FlightFailure, Void>> cancelSeat(Seat seat);
}
