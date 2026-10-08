import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/error_handeler.dart';
import '../../../../core/unified_api/error/failure.dart';
import '../../domain/repositories/questions_repository.dart';
import '../datasources/image_picker_local_datasource.dart';
import '../datasources/image_upload_remote_datasource.dart';
import '../datasources/questions_remote_datasource.dart';
import '../models/picked_image_model.dart';
import '../models/question_model.dart';

@Injectable(as: QuestionsRepository)
class QuestionsRepositoryImpl with HandlingException implements QuestionsRepository {
  QuestionsRepositoryImpl(this._remote, this._upload, this._picker);

  final RemoteQuestionsDatasource _remote;
  final RemoteImageUploadDatasource _upload;
  final LocalImagePickerDatasource _picker;

  @override
  Stream<Either<Failure, List<QuestionModel>>> questionsChanges() =>
      wrapStream(_remote.questionsChanges);

  @override
  Future<Either<Failure, Unit>> createQuestion(QuestionModel question) => wrapHandling(
    tryCall: () async {
      await _remote.createQuestion(question);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> updateQuestion(QuestionModel question) => wrapHandling(
    tryCall: () async {
      await _remote.updateQuestion(question);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> deleteQuestion(String qid) => wrapHandling(
    tryCall: () async {
      await _remote.deleteQuestion(qid);
      return unit;
    },
  );

  @override
  Future<Either<Failure, PickedImageModel?>> pickImage() =>
      wrapHandling(tryCall: _picker.pickImage);

  @override
  Future<Either<Failure, String>> uploadImage({required Uint8List bytes, required String name}) =>
      wrapHandling(
        tryCall: () => _upload.uploadImage(bytes: bytes, name: name),
      );
}
