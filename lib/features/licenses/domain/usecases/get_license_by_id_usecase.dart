import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/license_model.dart';
import '../repositories/licenses_repository.dart';

/// Exact lookup of a pasted device id (one read).
@injectable
class GetLicenseByIdUsecase implements UseCase<LicenseModel?, String> {
  GetLicenseByIdUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Future<Either<Failure, LicenseModel?>> call(String deviceId) =>
      _repository.getById(deviceId.trim());
}
