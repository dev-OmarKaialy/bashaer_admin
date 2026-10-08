import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/license_model.dart';
import '../repositories/licenses_repository.dart';

class GetInboxLicensesParams {
  const GetInboxLicensesParams({this.limit = 100});

  final int limit;
}

/// Live list of pending requests and revoked rows, newest first.
@injectable
class GetInboxLicensesUsecase implements StreamUseCase<List<LicenseModel>, GetInboxLicensesParams> {
  GetInboxLicensesUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Stream<Either<Failure, List<LicenseModel>>> call(GetInboxLicensesParams params) =>
      _repository.inboxChanges(limit: params.limit);
}
