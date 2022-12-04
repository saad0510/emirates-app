abstract class Failure {
  final String message;

  const Failure([this.message = ""]);

  @override
  bool operator ==(covariant Failure other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class CityFailure extends Failure {
  final String name;
  const CityFailure(this.name, super.message);
}

class FlightFailure extends Failure {
  const FlightFailure(super.message);
}

class TicketFailure extends Failure {
  final String tid;
  const TicketFailure(this.tid, super.message);
}

class NotificationFailure extends Failure {
  final String nid;
  const NotificationFailure(this.nid, super.message);
}
