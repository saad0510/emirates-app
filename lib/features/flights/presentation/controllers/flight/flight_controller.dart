import '../../../../../core/utils/base_change_notifier.dart';
import '../../../data/entities/city.dart';
import '../../../data/entities/flight.dart';
import '../../../data/repositories/flight_repo.dart';
import 'flight_state.dart';

class FlightController extends BaseChangeNotifier<FlightState> {
  final FlightRepo repo;
  int bookingIndex = -1;

  FlightController({required this.repo}) : super(FlightEmptyState(), debugMode: true);

  void search(City departureCity, City arrivalCity) async {
    state = FlightLoadingState(departureCity, arrivalCity);

    final res = await repo.search(departureCity, arrivalCity);

    res.when(
      (failure) => state = FlightErrorState(failure),
      (flights) => state = FlightLoadedState(flights),
    );
  }

  Flight get bookedFlight {
    return (state as FlightLoadedState).flights.elementAt(bookingIndex);
  }

  void filterNewFlights(Iterable<Flight> filtered) {
    state = FlightLoadedState(filtered);
  }
}
