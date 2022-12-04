import '../../../../../core/utils/base_change_notifier.dart';
import '../../../data/entities/flight.dart';
import '../../../data/entities/seat.dart';
import '../../../data/entities/ticket.dart';
import '../../../data/repositories/flight_repo.dart';
import 'booking_state.dart';

class BookingController extends BaseChangeNotifier<BookingState> {
  final Flight flight;
  final FlightRepo repo;

  double totalPrice = 0;
  List<Ticket> tickets = [];
  List<String> names = [];
  List<String> seats = [];

  BookingController({
    required this.flight,
    required this.repo,
  }) : super(BookingEmptyState(), debugMode: true);

  set quantity(int size) {
    clean();
    names = List.filled(size, '');
    seats = List.filled(size, '');
  }

  void generateTickets(String uid) {
    tickets = List.generate(
      names.length,
      (i) {
        final t = Ticket(
          ticketId: ' ',
          flight: flight,
          seatId: seats[i],
          name: names[i],
          createdBy: uid,
        );
        totalPrice += t.price;
        return t;
      },
    );
    state = BookingGeneratedState(totalPrice);
  }

  void confirmBooking() => state = BookingConfirmedState();

  void completeBooking() {
    seats = [];
    names = [];
    state = BookingCompletedState();
  }

  Future<void> clean() async {
    for (final seatId in seats) {
      await repo.cancelSeat(
        Seat(
          flightId: flight.fid,
          seatNo: seatId,
        ),
      );
    }
  }

  @override
  void dispose() async {
    clean();
    super.dispose();
  }
}
