import '../../../../../core/errors/failures.dart';

abstract class SeatsState {}

class SeatsLoadedState extends SeatsState {
  final Map<String, bool> seats;
  bool lock = false;

  SeatsLoadedState(this.seats);
}

class SeatsLoadingState extends SeatsState {}

class SeatsErrorState extends SeatsState {
  final FlightFailure failure;

  SeatsErrorState(this.failure);
}
