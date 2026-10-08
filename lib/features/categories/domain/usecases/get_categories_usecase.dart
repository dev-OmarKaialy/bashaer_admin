import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/category_model.dart';
import '../repositories/categories_repository.dart';

@injectable
class GetCategoriesUsecase implements StreamUseCase<List<CategoryModel>, NoParams> {
  GetCategoriesUsecase(this._repository);

  final CategoriesRepository _repository;

  @override
  Stream<Either<Failure, List<CategoryModel>>> call(NoParams params) =>
      _repository.categoriesChanges();
}
