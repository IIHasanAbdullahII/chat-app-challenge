abstract class Failure{
  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  final String? message;

  const ServerFailure(this.message);

  @override
  bool operator == (Object other) =>
  other is ServerFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

class FirebaseAuthExceptionFailure extends Failure {
  final String? message;

  FirebaseAuthExceptionFailure(this.message);
  @override
  bool  operator==(Object other) {
    return other is FirebaseAuthExceptionFailure && other.message == message;
  }
}