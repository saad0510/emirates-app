abstract class Failure {
  final String message;

  Failure([this.message = ""]);

  @override
  bool operator ==(covariant Failure other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
