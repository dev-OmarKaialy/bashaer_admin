import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/unified_api/error/failure.dart';
import '../models/question_model.dart';

/// Reads and writes `questions/{qid}`.
abstract class RemoteQuestionsDatasource {
  /// Whole collection (about a hundred documents).
  Stream<List<QuestionModel>> questionsChanges();

  /// Creates `questions/{qid}` in a transaction that fails with
  /// `questions.errors.qidTaken` when the id already exists.
  Future<void> createQuestion(QuestionModel question);

  /// Merge-update of the editor's fields only.
  Future<void> updateQuestion(QuestionModel question);

  Future<void> deleteQuestion(String qid);
}

@Injectable(as: RemoteQuestionsDatasource)
class RemoteQuestionsDatasourceImpl implements RemoteQuestionsDatasource {
  RemoteQuestionsDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _questions =>
      _firestore.collection(FirestorePaths.questions);

  @override
  Stream<List<QuestionModel>> questionsChanges() {
    return _questions.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => QuestionModel.fromFirestore(doc.id, doc.data()))
          .toList(growable: false),
    );
  }

  @override
  Future<void> createQuestion(QuestionModel question) async {
    final ref = _questions.doc(question.qid);
    // Returns false instead of throwing inside the handler: on web, errors
    // thrown in a transaction handler come back wrapped by the JS interop.
    final created = await _firestore.runTransaction<bool>((transaction) async {
      final existing = await transaction.get(ref);
      if (existing.exists) return false;
      transaction.set(ref, {
        'qid': question.qid,
        ...question.toEditableFields(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    });
    if (!created) throw const ValidationFailure(message: 'questions.errors.qidTaken');
  }

  @override
  Future<void> updateQuestion(QuestionModel question) {
    return _questions.doc(question.qid).update({
      ...question.toEditableFields(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteQuestion(String qid) => _questions.doc(qid).delete();
}
