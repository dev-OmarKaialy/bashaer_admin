import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/question_model.dart';
import '../../domain/usecases/create_question_usecase.dart';
import '../../domain/usecases/delete_question_usecase.dart';
import '../../domain/usecases/get_picked_image_usecase.dart';
import '../../domain/usecases/question_rules.dart';
import '../../domain/usecases/update_question_usecase.dart';
import '../../domain/usecases/upload_question_image_usecase.dart';

part 'question_editor_cubit.freezed.dart';
part 'question_editor_state.dart';

/// Create or edit one question: draft, validation, optional image upload,
/// merge-save and delete.
@injectable
class QuestionEditorCubit extends Cubit<QuestionEditorState> {
  QuestionEditorCubit(this._create, this._update, this._delete, this._pickImage, this._uploadImage)
    : super(const QuestionEditorState());

  final CreateQuestionUsecase _create;
  final UpdateQuestionUsecase _update;
  final DeleteQuestionUsecase _delete;
  final GetPickedImageUsecase _pickImage;
  final UploadQuestionImageUsecase _uploadImage;

  Set<String> _existingQids = const {};
  Set<String> _categorySlugs = const {};
  int _seq = 0;

  /// Default texts of true/false answers, as in the seeded bank.
  static const trueText = 'صح';
  static const falseText = 'خطأ';

  /// [question] null = new question, preset with [categorySlug] and [type].
  void open({
    QuestionModel? question,
    required Set<String> existingQids,
    required Set<String> categorySlugs,
    String? categorySlug,
    QuestionType? type,
  }) {
    _existingQids = existingQids;
    _categorySlugs = categorySlugs;
    if (question != null) {
      emit(QuestionEditorState(original: question, baseline: question, draft: question));
      return;
    }
    final kind = type ?? QuestionType.singleChoice;
    final draft = QuestionModel(
      qid: '',
      categorySlug: categorySlug ?? '',
      type: kind,
      answers: _defaultAnswers(kind),
    );
    final nextQid = QuestionRules.nextQid(existingQids);
    emit(
      QuestionEditorState(
        baseline: draft,
        draft: draft,
        nextQid: nextQid,
        qidBreaksOrder: QuestionRules.breaksStudentOrder(nextQid, existingQids),
      ),
    );
  }

  /// Categories can finish loading after the editor opened.
  void setCategorySlugs(Set<String> slugs) {
    _categorySlugs = slugs;
    if (state.showErrors) _setDraft(state.draft);
  }

  static List<AnswerModel> _defaultAnswers(QuestionType type) => type == QuestionType.trueFalse
      ? const [
          AnswerModel(id: QuestionRules.trueId, text: trueText),
          AnswerModel(id: QuestionRules.falseId, text: falseText),
        ]
      : const [AnswerModel(id: 'a1'), AnswerModel(id: 'a2')];

  void _setDraft(QuestionModel draft) {
    emit(
      state.copyWith(
        draft: draft,
        errors: state.showErrors
            ? QuestionRules.validate(draft, categorySlugs: _categorySlugs)
            : state.errors,
      ),
    );
  }

  void setCategory(String? slug) => _setDraft(state.draft.copyWith(categorySlug: slug ?? ''));

  void setTitle(String value) => _setDraft(state.draft.copyWith(title: value));

  void setHint(String value) => _setDraft(state.draft.copyWith(hint: value.isEmpty ? null : value));

  /// Whether switching to [type] would throw away typed answer texts.
  bool typeChangeLosesAnswers(QuestionType type) {
    final draft = state.draft;
    if (type == draft.type) return false;
    if (type != QuestionType.trueFalse && draft.type != QuestionType.trueFalse) return false;
    if (draft.type == QuestionType.trueFalse) return false;
    return draft.answers.any((a) => a.text.trim().isNotEmpty);
  }

  void setType(QuestionType type) {
    final draft = state.draft;
    if (type == draft.type) return;
    if (type == QuestionType.trueFalse || draft.type == QuestionType.trueFalse) {
      _setDraft(
        draft.copyWith(type: type, answers: _defaultAnswers(type), correctAnswerIds: const []),
      );
      return;
    }
    // single ↔ multiple keeps the answers; single keeps at most one correct.
    final correct = type == QuestionType.singleChoice && draft.correctAnswerIds.length > 1
        ? [draft.correctAnswerIds.first]
        : draft.correctAnswerIds;
    _setDraft(draft.copyWith(type: type, correctAnswerIds: correct));
  }

  void setAnswerText(String id, String text) {
    _setDraft(
      state.draft.copyWith(
        answers: [
          for (final answer in state.draft.answers)
            answer.id == id ? answer.copyWith(text: text) : answer,
        ],
      ),
    );
  }

  void toggleCorrect(String id) {
    final draft = state.draft;
    final List<String> correct;
    {
      correct = [id];
    }
    _setDraft(draft.copyWith(correctAnswerIds: correct));
  }

  bool get canAddAnswer =>
      state.draft.type != QuestionType.trueFalse &&
      state.draft.answers.length < QuestionRules.maxAnswers;

  bool get canRemoveAnswer =>
      state.draft.type != QuestionType.trueFalse &&
      state.draft.answers.length > QuestionRules.minAnswers;

  /// Returns the new answer's id (the UI focuses it).
  String? addAnswer() {
    if (!canAddAnswer) return null;
    final id = QuestionRules.nextAnswerId(state.draft.answers.map((a) => a.id));
    _setDraft(
      state.draft.copyWith(
        answers: [
          ...state.draft.answers,
          AnswerModel(id: id),
        ],
      ),
    );
    return id;
  }

  /// Removes an answer; returns what [restoreAnswer] needs for undo.
  (int, AnswerModel, bool)? removeAnswer(String id) {
    if (!canRemoveAnswer) return null;
    final draft = state.draft;
    final index = draft.answers.indexWhere((a) => a.id == id);
    if (index < 0) return null;
    final removed = draft.answers[index];
    final wasCorrect = draft.correctAnswerIds.contains(id);
    _setDraft(
      draft.copyWith(
        answers: [...draft.answers]..removeAt(index),
        correctAnswerIds: [...draft.correctAnswerIds.where((c) => c != id)],
      ),
    );
    return (index, removed, wasCorrect);
  }

  void restoreAnswer((int, AnswerModel, bool) removed) {
    final (index, answer, wasCorrect) = removed;
    final draft = state.draft;
    if (draft.answers.any((a) => a.id == answer.id)) return;
    final answers = [...draft.answers]..insert(index.clamp(0, draft.answers.length), answer);
    _setDraft(
      draft.copyWith(
        answers: answers,
        correctAnswerIds: wasCorrect ? ([answer.id]) : draft.correctAnswerIds,
      ),
    );
  }

  /// Pick → validate → upload. The URL lands in the draft only; Firestore is
  /// written when the question is saved, so a cancelled edit stores nothing.
  Future<void> pickAndUploadImage() async {
    if (state.isUploading) return;
    emit(state.copyWith(imageStatus: RequestStatus.loading));
    final picked = await _pickImage(const NoParams());
    if (isClosed) return;
    final image = picked.fold((failure) {
      _imageFailed(failure);
      return null;
    }, (image) => image);
    if (image == null) {
      if (state.imageStatus.isLoading) emit(state.copyWith(imageStatus: RequestStatus.init));
      return;
    }
    final uploaded = await _uploadImage(image);
    if (isClosed) return;
    uploaded.fold(_imageFailed, (url) {
      emit(
        state.copyWith(
          imageStatus: RequestStatus.success,
          draft: state.draft.copyWith(image: url),
        ),
      );
    });
  }

  void _imageFailed(Failure failure) {
    emit(
      state.copyWith(
        imageStatus: RequestStatus.failed,
        lastOutcome: QuestionEditorOutcome(
          seq: ++_seq,
          action: QuestionEditorAction.image,
          errorKey: failure.message,
        ),
      ),
    );
  }

  /// Pasted link (fallback when uploads are unavailable). Returns false when
  /// it isn't an http(s) URL.
  bool setImageUrl(String url) {
    final value = url.trim();
    final uri = Uri.tryParse(value);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https')) || uri.host.isEmpty) {
      return false;
    }
    _setDraft(state.draft.copyWith(image: value));
    return true;
  }

  void removeImage() => _setDraft(state.draft.copyWith(image: null));

  Future<void> save() async {
    if (state.isBusy) return;
    final errors = QuestionRules.validate(state.draft, categorySlugs: _categorySlugs);
    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          showErrors: true,
          errors: errors,
          lastOutcome: QuestionEditorOutcome(
            seq: ++_seq,
            action: QuestionEditorAction.save,
            errorKey: 'questions.errors.invalid',
          ),
        ),
      );
      return;
    }
    emit(state.copyWith(submitStatus: RequestStatus.loading, showErrors: true, errors: const {}));
    if (state.isNew) {
      final result = await _create(
        CreateQuestionParams(
          question: state.draft,
          existingQids: _existingQids,
          categorySlugs: _categorySlugs,
        ),
      );
      if (isClosed) return;
      result.fold(_saveFailed, (qid) {
        final saved = QuestionRules.normalize(state.draft).copyWith(qid: qid);
        _existingQids = {..._existingQids, qid};
        emit(
          state.copyWith(
            submitStatus: RequestStatus.success,
            original: saved,
            baseline: saved,
            draft: saved,
            lastOutcome: QuestionEditorOutcome(
              seq: ++_seq,
              action: QuestionEditorAction.save,
              createdQid: qid,
            ),
          ),
        );
      });
      return;
    }
    final result = await _update(
      UpdateQuestionParams(question: state.draft, categorySlugs: _categorySlugs),
    );
    if (isClosed) return;
    result.fold(_saveFailed, (_) {
      final saved = QuestionRules.normalize(state.draft);
      emit(
        state.copyWith(
          submitStatus: RequestStatus.success,
          original: saved,
          baseline: saved,
          draft: saved,
          lastOutcome: QuestionEditorOutcome(seq: ++_seq, action: QuestionEditorAction.save),
        ),
      );
    });
  }

  void _saveFailed(Failure failure) {
    emit(
      state.copyWith(
        submitStatus: RequestStatus.failed,
        errors: failure is ValidationFailure ? failure.args : state.errors,
        lastOutcome: QuestionEditorOutcome(
          seq: ++_seq,
          action: QuestionEditorAction.save,
          errorKey: failure.message,
        ),
      ),
    );
  }

  Future<void> delete() async {
    final original = state.original;
    if (original == null || state.isBusy) return;
    emit(state.copyWith(deleteStatus: RequestStatus.loading));
    final result = await _delete(original.qid);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteStatus: RequestStatus.failed,
          lastOutcome: QuestionEditorOutcome(
            seq: ++_seq,
            action: QuestionEditorAction.delete,
            errorKey: failure.message,
          ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          deleteStatus: RequestStatus.success,
          lastOutcome: QuestionEditorOutcome(seq: ++_seq, action: QuestionEditorAction.delete),
        ),
      ),
    );
  }
}
