import '../../../../../core/errors/failures.dart';

abstract class SeatsState {}

class SeatsLoadedState extends SeatsState {
  final Map<String, bool> seats;

  SeatsLoadedState(this.seats);
}

class SeatsErrorState extends SeatsState {
  final FlightFailure failure;

  SeatsErrorState(this.failure);
}
