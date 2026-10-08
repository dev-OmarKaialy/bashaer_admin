import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/license_status.dart';
import '../repositories/licenses_repository.dart';

/// Counts for the active / expiring / expired chips (aggregation queries).
@injectable
class GetLicenseCountsUsecase implements UseCase<Map<LicenseQueryFilter, int>, DateTime> {
  GetLicenseCountsUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Future<Either<Failure, Map<LicenseQueryFilter, int>>> call(DateTime now) =>
      _repository.getCounts(now);
}
