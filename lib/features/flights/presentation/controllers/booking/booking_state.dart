abstract class BookingState {}

class BookingEmptyState extends BookingState {}

class BookingGeneratedState extends BookingState {
  final double totalPrice;

  BookingGeneratedState(this.totalPrice);
}

class BookingConfirmedState extends BookingState {}

class BookingCompletedState extends BookingState {}
