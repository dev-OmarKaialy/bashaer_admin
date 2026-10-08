import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode = -1});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class UnconfirmedFailure extends Failure {
  const UnconfirmedFailure({required super.message});
}

class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure({required super.message});
}

class UserNotAllowedFailure extends Failure {
  const UserNotAllowedFailure({required super.message});
}

class UserBlockedFailure extends Failure {
  const UserBlockedFailure({required super.message});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});
}

/// A Firestore/Auth/upload failure. [message] is a translation key under
/// `errors.*`, so the UI shows it with `.tr()` and never a raw exception.
class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.message, this.code});

  final String? code;

  @override
  List<Object?> get props => [message, statusCode, code];
}

/// Input rejected before anything was written. [message] is a translation key.
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, this.args = const {}});

  /// Named arguments for the translation (e.g. `{'count': '3'}`).
  final Map<String, String> args;

  @override
  List<Object?> get props => [message, statusCode, args];
}
