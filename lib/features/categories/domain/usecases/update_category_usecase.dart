import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/categories_repository.dart';

class UpdateCategoryParams {
  const UpdateCategoryParams({required this.slug, required this.name, this.icon, this.description});

  final String slug;
  final String name;
  final String? icon;
  final String? description;
}

/// Merge-updates name, icon and description only. The slug never changes.
@injectable
class UpdateCategoryUsecase implements UseCase<Unit, UpdateCategoryParams> {
  UpdateCategoryUsecase(this._repository);

  final CategoriesRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateCategoryParams params) {
    final name = params.name.trim();
    if (name.isEmpty) {
      return Future.value(const Left(ValidationFailure(message: 'categories.errors.nameRequired')));
    }
    final icon = params.icon?.trim() ?? '';
    final description = params.description?.trim() ?? '';
    return _repository.updateCategory(
      slug: params.slug,
      name: name,
      icon: icon.isEmpty ? null : icon,
      description: description.isEmpty ? null : description,
    );
  }
}
