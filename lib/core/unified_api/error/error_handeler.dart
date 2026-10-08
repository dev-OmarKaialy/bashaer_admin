import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../extensions/log_colors_extension.dart';
import 'failure.dart';

/// Wraps a datasource call and turns any thrown error into a [Failure].
///
/// Datasources may throw a [Failure] themselves (it passes through untouched);
/// Firebase errors are mapped to translation keys under `errors.*`.
mixin HandlingException {
  Future<Either<Failure, T>> wrapHandling<T>({required Future<T> Function() tryCall}) async {
    try {
      return Right(await tryCall());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  /// Stream counterpart: data becomes [Right], errors become [Left] and the
  /// stream keeps running (Firestore listeners end after an error anyway).
  Stream<Either<Failure, T>> wrapStream<T>(Stream<T> Function() source) {
    return source().transform(
      StreamTransformer<T, Either<Failure, T>>.fromHandlers(
        handleData: (data, sink) => sink.add(Right(data)),
        handleError: (error, stackTrace, sink) =>
            sink.add(Left(ErrorHandler.handle(error).failure)),
      ),
    );
  }
}

class ErrorHandler implements Exception {
  late final Failure failure;

  ErrorHandler.handle(Object error) {
    if (error is Failure) {
      failure = error;
    } else if (error is FirebaseException) {
      log('Firebase error ${error.plugin}/${error.code}: ${error.message}'.logRed);
      failure = FirebaseFailure(message: _firestoreKey(error.code), code: error.code);
    } else if (error is TimeoutException) {
      failure = const FirebaseFailure(message: 'errors.network');
    } else {
      log('Unexpected error: $error'.logRed);
      failure = const ServerFailure(message: 'errors.unknown');
    }
  }

  static String _firestoreKey(String code) {
    switch (code) {
      case 'permission-denied':
        return 'errors.permissionDenied';
      case 'unavailable':
      case 'deadline-exceeded':
        return 'errors.network';
      case 'not-found':
        return 'errors.notFound';
      case 'already-exists':
        return 'errors.alreadyExists';
      case 'failed-precondition':
        return 'errors.missingIndex';
      default:
        return 'errors.unknown';
    }
  }
}
