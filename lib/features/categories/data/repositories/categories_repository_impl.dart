import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/error_handeler.dart';
import '../../../../core/unified_api/error/failure.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_datasource.dart';
import '../models/category_model.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl with HandlingException implements CategoriesRepository {
  CategoriesRepositoryImpl(this._remote);

  final RemoteCategoriesDatasource _remote;

  @override
  Stream<Either<Failure, List<CategoryModel>>> categoriesChanges() =>
      wrapStream(_remote.categoriesChanges);

  @override
  Future<Either<Failure, Unit>> createCategory(CategoryModel category) => wrapHandling(
    tryCall: () async {
      await _remote.createCategory(category);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> updateCategory({
    required String slug,
    required String name,
    String? icon,
    String? description,
  }) => wrapHandling(
    tryCall: () async {
      await _remote.updateCategory(slug: slug, name: name, icon: icon, description: description);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> updateOrders(Map<String, int> orderBySlug) => wrapHandling(
    tryCall: () async {
      await _remote.updateOrders(orderBySlug);
      return unit;
    },
  );

  @override
  Future<Either<Failure, int>> countQuestions(String slug) =>
      wrapHandling(tryCall: () => _remote.countQuestions(slug));

  @override
  Future<Either<Failure, Unit>> deleteCategory(String slug) => wrapHandling(
    tryCall: () async {
      await _remote.deleteCategory(slug);
      return unit;
    },
  );
}
