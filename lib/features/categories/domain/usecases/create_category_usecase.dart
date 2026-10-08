import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/category_model.dart';
import '../repositories/categories_repository.dart';

class CreateCategoryParams {
  const CreateCategoryParams({
    required this.slug,
    required this.name,
    required this.order,
    this.icon,
    this.description,
  });

  final String slug;
  final String name;
  final String? icon;
  final String? description;

  /// Position at the end of the list (max order + 1).
  final int order;
}

/// New category. The slug becomes the document id and is permanent, so it is
/// validated here (kebab-case, as in `question-bank-contract.md`). Existing
/// legacy camelCase slugs are never re-validated.
@injectable
class CreateCategoryUsecase implements UseCase<Unit, CreateCategoryParams> {
  CreateCategoryUsecase(this._repository);

  final CategoriesRepository _repository;

  static final RegExp slugPattern = RegExp(r'^[a-z0-9]+(-[a-z0-9]+)*$');

  @override
  Future<Either<Failure, Unit>> call(CreateCategoryParams params) {
    final slug = params.slug.trim();
    final name = params.name.trim();
    if (!slugPattern.hasMatch(slug)) {
      return Future.value(const Left(ValidationFailure(message: 'categories.errors.slugFormat')));
    }
    if (name.isEmpty) {
      return Future.value(const Left(ValidationFailure(message: 'categories.errors.nameRequired')));
    }
    return _repository.createCategory(
      CategoryModel(
        slug: slug,
        name: name,
        icon: _clean(params.icon),
        description: _clean(params.description),
        order: params.order,
      ),
    );
  }

  static String? _clean(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? null : text;
  }
}
