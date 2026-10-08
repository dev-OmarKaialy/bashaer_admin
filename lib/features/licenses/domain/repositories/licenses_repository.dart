import 'package:dartz/dartz.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../data/models/license_model.dart';
import '../../data/models/license_status.dart';

abstract class LicensesRepository {
  Stream<Either<Failure, List<LicenseModel>>> inboxChanges({required int limit});

  Stream<Either<Failure, LicenseModel?>> licenseChanges(String deviceId);

  Future<Either<Failure, LicensesPageModel>> getPage({
    required LicenseQueryFilter filter,
    required DateTime now,
    required int pageSize,
    Object? cursor,
  });

  Future<Either<Failure, Map<LicenseQueryFilter, int>>> getCounts(DateTime now);

  Future<Either<Failure, List<LicenseModel>>> getApproved();

  Future<Either<Failure, LicenseModel?>> getById(String deviceId);

  Future<Either<Failure, Unit>> updateAccess({
    required String deviceId,
    required bool isActive,
    DateTime? activeUntil,
  });

  Future<Either<Failure, Unit>> updateProfile({
    required String deviceId,
    String? fullName,
    String? phoneNumber,
    String? note,
  });
}
