import 'dart:async';

import '../../../../../core/utils/base_change_notifier.dart';
import '../../../data/entities/seat.dart';
import '../../../data/repositories/flight_repo.dart';
import 'seats_state.dart';

class SeatsController extends BaseChangeNotifier<SeatsState> {
  final String fid;
  final FlightRepo repo;
  StreamSubscription? stream;

  SeatsController({required this.repo, required this.fid}) //
      : super(SeatsLoadedState({}));

  @override
  Future<void> init() {
    final res = repo.listenSeatsFor(fid);
    res.when(
      (failure) => state = SeatsErrorState(failure),
      (stream) {
        this.stream = stream.listen(
          (seats) {
            final s = (state as SeatsLoadedState);
            s.seats.addAll(
              {
                for (final seat in seats) //
                  seat.seatNo: true,
              },
            );
            notifyListeners();
          },
        );
      },
    );

    return super.init();
  }

  Future<void> reserve(String seatId) async {
    final res = await repo.reserveSeat(
      Seat(flightId: fid, seatNo: seatId),
    );

    res.when(
      (failure) => state = SeatsErrorState(failure),
      (success) => null,
    );
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }
}
