import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/picked_image_model.dart';
import '../repositories/questions_repository.dart';

/// Uploads a picked image to ImgBB and returns its public URL. Nothing is
/// written to Firestore until the question itself is saved.
@injectable
class UploadQuestionImageUsecase implements UseCase<String, PickedImageModel> {
  UploadQuestionImageUsecase(this._repository);

  final QuestionsRepository _repository;

  @override
  Future<Either<Failure, String>> call(PickedImageModel image) =>
      _repository.uploadImage(bytes: image.bytes, name: image.name);
}
