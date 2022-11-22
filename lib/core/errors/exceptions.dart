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
