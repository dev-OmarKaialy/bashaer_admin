import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/admin_session_model.dart';
import '../repositories/auth_repository.dart';

/// The session remembered on this device, if the account and its password
/// are unchanged; otherwise null (sign in again).
@injectable
class GetAdminSessionUsecase implements UseCase<AdminSessionModel?, NoParams> {
  GetAdminSessionUsecase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AdminSessionModel?>> call(NoParams params) => _repository.restoreSession();
}
