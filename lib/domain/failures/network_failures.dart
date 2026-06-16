import 'failure_interface.dart';

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, required super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, required super.statusCode});
}

class RateLimitFailure extends Failure {
  const RateLimitFailure({required super.message, required super.statusCode});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, required super.statusCode});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}
