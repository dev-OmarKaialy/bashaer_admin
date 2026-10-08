import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/error_handeler.dart';
import '../../../../core/unified_api/error/failure.dart';
import '../../domain/repositories/licenses_repository.dart';
import '../datasources/licenses_remote_datasource.dart';
import '../models/license_model.dart';
import '../models/license_status.dart';

@Injectable(as: LicensesRepository)
class LicensesRepositoryImpl with HandlingException implements LicensesRepository {
  LicensesRepositoryImpl(this._remote);

  final RemoteLicensesDatasource _remote;

  @override
  Stream<Either<Failure, List<LicenseModel>>> inboxChanges({required int limit}) =>
      wrapStream(() => _remote.inboxChanges(limit: limit));

  @override
  Stream<Either<Failure, LicenseModel?>> licenseChanges(String deviceId) =>
      wrapStream(() => _remote.licenseChanges(deviceId));

  @override
  Future<Either<Failure, LicensesPageModel>> getPage({
    required LicenseQueryFilter filter,
    required DateTime now,
    required int pageSize,
    Object? cursor,
  }) {
    return wrapHandling(
      tryCall: () => _remote.getPage(filter: filter, now: now, pageSize: pageSize, cursor: cursor),
    );
  }

  @override
  Future<Either<Failure, Map<LicenseQueryFilter, int>>> getCounts(DateTime now) =>
      wrapHandling(tryCall: () => _remote.getCounts(now));

  @override
  Future<Either<Failure, List<LicenseModel>>> getApproved() =>
      wrapHandling(tryCall: _remote.getApproved);

  @override
  Future<Either<Failure, LicenseModel?>> getById(String deviceId) =>
      wrapHandling(tryCall: () => _remote.getById(deviceId));

  @override
  Future<Either<Failure, Unit>> updateAccess({
    required String deviceId,
    required bool isActive,
    DateTime? activeUntil,
  }) {
    return wrapHandling(
      tryCall: () async {
        await _remote.updateAccess(
          deviceId: deviceId,
          isActive: isActive,
          activeUntil: activeUntil,
        );
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({
    required String deviceId,
    String? fullName,
    String? phoneNumber,
    String? note,
  }) {
    return wrapHandling(
      tryCall: () async {
        await _remote.updateProfile(
          deviceId: deviceId,
          fullName: fullName,
          phoneNumber: phoneNumber,
          note: note,
        );
        return unit;
      },
    );
  }
}
