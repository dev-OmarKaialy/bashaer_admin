import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/license_model.dart';
import '../repositories/licenses_repository.dart';

/// One license, live, while its editor is open.
@injectable
class GetLicenseUsecase implements StreamUseCase<LicenseModel?, String> {
  GetLicenseUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Stream<Either<Failure, LicenseModel?>> call(String deviceId) =>
      _repository.licenseChanges(deviceId);
}
