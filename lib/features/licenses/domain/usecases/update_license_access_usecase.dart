import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/license_dates.dart';
import '../repositories/licenses_repository.dart';

class UpdateLicenseAccessParams {
  /// Approve, extend, renew or restore: access until the end of [until]'s day.
  const UpdateLicenseAccessParams.grant({required this.deviceId, required DateTime until})
    : isActive = true,
      activeUntil = until;

  /// Revoke: `isActive: false` and `activeUntil` kept, so the student sees
  /// "inactive" rather than "pending".
  const UpdateLicenseAccessParams.revoke({required this.deviceId})
    : isActive = false,
      activeUntil = null;

  final String deviceId;
  final bool isActive;
  final DateTime? activeUntil;
}

@injectable
class UpdateLicenseAccessUsecase implements UseCase<Unit, UpdateLicenseAccessParams> {
  UpdateLicenseAccessUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateLicenseAccessParams params) async {
    final until = params.activeUntil == null
        ? null
        : LicenseDates.endOfLocalDay(params.activeUntil!);
    if (params.isActive && (until == null || !until.isAfter(DateTime.now()))) {
      return const Left(ValidationFailure(message: 'licenses.errors.pastDate'));
    }
    return _repository.updateAccess(
      deviceId: params.deviceId,
      isActive: params.isActive,
      activeUntil: until,
    );
  }
}
