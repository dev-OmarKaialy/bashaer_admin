import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/license_model.dart';
import '../repositories/licenses_repository.dart';

/// Every approved license, for in-memory search by name or phone. Firestore
/// has no text search; at one school's volume a session cache is cheapest.
@injectable
class GetApprovedLicensesUsecase implements UseCase<List<LicenseModel>, NoParams> {
  GetApprovedLicensesUsecase(this._repository);

  final LicensesRepository _repository;

  @override
  Future<Either<Failure, List<LicenseModel>>> call(NoParams params) => _repository.getApproved();
}
