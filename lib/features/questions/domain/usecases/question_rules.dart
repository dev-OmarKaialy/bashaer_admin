import 'dart:typed_data';

import '../../data/models/question_model.dart';

/// Pure rules shared by the save use cases and the editor (inline errors).
/// They mirror the seed tool's validation, so the admin can never write a
/// question the seed tool would reject.
class QuestionRules {
  QuestionRules._();

  static const int minAnswers = 2;
  static const int maxAnswers = 8;

  /// How many questions make up the free trial (`GetTrialQuestionsUsecase`).
  static const int trialSize = 5;

  /// Images above this size are rejected before upload.
  static const int maxImageBytes = 8 * 1024 * 1024;

  static const trueId = 'true';
  static const falseId = 'false';

  /// Field → translation key. Empty means valid. Answer errors use
  /// `answer:<id>` keys.
  static Map<String, String> validate(QuestionModel q, {required Set<String> categorySlugs}) {
    final errors = <String, String>{};
    if (q.categorySlug.isEmpty || !categorySlugs.contains(q.categorySlug)) {
      errors['category'] = 'questions.errors.categoryRequired';
    }
    if (q.title.trim().isEmpty) errors['title'] = 'questions.errors.titleRequired';

    if (q.answers.length < minAnswers) {
      errors['answers'] = 'questions.errors.tooFewAnswers';
    } else if (q.type == QuestionType.trueFalse && q.answers.length != 2) {
      errors['answers'] = 'questions.errors.trueFalseAnswers';
    }
    for (final answer in q.answers) {
      if (answer.text.trim().isEmpty && answer.image == null) {
        errors['answer:${answer.id}'] = 'questions.errors.answerEmpty';
      }
    }
    final correct = q.correctAnswerIds.where((id) => q.answers.any((a) => a.id == id)).length;
    if (correct == 0) {
      errors['correct'] = 'questions.errors.noCorrect';
    } else if (correct != 1) {
      errors['correct'] = 'questions.errors.oneCorrect';
    }
    return errors;
  }

  /// Ready-to-write answers: existing ids are kept (students' progress may
  /// reference them), blank ids get the next free `aN`, true/false answers
  /// use the fixed `true`/`false` ids, `isCorrect` mirrors `correctAnswerIds`
  /// (as the seed tool does) and correct ids that no longer exist are dropped.
  static QuestionModel normalize(QuestionModel q) {
    // Old id → new id, so correct answers are remapped by id, never by index.
    final renamed = <String, String>{};
    final answers = <AnswerModel>[];
    final originalIds = q.answers.map((a) => a.id).toSet();
    final isTrueFalse = q.type == QuestionType.trueFalse && q.answers.length == 2;
    if (isTrueFalse && !(originalIds.length == 2 && originalIds.containsAll({trueId, falseId}))) {
      final fixed = [trueId, falseId];
      for (var i = 0; i < 2; i++) {
        renamed[q.answers[i].id] = fixed[i];
        answers.add(q.answers[i].copyWith(id: fixed[i]));
      }
    } else {
      final used = <String>{};
      for (final answer in q.answers) {
        var id = answer.id.trim();
        if (id.isEmpty || used.contains(id)) id = nextAnswerId([...used, ...originalIds]);
        used.add(id);
        renamed[answer.id] = id;
        answers.add(answer.copyWith(id: id));
      }
    }
    final ids = answers.map((a) => a.id).toSet();
    final correct = <String>{
      for (final id in q.correctAnswerIds)
        if (ids.contains(renamed[id] ?? id)) renamed[id] ?? id,
    }.toList();
    return q.copyWith(
      title: q.title.trim(),
      answers: [
        for (final answer in answers)
          answer.copyWith(text: answer.text.trim(), isCorrect: correct.contains(answer.id)),
      ],
      correctAnswerIds: correct,
    );
  }

  /// Next unused `aN` id.
  static String nextAnswerId(Iterable<String> existing) {
    var max = 0;
    final pattern = RegExp(r'^a(\d+)$');
    for (final id in existing) {
      final match = pattern.firstMatch(id);
      if (match != null) {
        final n = int.parse(match.group(1)!);
        if (n > max) max = n;
      }
    }
    return 'a${max + 1}';
  }

  /// Next `q` id: highest `qN` + 1 ([skip] more for retries), padded to the
  /// widest existing width (seed ids are `q01`…). Other prefixes (`ts01`) are
  /// ignored.
  static String nextQid(Iterable<String> existing, {int skip = 0}) {
    var max = 0;
    var width = 2;
    final pattern = RegExp(r'^q(\d+)$');
    for (final id in existing) {
      final match = pattern.firstMatch(id);
      if (match == null) continue;
      final digits = match.group(1)!;
      final n = int.parse(digits);
      if (n > max) max = n;
      if (digits.length > width) width = digits.length;
    }
    return 'q${(max + 1 + skip).toString().padLeft(width, '0')}';
  }

  /// Students sort by `qid` lexicographically; an id longer than the others
  /// (`q100` next to `q99`) sorts out of numeric order in their app.
  static bool breaksStudentOrder(String qid, Iterable<String> existing) {
    final pattern = RegExp(r'^q(\d+)$');
    final match = pattern.firstMatch(qid);
    if (match == null) return false;
    final width = match.group(1)!.length;
    return existing.any((id) {
      final other = pattern.firstMatch(id);
      return other != null && other.group(1)!.length < width;
    });
  }

  /// Numeric-aware order for the admin list: prefix, then number.
  static int compareQids(String a, String b) {
    final pattern = RegExp(r'^([^\d]*)(\d+)$');
    final ma = pattern.firstMatch(a);
    final mb = pattern.firstMatch(b);
    if (ma == null || mb == null) return a.compareTo(b);
    final byPrefix = ma.group(1)!.compareTo(mb.group(1)!);
    if (byPrefix != 0) return byPrefix;
    return int.parse(ma.group(2)!).compareTo(int.parse(mb.group(2)!));
  }

  /// The free-trial qids: first [trialSize] in the students' order
  /// (`a.id.compareTo(b.id)`).
  static Set<String> trialQids(Iterable<String> qids) {
    final sorted = qids.toList()..sort((a, b) => a.compareTo(b));
    return sorted.take(trialSize).toSet();
  }

  /// PNG, JPEG, GIF, WebP or BMP by signature (not by file name).
  static bool isSupportedImage(Uint8List bytes) {
    bool startsWith(List<int> signature, [int offset = 0]) {
      if (bytes.length < offset + signature.length) return false;
      for (var i = 0; i < signature.length; i++) {
        if (bytes[offset + i] != signature[i]) return false;
      }
      return true;
    }

    return startsWith(const [0x89, 0x50, 0x4E, 0x47]) || // PNG
        startsWith(const [0xFF, 0xD8, 0xFF]) || // JPEG
        startsWith(const [0x47, 0x49, 0x46, 0x38]) || // GIF
        (startsWith(const [0x52, 0x49, 0x46, 0x46]) &&
            startsWith(const [0x57, 0x45, 0x42, 0x50], 8)) ||
        startsWith(const [0x42, 0x4D]); // BMP
  }
}
