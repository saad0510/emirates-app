import '../models/city_model.dart';
import '../models/flight_model.dart';

abstract class FlightRemoteSrc {
  Future<Iterable<FlightModel>> search(
    CityModel departureCity,
    CityModel arrivalCity,
  );
}
