abstract class BaseException implements Exception {
  final String message;

  BaseException([this.message = ""]);

  @override
  bool operator ==(covariant BaseException other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class RouteException extends BaseException {
  final String routeName;
  RouteException(this.routeName, [super.message]);
}
