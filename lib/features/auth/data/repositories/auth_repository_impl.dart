import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/error_handeler.dart';
import '../../../../core/unified_api/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/admin_account_model.dart';
import '../models/admin_session_model.dart';
import '../models/password_hasher.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl with HandlingException implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local);

  final RemoteAuthDatasource _remote;
  final LocalAuthDatasource _local;

  @override
  Future<Either<Failure, AdminSessionModel?>> restoreSession() {
    return wrapHandling(
      tryCall: () async {
        final stored = await _local.read();
        if (stored == null) return null;
        final account = await _remote.getById(stored.adminId);
        // Deleted account or changed password: the session is over.
        if (account == null || account.passwordHash != stored.passwordHash) {
          await _local.clear();
          return null;
        }
        return _sessionOf(account);
      },
    );
  }

  @override
  Future<Either<Failure, AdminSessionModel>> signIn({
    required String username,
    required String password,
  }) {
    return wrapHandling(
      tryCall: () async {
        const invalid = ValidationFailure(message: 'auth.errors.invalidCredentials');
        final account = await _remote.findByUsername(username.trim());
        print(account?.username);
        if (account == null) throw invalid;
        final iterations = account.iterations;
        if (iterations == null || account.salt.isEmpty || account.passwordHash.isEmpty) {
          throw const ValidationFailure(message: 'auth.errors.accountNotSetUp');
        }
        final ok = await compute(_verify, (
          password,
          account.salt,
          iterations,
          account.passwordHash,
        ));
        if (!ok) throw invalid;
        await _local.write(StoredSession(adminId: account.id, passwordHash: account.passwordHash));
        return _sessionOf(account);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> signOut() {
    return wrapHandling(
      tryCall: () async {
        await _local.clear();
        return unit;
      },
    );
  }

  static AdminSessionModel _sessionOf(AdminAccountModel account) => AdminSessionModel(
    id: account.id,
    username: account.username,
    displayName: account.displayName,
  );

  /// Top-level-style entry for [compute] (runs off the UI isolate on Android).
  static bool _verify((String, String, int, String) input) {
    final (password, salt, iterations, expected) = input;
    try {
      return PasswordHasher.verify(
        password: password,
        salt: salt,
        iterations: iterations,
        expectedHash: expected,
      );
    } on FormatException {
      return false;
    }
  }
}
