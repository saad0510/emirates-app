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
