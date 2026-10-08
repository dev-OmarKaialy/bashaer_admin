import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/category_model.dart';
import '../repositories/categories_repository.dart';

/// Saves a new order: each category's `order` becomes its index, and only
/// the documents whose order actually changed are written (one batch).
@injectable
class UpdateCategoriesOrderUsecase implements UseCase<Unit, List<CategoryModel>> {
  UpdateCategoriesOrderUsecase(this._repository);

  final CategoriesRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(List<CategoryModel> ordered) {
    final changed = <String, int>{
      for (var i = 0; i < ordered.length; i++)
        if (ordered[i].order != i) ordered[i].slug: i,
    };
    if (changed.isEmpty) return Future.value(const Right(unit));
    return _repository.updateOrders(changed);
  }
}
