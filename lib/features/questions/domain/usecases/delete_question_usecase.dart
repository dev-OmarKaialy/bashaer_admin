import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/questions_repository.dart';

@injectable
class DeleteQuestionUsecase implements UseCase<Unit, String> {
  DeleteQuestionUsecase(this._repository);

  final QuestionsRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String qid) => _repository.deleteQuestion(qid);
}
