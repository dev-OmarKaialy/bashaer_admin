part of 'questions_cubit.dart';

@freezed
abstract class QuestionFilters with _$QuestionFilters {
  const factory QuestionFilters({
    String? categorySlug,
    QuestionType? type,
    @Default(false) bool withImageOnly,
    @Default(false) bool trialOnly,
    @Default('') String query,
  }) = _QuestionFilters;

  const QuestionFilters._();

  bool get isActive =>
      categorySlug != null || type != null || withImageOnly || trialOnly || query.isNotEmpty;
}

@freezed
abstract class QuestionsState with _$QuestionsState {
  const factory QuestionsState({
    @Default(RequestStatus.init) RequestStatus status,
    String? errorKey,

    /// Whole bank, numeric qid order.
    @Default(<QuestionModel>[]) List<QuestionModel> all,

    /// What the list renders (derived from [all] and [filters]).
    @Default(<QuestionModel>[]) List<QuestionModel> visible,
    @Default(QuestionFilters()) QuestionFilters filters,

    /// Questions per category slug, for category rows and the delete guard.
    @Default(<String, int>{}) Map<String, int> countsByCategory,
  }) = _QuestionsState;

  const QuestionsState._();

  Set<String> get qids => {for (final q in all) q.qid};

  QuestionModel? byQid(String qid) {
    for (final question in all) {
      if (question.qid == qid) return question;
    }
    return null;
  }
}
