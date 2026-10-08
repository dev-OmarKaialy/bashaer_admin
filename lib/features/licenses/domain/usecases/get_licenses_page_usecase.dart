import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/license_model.dart';
import '../../data/models/license_status.dart';
import '../repositories/licenses_repository.dart';

class GetLicensesPageParams {
  const GetLicensesPageParams({
    required this.filter,
    required this.now,
    this.cursor,
    this.pageSize = 50,
  });

  final LicenseQueryFilter filter;
  final DateTime now;
  final Object? cursor;
  final int pageSize;
}

@injectable
class GetLicensesPageUsecase implements UseCase<LicensesPageModel, GetLicensesPageParams> {
  GetLicensesPageUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Future<Either<Failure, LicensesPageModel>> call(GetLicensesPageParams params) {
    return _repository.getPage(
      filter: params.filter,
      now: params.now,
      pageSize: params.pageSize,
      cursor: params.cursor,
    );
  }
}
