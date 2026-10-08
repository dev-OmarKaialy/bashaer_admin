part of 'categories_cubit.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default(RequestStatus.init) RequestStatus status,
    String? errorKey,
    @Default(<CategoryModel>[]) List<CategoryModel> categories,
    @Default(RequestStatus.init) RequestStatus reorderStatus,

    /// Bumped on every finished reorder, so the screen toasts once per drop.
    @Default(0) int reorderSeq,
    String? reorderErrorKey,
  }) = _CategoriesState;

  const CategoriesState._();

  CategoryModel? bySlug(String slug) {
    for (final category in categories) {
      if (category.slug == slug) return category;
    }
    return null;
  }

  /// `order` for a new category: after the last one.
  int get nextOrder => categories.fold<int>(-1, (max, c) => c.order > max ? c.order : max) + 1;
}
