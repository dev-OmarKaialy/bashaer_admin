import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../data/models/picked_image_model.dart';
import '../../data/models/question_model.dart';

abstract class QuestionsRepository {
  Stream<Either<Failure, List<QuestionModel>>> questionsChanges();

  Future<Either<Failure, Unit>> createQuestion(QuestionModel question);

  Future<Either<Failure, Unit>> updateQuestion(QuestionModel question);

  Future<Either<Failure, Unit>> deleteQuestion(String qid);

  Future<Either<Failure, PickedImageModel?>> pickImage();

  Future<Either<Failure, String>> uploadImage({required Uint8List bytes, required String name});
}
