import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/question_model.dart';
import '../repositories/questions_repository.dart';
import 'question_rules.dart';

class UpdateQuestionParams {
  const UpdateQuestionParams({required this.question, required this.categorySlugs});

  final QuestionModel question;
  final Set<String> categorySlugs;
}

/// Validates, normalizes answers and merge-updates the editor's fields only.
@injectable
class UpdateQuestionUsecase implements UseCase<Unit, UpdateQuestionParams> {
  UpdateQuestionUsecase(this._repository);

  final QuestionsRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateQuestionParams params) async {
    final errors = QuestionRules.validate(params.question, categorySlugs: params.categorySlugs);
    if (errors.isNotEmpty) {
      return Left(ValidationFailure(message: 'questions.errors.invalid', args: errors));
    }
    return _repository.updateQuestion(QuestionRules.normalize(params.question));
  }
}
