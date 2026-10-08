import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/arabic_normalizer.dart';

part 'question_model.freezed.dart';

/// Question kinds, with the values stored in Firestore.
enum QuestionType {
  singleChoice('single_choice'),
  trueFalse('true_false');

  const QuestionType(this.value);

  final String value;

  /// Same fallback as the students' app: unknown → single choice.
  static QuestionType fromValue(Object? raw) => QuestionType.values.firstWhere(
    (type) => type.value == raw?.toString(),
    orElse: () => QuestionType.singleChoice,
  );
}

@freezed
abstract class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    required String id,
    @Default('') String text,
    @Default(false) bool isCorrect,

    /// Per-answer media and notes exist in seeded data. The editor does not
    /// show them but always writes them back unchanged.
    String? image,
    String? description,
  }) = _AnswerModel;

  const AnswerModel._();

  factory AnswerModel.fromFirestore(Map<String, dynamic> data) => AnswerModel(
    id: data['id']?.toString() ?? '',
    text: data['text']?.toString() ?? '',
    isCorrect: data['isCorrect'] == true,
    image: mediaUrlOf(data['image']),
    description: (data['description'] as String?)?.trim(),
  );

  Map<String, dynamic> toFirestore() => {
    'id': id,
    'text': text.trim(),
    'isCorrect': isCorrect,
    'image': image,
    if (description != null) 'description': description,
  };
}

/// One `questions/{qid}` row, limited to what the admin edits. Saves write only
/// [toEditableFields], so fields the admin no longer manages (`description`,
/// `explanation`, `difficulty`, `points`, `audio`) keep their stored values.
@freezed
abstract class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String qid,
    @Default('') String categorySlug,
    @Default(QuestionType.singleChoice) QuestionType type,
    @Default('') String title,
    String? image,
    @Default(<AnswerModel>[]) List<AnswerModel> answers,
    @Default(<String>[]) List<String> correctAnswerIds,
    String? hint,
    DateTime? createdAt,
    DateTime? updatedAt,

    /// In memory only: folded title + qid for search.
    @Default('') String searchKey,

    /// In memory only: among the first five by the students' (lexicographic)
    /// qid order, i.e. part of the free trial.
    @Default(false) bool isTrial,
  }) = _QuestionModel;

  const QuestionModel._();

  factory QuestionModel.fromFirestore(String id, Map<String, dynamic> data) {
    final qid = data['qid'];
    final title = data['title']?.toString() ?? '';
    final resolvedQid = qid is String && qid.isNotEmpty ? qid : id;
    return QuestionModel(
      qid: resolvedQid,
      categorySlug: data['categorySlug']?.toString() ?? '',
      type: QuestionType.fromValue(data['type']),
      title: title,
      image: mediaUrlOf(data['image']),
      answers: [
        for (final answer in (data['answers'] as List<dynamic>? ?? const []))
          if (answer is Map) AnswerModel.fromFirestore(Map<String, dynamic>.from(answer)),
      ],
      correctAnswerIds: [
        for (final id in (data['correctAnswerIds'] as List<dynamic>? ?? const [])) id.toString(),
      ],
      hint: _text(data['hint']),
      createdAt: data['createdAt'] is Timestamp ? (data['createdAt'] as Timestamp).toDate() : null,
      updatedAt: data['updatedAt'] is Timestamp ? (data['updatedAt'] as Timestamp).toDate() : null,
      searchKey: normalizeForSearch('$resolvedQid $title'),
    );
  }

  /// The fields the editor owns. Answers are written as a whole array (Firestore
  /// can't merge array items), carrying each answer's image/description along.
  Map<String, dynamic> toEditableFields() => {
    'categorySlug': categorySlug,
    'type': type.value,
    'title': title.trim(),
    'image': image,
    'answers': [for (final answer in answers) answer.toFirestore()],
    'correctAnswerIds': correctAnswerIds,
    'hint': _clean(hint),
  };

  static String? _text(Object? raw) {
    if (raw is! String) return null;
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  static String? _clean(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? null : text;
  }
}

/// A plain URL string, or a legacy `{ url, ... }` map (same as the students'
/// app `_mediaUrl`).
String? mediaUrlOf(Object? raw) {
  if (raw is String) {
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }
  if (raw is Map) {
    final url = raw['url'];
    if (url is String && url.trim().isNotEmpty) return url.trim();
  }
  return null;
}
