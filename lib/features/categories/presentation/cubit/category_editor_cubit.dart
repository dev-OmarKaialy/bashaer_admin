import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/category_model.dart';
import '../../domain/usecases/create_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';

part 'category_editor_cubit.freezed.dart';
part 'category_editor_state.dart';

/// Create or edit one category. The list cubit feeds it the current row, so
/// it needs no listener of its own.
@injectable
class CategoryEditorCubit extends Cubit<CategoryEditorState> {
  CategoryEditorCubit(this._create, this._update, this._delete)
    : super(const CategoryEditorState());

  final CreateCategoryUsecase _create;
  final UpdateCategoryUsecase _update;
  final DeleteCategoryUsecase _delete;
  int _seq = 0;
  int _nextOrder = 0;

  /// [category] null = new category placed at [nextOrder].
  void open(CategoryModel? category, {required int nextOrder}) {
    _nextOrder = nextOrder;
    if (category == null) return;
    emit(
      CategoryEditorState(
        original: category,
        slug: category.slug,
        name: category.name,
        icon: category.icon,
        description: category.description ?? '',
      ),
    );
  }

  void setSlug(String value) =>
      emit(state.copyWith(slug: value.trim().toLowerCase(), errors: _without('slug')));

  void setName(String value) => emit(state.copyWith(name: value, errors: _without('name')));

  void setIcon(String? value) => emit(state.copyWith(icon: value));

  void setDescription(String value) => emit(state.copyWith(description: value));

  Map<String, String> _without(String field) => {...state.errors}..remove(field);

  Future<void> save() async {
    if (state.isBusy) return;
    emit(state.copyWith(submitStatus: RequestStatus.loading));
    final result = state.isNew
        ? await _create(
            CreateCategoryParams(
              slug: state.slug,
              name: state.name,
              icon: state.icon,
              description: state.description,
              order: _nextOrder,
            ),
          )
        : await _update(
            UpdateCategoryParams(
              slug: state.original!.slug,
              name: state.name,
              icon: state.icon,
              description: state.description,
            ),
          );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          submitStatus: RequestStatus.failed,
          errors: _fieldErrors(failure),
          lastOutcome: CategoryEditorOutcome(
            seq: ++_seq,
            action: CategoryEditorAction.save,
            errorKey: failure.message,
          ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          submitStatus: RequestStatus.success,
          errors: const {},
          // The saved values are now the baseline.
          original: state.preview.copyWith(
            slug: state.isNew ? state.slug.trim() : state.original!.slug,
            order: state.isNew ? _nextOrder : state.original!.order,
          ),
          name: state.name.trim(),
          description: state.description.trim(),
          lastOutcome: CategoryEditorOutcome(seq: ++_seq, action: CategoryEditorAction.save),
        ),
      ),
    );
  }

  Map<String, String> _fieldErrors(Failure failure) => switch (failure.message) {
    'categories.errors.slugFormat' || 'categories.errors.slugTaken' => {'slug': failure.message},
    'categories.errors.nameRequired' => {'name': failure.message},
    _ => const {},
  };

  Future<void> delete() async {
    final original = state.original;
    if (original == null || state.isBusy) return;
    emit(state.copyWith(deleteStatus: RequestStatus.loading));
    final result = await _delete(original.slug);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteStatus: RequestStatus.failed,
          lastOutcome: CategoryEditorOutcome(
            seq: ++_seq,
            action: CategoryEditorAction.delete,
            errorKey: failure.message,
            errorArgs: failure is ValidationFailure ? failure.args : const {},
          ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          deleteStatus: RequestStatus.success,
          lastOutcome: CategoryEditorOutcome(seq: ++_seq, action: CategoryEditorAction.delete),
        ),
      ),
    );
  }
}
