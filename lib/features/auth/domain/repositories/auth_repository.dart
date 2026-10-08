import 'package:dartz/dartz.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../data/models/admin_session_model.dart';

abstract class AuthRepository {
  /// The remembered session if it is still valid, otherwise null.
  Future<Either<Failure, AdminSessionModel?>> restoreSession();

  Future<Either<Failure, AdminSessionModel>> signIn({
    required String username,
    required String password,
  });

  Future<Either<Failure, Unit>> signOut();
}
