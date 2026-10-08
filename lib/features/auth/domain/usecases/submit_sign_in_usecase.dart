import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/admin_session_model.dart';
import '../repositories/auth_repository.dart';

class SubmitSignInParams {
  const SubmitSignInParams({required this.username, required this.password});

  final String username;
  final String password;
}

@injectable
class SubmitSignInUsecase implements UseCase<AdminSessionModel, SubmitSignInParams> {
  SubmitSignInUsecase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AdminSessionModel>> call(SubmitSignInParams params) =>
      _repository.signIn(username: params.username, password: params.password);
}
