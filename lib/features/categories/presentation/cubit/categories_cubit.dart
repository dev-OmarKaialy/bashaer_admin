import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/category_model.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/update_categories_order_usecase.dart';

part 'categories_cubit.freezed.dart';
part 'categories_state.dart';

/// Live category list for the session (also used by the question editor's
/// category picker and the question filters).
@lazySingleton
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._getCategories, this._updateOrder) : super(const CategoriesState());

  final GetCategoriesUsecase _getCategories;
  final UpdateCategoriesOrderUsecase _updateOrder;
  StreamSubscription<Either<Failure, List<CategoryModel>>>? _subscription;

  /// While a reorder is being written, the stream may still echo the old
  /// order; keep showing the dropped order until the write finishes.
  bool _reordering = false;

  void start() {
    if (_subscription != null) return;
    emit(state.copyWith(status: RequestStatus.loading));
    _subscription = _getCategories(const NoParams()).listen(_onCategories);
  }

  void retry() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    start();
  }

  Future<void> reset() async {
    await _subscription?.cancel();
    _subscription = null;
    if (isClosed) return;
    emit(const CategoriesState());
  }

  void _onCategories(Either<Failure, List<CategoryModel>> result) {
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: RequestStatus.failed, errorKey: failure.message)),
      (categories) {
        if (_reordering) return;
        emit(state.copyWith(status: RequestStatus.success, categories: categories, errorKey: null));
      },
    );
  }

  /// Drag-and-drop result (`onReorderItem`: [target] is the final index).
  Future<void> moveItem(int oldIndex, int target) async {
    if (state.reorderStatus.isLoading) return;
    if (target == oldIndex) return;
    final previous = state.categories;
    final reordered = [...previous];
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(target, moved);

    _reordering = true;
    emit(state.copyWith(categories: reordered, reorderStatus: RequestStatus.loading));
    final result = await _updateOrder(reordered);
    _reordering = false;
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          categories: previous,
          reorderStatus: RequestStatus.failed,
          reorderErrorKey: failure.message,
          reorderSeq: state.reorderSeq + 1,
        ),
      ),
      (_) => emit(
        state.copyWith(
          // Orders now equal indexes; the listener confirms shortly after.
          categories: [for (var i = 0; i < reordered.length; i++) reordered[i].copyWith(order: i)],
          reorderStatus: RequestStatus.success,
          reorderErrorKey: null,
          reorderSeq: state.reorderSeq + 1,
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
