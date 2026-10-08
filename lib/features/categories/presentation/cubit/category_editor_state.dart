part of 'category_editor_cubit.dart';

enum CategoryEditorAction { save, delete }

@freezed
abstract class CategoryEditorOutcome with _$CategoryEditorOutcome {
  const factory CategoryEditorOutcome({
    required int seq,
    required CategoryEditorAction action,
    String? errorKey,
    @Default(<String, String>{}) Map<String, String> errorArgs,
  }) = _CategoryEditorOutcome;
}

@freezed
abstract class CategoryEditorState with _$CategoryEditorState {
  const factory CategoryEditorState({
    /// Null while creating a new category.
    CategoryModel? original,
    @Default('') String slug,
    @Default('') String name,
    String? icon,
    @Default('') String description,

    /// Field → translation key, shown under the field after a failed save.
    @Default(<String, String>{}) Map<String, String> errors,
    @Default(RequestStatus.init) RequestStatus submitStatus,
    @Default(RequestStatus.init) RequestStatus deleteStatus,
    CategoryEditorOutcome? lastOutcome,
  }) = _CategoryEditorState;

  const CategoryEditorState._();

  bool get isNew => original == null;

  bool get isDirty {
    final current = original;
    if (current == null) {
      return slug.trim().isNotEmpty ||
          name.trim().isNotEmpty ||
          (icon ?? '').isNotEmpty ||
          description.trim().isNotEmpty;
    }
    return name.trim() != current.name ||
        (icon ?? '') != (current.icon ?? '') ||
        description.trim() != (current.description ?? '');
  }

  bool get isBusy => submitStatus.isLoading || deleteStatus.isLoading;

  /// What the preview shows.
  CategoryModel get preview => CategoryModel(
    slug: slug,
    name: name.trim(),
    icon: icon,
    description: description.trim().isEmpty ? null : description.trim(),
    order: original?.order ?? 0,
  );
}
