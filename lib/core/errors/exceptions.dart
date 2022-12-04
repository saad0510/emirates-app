abstract class BaseException implements Exception {
  final String message;

  const BaseException([this.message = ""]);

  @override
  bool operator ==(covariant BaseException other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class RouteException extends BaseException {
  final String routeName;
  const RouteException(this.routeName, [super.message]);
}

class AuthException extends BaseException {
  final String action;
  const AuthException(this.action, super.message);
}

class CityException extends BaseException {
  final String name;
  const CityException(this.name, super.message);
}

class FlightException extends BaseException {
  const FlightException(super.message);
}

class TicketException extends BaseException {
  final String tid;
  const TicketException(this.tid, super.message);
}

class NotificationException extends BaseException {
  final String nid;
  const NotificationException(this.nid, super.message);
}
