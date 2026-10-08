import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/question_model.dart';
import '../repositories/questions_repository.dart';
import 'question_rules.dart';

/// Live question bank, sorted numerically by qid, with the free-trial rows
/// marked the way the students' app picks them.
@injectable
class GetQuestionsUsecase implements StreamUseCase<List<QuestionModel>, NoParams> {
  GetQuestionsUsecase(this._repository);

  final QuestionsRepository _repository;

  @override
  Stream<Either<Failure, List<QuestionModel>>> call(NoParams params) {
    return _repository.questionsChanges().map(
      (result) => result.map((questions) {
        final trial = QuestionRules.trialQids(questions.map((q) => q.qid));
        return [for (final q in questions) q.copyWith(isTrial: trial.contains(q.qid))]
          ..sort((a, b) => QuestionRules.compareQids(a.qid, b.qid));
      }),
    );
  }
}
