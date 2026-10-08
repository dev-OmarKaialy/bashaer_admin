import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/licenses_repository.dart';

class UpdateLicenseProfileParams {
  const UpdateLicenseProfileParams({
    required this.deviceId,
    this.fullName,
    this.phoneNumber,
    this.note,
  });

  final String deviceId;
  final String? fullName;
  final String? phoneNumber;
  final String? note;
}

/// Writes only `fullName`, `phoneNumber` and `note`. Blank values remove the
/// field; the phone keeps digits and a leading `+` only.
@injectable
class UpdateLicenseProfileUsecase implements UseCase<Unit, UpdateLicenseProfileParams> {
  UpdateLicenseProfileUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateLicenseProfileParams params) {
    return _repository.updateProfile(
      deviceId: params.deviceId,
      fullName: _clean(params.fullName),
      phoneNumber: _phone(params.phoneNumber),
      note: _clean(params.note),
    );
  }

  static String? _clean(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? null : text;
  }

  static String? _phone(String? value) {
    final text = _clean(value);
    if (text == null) return null;
    final digits = text.replaceAll(RegExp(r'[^\d+]'), '');
    final normalized = digits.startsWith('+')
        ? '+${digits.substring(1).replaceAll('+', '')}'
        : digits.replaceAll('+', '');
    return normalized.isEmpty ? null : normalized;
  }
}
