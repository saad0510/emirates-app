import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failures.dart';
import '../entities/city.dart';
import '../entities/flight.dart';

abstract class FlightRepo {
  /// searches for all flights with given cities endpoints
  Future<Result<FlightFailure, Iterable<Flight>>> search(
    City departureCity,
    City arrivalCity,
  );
}
