import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/question_model.dart';
import '../repositories/questions_repository.dart';
import 'question_rules.dart';

class CreateQuestionParams {
  const CreateQuestionParams({
    required this.question,
    required this.existingQids,
    required this.categorySlugs,
  });

  /// The draft; its `qid` is ignored and allocated here.
  final QuestionModel question;
  final Set<String> existingQids;
  final Set<String> categorySlugs;
}

/// Validates, normalizes answers, allocates the next padded `qN` and creates
/// the document in a transaction. If another write took that id meanwhile, it
/// tries the following ids (up to five attempts). Returns the new qid.
@injectable
class CreateQuestionUsecase implements UseCase<String, CreateQuestionParams> {
  CreateQuestionUsecase(this._repository);

  final QuestionsRepository _repository;

  static const _attempts = 5;

  @override
  Future<Either<Failure, String>> call(CreateQuestionParams params) async {
    final errors = QuestionRules.validate(params.question, categorySlugs: params.categorySlugs);
    if (errors.isNotEmpty) {
      return Left(ValidationFailure(message: 'questions.errors.invalid', args: errors));
    }
    final normalized = QuestionRules.normalize(params.question);
    Failure? last;
    for (var attempt = 0; attempt < _attempts; attempt++) {
      final qid = QuestionRules.nextQid(params.existingQids, skip: attempt);
      final result = await _repository.createQuestion(normalized.copyWith(qid: qid));
      final taken = result.fold((failure) {
        last = failure;
        return failure.message == 'questions.errors.qidTaken';
      }, (_) => false);
      if (result.isRight()) return Right(qid);
      if (!taken) break;
    }
    return Left(last ?? const ServerFailure(message: 'errors.unknown'));
  }
}
