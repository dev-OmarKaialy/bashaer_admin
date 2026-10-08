import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/categories_repository.dart';

/// Deletes do not cascade: a deleted category would orphan its questions. The
/// rules can't check that, so this use case counts first and refuses to
/// delete a category that still has questions.
@injectable
class DeleteCategoryUsecase implements UseCase<Unit, String> {
  DeleteCategoryUsecase(this._repository);

  final CategoriesRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String slug) async {
    final counted = await _repository.countQuestions(slug);
    return counted.fold(Left.new, (count) {
      if (count > 0) {
        return Left(
          ValidationFailure(message: 'categories.errors.notEmpty', args: {'count': '$count'}),
        );
      }
      return _repository.deleteCategory(slug);
    });
  }
}
