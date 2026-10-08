import 'package:dartz/dartz.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../data/models/category_model.dart';

abstract class CategoriesRepository {
  Stream<Either<Failure, List<CategoryModel>>> categoriesChanges();

  Future<Either<Failure, Unit>> createCategory(CategoryModel category);

  Future<Either<Failure, Unit>> updateCategory({
    required String slug,
    required String name,
    String? icon,
    String? description,
  });

  Future<Either<Failure, Unit>> updateOrders(Map<String, int> orderBySlug);

  Future<Either<Failure, int>> countQuestions(String slug);

  Future<Either<Failure, Unit>> deleteCategory(String slug);
}
