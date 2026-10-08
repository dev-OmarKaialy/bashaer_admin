part of 'question_editor_cubit.dart';

enum QuestionEditorAction { save, delete, image }

@freezed
abstract class QuestionEditorOutcome with _$QuestionEditorOutcome {
  const factory QuestionEditorOutcome({
    required int seq,
    required QuestionEditorAction action,
    String? errorKey,

    /// After creating: the allocated qid.
    String? createdQid,
  }) = _QuestionEditorOutcome;
}

@freezed
abstract class QuestionEditorState with _$QuestionEditorState {
  const factory QuestionEditorState({
    /// The saved question; null while creating.
    QuestionModel? original,

    /// What "unchanged" looks like (the original, or the empty new draft).
    @Default(QuestionModel(qid: '')) QuestionModel baseline,
    @Default(QuestionModel(qid: '')) QuestionModel draft,

    /// qid the new question will most likely get (shown in the title).
    @Default('') String nextQid,

    /// The next qid is wider than existing ones, so it sorts out of numeric
    /// order in the students' app.
    @Default(false) bool qidBreaksOrder,

    /// Field → translation key. Shown once a save was attempted.
    @Default(<String, String>{}) Map<String, String> errors,
    @Default(false) bool showErrors,
    @Default(RequestStatus.init) RequestStatus imageStatus,
    @Default(RequestStatus.init) RequestStatus submitStatus,
    @Default(RequestStatus.init) RequestStatus deleteStatus,
    QuestionEditorOutcome? lastOutcome,
  }) = _QuestionEditorState;

  const QuestionEditorState._();

  bool get isNew => original == null;

  bool get isDirty => draft != baseline;

  bool get isBusy => submitStatus.isLoading || deleteStatus.isLoading;

  bool get isUploading => imageStatus.isLoading;

  String? errorOf(String field) => showErrors ? errors[field] : null;
}
