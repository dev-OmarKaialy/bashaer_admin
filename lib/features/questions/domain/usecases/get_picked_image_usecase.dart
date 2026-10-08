import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/picked_image_model.dart';
import '../repositories/questions_repository.dart';
import 'question_rules.dart';

/// Lets the admin pick an image and checks it before anything is uploaded:
/// a real image by its signature, at most 8 MB. Null when cancelled.
@injectable
class GetPickedImageUsecase implements UseCase<PickedImageModel?, NoParams> {
  GetPickedImageUsecase(this._repository);

  final QuestionsRepository _repository;

  @override
  Future<Either<Failure, PickedImageModel?>> call(NoParams params) async {
    final picked = await _repository.pickImage();
    return picked.fold(Left.new, (image) {
      if (image == null) return const Right(null);
      if (!QuestionRules.isSupportedImage(image.bytes)) {
        return const Left(ValidationFailure(message: 'questions.errors.notAnImage'));
      }
      if (image.bytes.length > QuestionRules.maxImageBytes) {
        return const Left(ValidationFailure(message: 'questions.errors.imageTooLarge'));
      }
      return Right(image);
    });
  }
}
