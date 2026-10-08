import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/arabic_normalizer.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/question_model.dart';
import '../../domain/usecases/get_questions_usecase.dart';

part 'questions_cubit.freezed.dart';
part 'questions_state.dart';

/// Live question bank for the session: the questions tab, category counts
/// (no extra reads) and qid allocation all use it.
@lazySingleton
class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit(this._getQuestions) : super(const QuestionsState());

  final GetQuestionsUsecase _getQuestions;
  StreamSubscription<Either<Failure, List<QuestionModel>>>? _subscription;

  /// Opens the listener on first use (questions or categories tab).
  void start() {
    if (_subscription != null) return;
    emit(state.copyWith(status: RequestStatus.loading));
    _subscription = _getQuestions(const NoParams()).listen(_onQuestions);
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
    emit(const QuestionsState());
  }

  void _onQuestions(Either<Failure, List<QuestionModel>> result) {
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: RequestStatus.failed, errorKey: failure.message)),
      (questions) {
        final counts = <String, int>{};
        for (final question in questions) {
          counts[question.categorySlug] = (counts[question.categorySlug] ?? 0) + 1;
        }
        _emitFiltered(
          state.copyWith(
            status: RequestStatus.success,
            errorKey: null,
            all: questions,
            countsByCategory: counts,
          ),
        );
      },
    );
  }

  void setQuery(String query) =>
      _emitFiltered(state.copyWith(filters: state.filters.copyWith(query: query.trim())));

  void setCategory(String? slug) =>
      _emitFiltered(state.copyWith(filters: state.filters.copyWith(categorySlug: slug)));

  void setType(QuestionType? type) =>
      _emitFiltered(state.copyWith(filters: state.filters.copyWith(type: type)));

  void toggleWithImage() => _emitFiltered(
    state.copyWith(filters: state.filters.copyWith(withImageOnly: !state.filters.withImageOnly)),
  );

  void toggleTrial() => _emitFiltered(
    state.copyWith(filters: state.filters.copyWith(trialOnly: !state.filters.trialOnly)),
  );

  /// Opened from a category ("show its questions"): only that filter.
  void showCategory(String slug) =>
      _emitFiltered(state.copyWith(filters: QuestionFilters(categorySlug: slug)));

  void clearFilters() => _emitFiltered(state.copyWith(filters: const QuestionFilters()));

  /// One pass over the bank; runs only when the data or a filter changes.
  void _emitFiltered(QuestionsState next) {
    final f = next.filters;
    final needle = normalizeForSearch(f.query);
    final visible = [
      for (final q in next.all)
        if ((f.categorySlug == null || q.categorySlug == f.categorySlug) &&
            (f.type == null || q.type == f.type) &&
            (!f.withImageOnly || q.image != null) &&
            (!f.trialOnly || q.isTrial) &&
            (needle.isEmpty || q.searchKey.contains(needle)))
          q,
    ];
    emit(next.copyWith(visible: visible));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
