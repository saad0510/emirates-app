import '../../../../../core/errors/failures.dart';
import '../../../data/entities/city.dart';
import '../../../data/entities/flight.dart';

abstract class FlightState {}

class FlightEmptyState extends FlightState {}

class FlightLoadingState extends FlightState {
  final City departureCity;
  final City arrivalCity;

  FlightLoadingState(this.departureCity, this.arrivalCity);
}

class FlightLoadedState extends FlightState {
  final Iterable<Flight> flights;

  FlightLoadedState(this.flights);
}

class FlightErrorState extends FlightState {
  final FlightFailure failure;

  FlightErrorState(this.failure);
}
